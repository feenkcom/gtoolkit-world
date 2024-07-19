Class {
	#name : #GtMonitoredScripter,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'pulsers',
		'example'
	],
	#category : #'GToolkit-Monitor-Scripter'
}

{ #category : #accessing }
GtMonitoredScripter >> children [
	^ pulsers ifNil: [ #() ]
]

{ #category : #accessing }
GtMonitoredScripter >> example [
	"Return example that keeps the Scripter"

	<return: #GtExampleWithResult or: nil>
	^ self pulsers
		ifNotEmpty: [ :aCollection | 
			aCollection
				detect: [ :aPulser | aPulser example isNotNil ]
				ifFound: [ :aPulser | aPulser example ]
				ifNone: [ nil ] ]
		ifEmpty: [ nil ]
]

{ #category : #'gt - extensions' }
GtMonitoredScripter >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		priority: 10;
		items: [ self pointers ];
		column: 'Pointers' 
			text: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt - extensions' }
GtMonitoredScripter >> gtScripterExampleFor: aView [
	<gtView>
	^ aView forward
		title: 'Example';
		priority: 5;
		object: [ self example ifNil: [ GtExampleWithResult new ] ];
		view: #gtSourceFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Example'
			tooltip: 'Inspect example'
			action: [ :aButton | 
				self example
					ifNotNil: [ :anExampleWithResult | aButton phlow spawnObject: anExampleWithResult example ] ]
]

{ #category : #'gt - extensions' }
GtMonitoredScripter >> gtScripterSpacePreview: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self scripter
				ifNotNil: [ :aPulser | aPulser scripter gtSpacePreview ]
				ifNil: [ BlElement new ] ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Scripter'
			tooltip: 'Inspect scripter'
			action: [ :aButton | self scripter ifNotNil: [ :aPulser | aButton phlow spawnObject: aPulser scripter ] ]
]

{ #category : #accessing }
GtMonitoredScripter >> pointers [
	Smalltalk garbageCollectMost.

	^ self scripter
		ifNotNil: [ :aScripter | aScripter pointersTo reject: [ :eachObject | (eachObject isKindOf: WeakArray) or: [ (eachObject isKindOf: BlDevScripterStepPlayOnceExecutor) and: [ eachObject scripter == aScripter ] ] ] ]
		ifNil: [ {  } ]
]

{ #category : #accessing }
GtMonitoredScripter >> pulsers [
	<return: #Collection of: #GtMonitoredScripterPulser>
	^ pulsers
		ifNotNil: [ :aWeak | 
			Array
				new: aWeak size
				streamContents: [ :aStream | 
					aWeak
						doWithIndex: [ :aPulserOrNil :anIndex | aPulserOrNil ifNotNil: [ :aPulser | aStream nextPut: aPulser ] ] ] ]
		ifNil: [ #() ]
]

{ #category : #accessing }
GtMonitoredScripter >> pulsers: aCollection [
	| aWeakCollection |
	pulsers := aWeakCollection := WeakArray new: aCollection size.
	aCollection
		doWithIndex: [ :aPulser :anIndex | aWeakCollection at: anIndex put: aPulser ]
]

{ #category : #accessing }
GtMonitoredScripter >> scripter [
	<return: #BlScripter or: nil>
	^ scripter at: 1
]

{ #category : #accessing }
GtMonitoredScripter >> scripter: aScripter [
	scripter := aScripter asWeakReference
]

{ #category : #accessing }
GtMonitoredScripter >> startTime [
	^ self pulsers
		ifNotEmpty: [ :aCollection | aCollection min: #startTime ]
		ifEmpty: [ nil ]
]

{ #category : #accessing }
GtMonitoredScripter >> status [
	^ '{1} pulsers' format: {self pulsers size}
]

{ #category : #accessing }
GtMonitoredScripter >> title [
	^ 'Scripter'
]
