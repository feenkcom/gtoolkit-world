Class {
	#name : #GtMonitoredScripterPulser,
	#superclass : #Object,
	#instVars : [
		'pulser',
		'example'
	],
	#category : #'GToolkit-Monitor-Scripter'
}

{ #category : #accessing }
GtMonitoredScripterPulser >> allPathsTo [
	Smalltalk garbageCollectMost.

	^ self pulser
		ifNotNil: [ :aPulser | (ReferenceFinder findAllPathsTo: aPulser) sorted: [ :a :b | a size < b size ] ]
		ifNil: [ {  } ]
]

{ #category : #accessing }
GtMonitoredScripterPulser >> children [
	^ #()
]

{ #category : #accessing }
GtMonitoredScripterPulser >> example [
	"Return example that keeps the Scripter"

	<return: #GtExampleWithResult or: nil>
	^ example
		ifNotNil: [ :aWeak | 
			(aWeak at: 1)
				ifNotNil: [ :anExampleWithResult | 
					(anExampleWithResult isSuccess
						and: [ anExampleWithResult result returnValue == self scripter ])
						ifTrue: [ anExampleWithResult ]
						ifFalse: [ nil ] ] ]
]

{ #category : #accessing }
GtMonitoredScripterPulser >> example: anExampleWithResultOrNil [
	example := anExampleWithResultOrNil asWeakReference
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtActionStopFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons stop;
		tooltip: 'Stop a pulsing Scripter pulser';
		action: [ :aButton | self pulserDo: #stop ]
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtAllPathsToFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'All paths';
		priority: 12;
		items: [ self allPathsTo ];
		column: 'Paths from Smalltalk' 
			text: [ :anObject | anObject gtDisplayText ];
		column: 'Length' 
			text: [ :anObject | anObject size ]
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtPathToFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Path';
		priority: 11;
		items: [ self pathTo ];
		column: 'Path from Smalltalk' 
			text: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		priority: 10;
		items: [ self pointers ];
		column: 'Pointers' 
			text: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtPulserPulseMethodFor: aView [
	<gtView>
	^ aView forward
		title: 'Source code';
		priority: 5;
		object: [ self pulser ifNil: [ BlDevScripterPulseUntilReady new ] ];
		view: #gtPulseMethodFor:
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtScripterExampleFor: aView [
	<gtView>
	^ aView forward
		title: 'Example';
		priority: 7;
		object: [ self example ifNil: [ GtExampleWithResult new ] ];
		view: #gtSourceFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Example'
			tooltip: 'Inspect example'
			action: [ :aButton | 
				self example
					ifNotNil: [ :anExampleWithResult | aButton phlow spawnObject: anExampleWithResult example ] ]
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtScripterPreviewFor: aView [
	<gtView>
	^ self pulser
		ifNil: [ aView empty ]
		ifNotNil: [ :aPulser | aPulser gtStepsMondrianTreeFor: aView ]
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtScripterSpacePreview: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self pulser
				ifNotNil: [ :aPulser | aPulser scripter gtSpacePreview ]
				ifNil: [ BlElement new ] ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Scripter'
			tooltip: 'Inspect scripter'
			action: [ :aButton | self pulser ifNotNil: [ :aPulser | aButton phlow spawnObject: aPulser scripter ] ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Pulser'
			tooltip: 'Inspect scripter pulser'
			action: [ :aButton | self pulser ifNotNil: [ :aPulser | aButton phlow spawnObject: aPulser ] ]
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtSpaceActiveTasksFor: aView [
	<gtView>
	^ aView forward
		title: 'Active space tasks';
		priority: 4;
		object: [ self pulser ifNil: [ BlDevScripterPulseUntilReady new ] ];
		view: #gtSpaceActiveTasksFor:
]

{ #category : #'gt-extension' }
GtMonitoredScripterPulser >> gtSpacePendingTasksFor: aView [
	<gtView>
	^ aView forward
		title: 'Pending space tasks';
		priority: 3;
		object: [ self pulser ifNil: [ BlDevScripterPulseUntilReady new ] ];
		view: #gtSpacePendingTasksFor:
]

{ #category : #accessing }
GtMonitoredScripterPulser >> pathTo [
	Smalltalk garbageCollectMost.

	^ self pulser
		ifNotNil: [ :aPulser |  ReferenceFinder findPathTo: aPulser ]
		ifNil: [ {  } ]
]

{ #category : #accessing }
GtMonitoredScripterPulser >> pointers [
	Smalltalk garbageCollectMost.

	^ self pulser
		ifNotNil: [ :aPulser | aPulser pointersTo reject: [ :eachObject | eachObject isKindOf: WeakArray ] ]
		ifNil: [ {  } ]
]

{ #category : #accessing }
GtMonitoredScripterPulser >> pulser [
	<return: #BlDevScripterPulseUntilReady or: nil>
	^ pulser at: 1
]

{ #category : #accessing }
GtMonitoredScripterPulser >> pulser: aBlDevScripterPulseUntilReady [
	pulser := aBlDevScripterPulseUntilReady asWeakReference
]

{ #category : #accessing }
GtMonitoredScripterPulser >> pulserDo: aBlock [
	self pulser ifNotNil: aBlock
]

{ #category : #accessing }
GtMonitoredScripterPulser >> scripter [
	<return: #BlScripter or: nil>
	^ self pulser ifNotNil: #scripter
]

{ #category : #accessing }
GtMonitoredScripterPulser >> startTime [
	<return: #Duration or: nil>
	| aPulser |
	
	aPulser := self pulser ifNil: [ ^ nil ].
	
	^ aPulser startTime
]

{ #category : #accessing }
GtMonitoredScripterPulser >> status [
	<return: #BlText>
	| aPulser |
	
	aPulser := self pulser ifNil: [ ^ '' ].
	
	aPulser hasFinished ifTrue: [ 
		^ 'finished' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].

	aPulser hasStarted ifFalse: [ 
		^ 'not started' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
	
	aPulser elapsedTime ifNotNil: [ :aDuration |
		| aText |
		aText := aDuration gtHumanReadableString asRopedText.
		aPulser isLikelyLockedUp
			ifTrue: [ aText foreground: BrGlamorousColors errorBackgroundColor ]
			ifFalse: [ aText foreground: BrGlamorousColors failureBackgroundColor ] ].
	
	^ 'running' asRopedText foreground: BrGlamorousColors failureBackgroundColor
]

{ #category : #accessing }
GtMonitoredScripterPulser >> title [
	<return: #BlText>
	| aPulser |
	
	aPulser := self pulser ifNil: [ ^ '' ].
	
	^ aPulser stepDefiningMethod asString
]
