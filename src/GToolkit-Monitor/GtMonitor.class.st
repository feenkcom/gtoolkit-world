Class {
	#name : #GtMonitor,
	#superclass : #Object,
	#category : #'GToolkit-Monitor'
}

{ #category : #printing }
GtMonitor class >> printExternalResourcesOn: aTranscript [
	| allExternalResources |
	
	aTranscript
		nextPutAll: '========================='; cr;
		nextPutAll: '   External resources'; cr;
		nextPutAll: '========================='; cr.
	allExternalResources := GtMonitoredExternalResourcesElement allExternalResources.
	allExternalResources do: [ :eachExternalResouce |
		aTranscript nextPutAll: eachExternalResouce name; cr ].
]

{ #category : #printing }
GtMonitor class >> printProcessesOn: aTranscript [
	| allProcesses |
	
	aTranscript
		nextPutAll: '========================='; cr;
		nextPutAll: '        Processes'; cr;
		nextPutAll: '========================='; cr.

	allProcesses := Process allSubInstances sorted: [ :a :b | a priority > b priority ].
	allProcesses do: [ :eachProcess |
		aTranscript
			nextPutAll: ('Process ({1}) named ' format: { eachProcess priority });
			nextPutAll: eachProcess gtName asString printString;
			cr ].
]

{ #category : #printing }
GtMonitor class >> printRuntimeInfo [
	| aTranscript |
	
	aTranscript := NonInteractiveTranscript stdout.
	self printExternalResourcesOn: aTranscript.
	self printSpacesOn: aTranscript.
	self printProcessesOn: aTranscript
]

{ #category : #printing }
GtMonitor class >> printSpacesOn: aTranscript [
	| allSpaces |
	
	aTranscript
		nextPutAll: '========================='; cr;
		nextPutAll: '         Spaces'; cr;
		nextPutAll: '========================='; cr.

	allSpaces := BlSpace allSubInstances sorted: [ :a :b | a id < b id ].
	allSpaces do: [ :eachSpace |
		aTranscript
			nextPutAll: eachSpace class name;
			nextPutAll: ' titled ';
			nextPutAll: eachSpace title printString;
			nextPutAll: ' with id ';
			nextPutAll: eachSpace id printString;
			cr ].
]

{ #category : #accessing }
GtMonitor >> gtActionProfilerFor: anAction [
	<gtAction>
	^ anAction button 
		icon: BrGlamorousVectorIcons performance;
		priority: 2;
		tooltip: 'Profiler';
		action: [ GtProfiler open ]
]

{ #category : #accessing }
GtMonitor >> gtActionTelemetryFor: anAction [
	<gtAction>
	^ anAction button 
		icon: [ (BrGlamorousVectorIcons largeSignal asElement asScalableElement size: 16@16) ] asStencil;
		priority: 1;
		tooltip: 'Telemetry';
		action: [ :aButton | aButton phlow spawnTool: GtProfilerProcessTelemetriesTool new ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtExternalResourcesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'External resources';
		priority: 8;
		stencil: [ GtMonitoredExternalResourcesElement new ];
		actionStencil: [ :aTab |
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons trash;
				label: 'Garbage collect';
				action:  [ Smalltalk garbageCollect ] ];
		actionStencil: [ :aTab |
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons refresh;
				label: 'Refresh';
				action:  [ aTab viewContentElement children first updateList ] ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtFutureWorkersPoolFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Future workers';
		priority: 45;
		object: [ AsyncFutureThreadPool current ];
		view: #gtWorkersFor:
]

{ #category : #'gt-extension' }
GtMonitor >> gtGlutinEventFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Events';
		priority: 3;
		stencil: [ GtMonitorGlutinEventsElement new ]
]

{ #category : #accessing }
GtMonitor >> gtKeyboardFor: aView [
	<gtView>
	^ aView explicit
		title: 'Keyboard';
		priority: 3.1;
		stencil: [ BlDevKeyboard new asScalableElement ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtLoggersFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Loggers';
		priority: 6;
		stencil: [ GtMonitoredSignalLoggersElement new ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons trash asElement;
				action:  [ :aButton |
					SignalLogger allSubInstances
						do: [ :eachLogger | eachLogger stop; reset ].
					Smalltalk garbageCollect ] ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtMixedAnnouncersFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Mixed announcers';
		priority: 7;
		stencil: [ GtMonitoredMixedAnnouncersElement new ];
		actionStencil: [ :aTab |
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons trash;
				label: 'Reset all';
				action:  [
					GtMonitoredMixedAnnouncersElement allMixedAnnouncers do: [ :each | each makeStrong; removeSubscriptions ].
					aTab viewContentElement children first updateList ] ];
		actionStencil: [ :aTab |
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: [ BrGlamorousVectorIcons largeSignal asElement asScalableElement size: 16@16 ] asStencil;
				label: 'Make weak all';
				action:  [
					GtMonitoredMixedAnnouncersElement allMixedAnnouncers do: [ :each | each makeWeak ].
					aTab viewContentElement  updateList ] ];
		actionUpdateButtonTooltip: 'Update mixed announcers list'
]

{ #category : #'gt-extension' }
GtMonitor >> gtProcessesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Processes';
		priority: 5;
		stencil: [ GtMonitoredProcessesElement new ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtScriptersFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Scripters';
		priority: 47;
		stencil: [ GtMonitoredScripterPulsersElement new ];
		actionUpdateButtonTooltip: 'Update scripter list';
		actionButtonIcon: BrGlamorousIcons trash 
			tooltip: 'Remove all example and test caches' 
			action: [ :aButton | 
				CompiledMethod allInstancesDo: #clearExampleAndTestCaches.
				Smalltalk garbageCollect ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtSpaceRunnerFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Space runner';
		priority: 20;
		stencil: [ GtMonitorSpaceRunner new ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtSpacesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Spaces';
		priority: 2;
		stencil: [ GtMonitoredBlocSpacesElement new ];
		actionStencil: [ :aTab |
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons refresh asElement;
				label: 'Refresh';
				action:  [
					Smalltalk garbageCollect.
					aTab viewContentElement updateList ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons trash asElement;
				label: 'Close all spaces';
				action:  [ :aButton |
					(BlSpace allSubInstances copyWithout: aButton space) do: [ :eachSpace |
						eachSpace isOpened
							ifTrue: [ eachSpace close ] ].
					Smalltalk garbageCollect ] ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtSystemInfoFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'System';
		priority: 1;
		stencil: [ GtMonitorSystemInfoElement new ];
		actionStencil: [ :aTab |
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons refresh asElement;
				label: 'Refresh';
				action:  [
					Smalltalk garbageCollect.
					aTab viewContentElement children first updateSystemInfo ] ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtTaskItServicesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Services';
		priority: 4;
		tooltip: 'TaskIt Services';
		stencil: [ GtMonitoredTaskItServicesElement new ];
		actionButtonIcon: BrGlamorousIcons trash 
			tooltip: 'Remove not running services'
			action: [ :aButton | TKTConfiguration serviceManager purge ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtUniversesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Universes';
		priority: 2;
		stencil: [ GtMonitoredUniversesElement new ]
]
