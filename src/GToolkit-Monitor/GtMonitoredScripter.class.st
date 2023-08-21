Class {
	#name : #GtMonitoredScripter,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'pulsers'
	],
	#category : #'GToolkit-Monitor-Scripter'
}

{ #category : #accessing }
GtMonitoredScripter >> children [
	^ pulsers ifNil: [ #() ]
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
	^ pulsers ifNil: [ #() ]
]

{ #category : #accessing }
GtMonitoredScripter >> pulsers: anObject [
	pulsers := anObject
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
	^ self pulsers min: #startTime
]

{ #category : #accessing }
GtMonitoredScripter >> status [
	^ '{1} pulsers' format: {self pulsers size}
]

{ #category : #accessing }
GtMonitoredScripter >> title [
	^ 'Scripter'
]
