Class {
	#name : #GtMonitoredScripterPulser,
	#superclass : #Object,
	#instVars : [
		'pulser'
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
			action: [ :aButton | self pulser ifNotNil: [ :aPulser | aButton phlow spawnObject: aPulser scripter ] ]
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
