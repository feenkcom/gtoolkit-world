Class {
	#name : #GtMonitoredScripterPulsersElement,
	#superclass : #BlElement,
	#instVars : [
		'pulserList'
	],
	#category : #'GToolkit-Monitor-Scripter'
}

{ #category : #accessing }
GtMonitoredScripterPulsersElement class >> allScripterExamples [
	^ GtExampleWithResult allSubInstances
		select: [ :anExampleWithResult | 
			anExampleWithResult isSuccess
				and: [ anExampleWithResult result returnValue isKindOf: BlScripter ] ]
]

{ #category : #accessing }
GtMonitoredScripterPulsersElement class >> allScripterPulsers [
	| allScripterExamples |
	allScripterExamples := self allScripterExamples.
	
	^ BlDevScripterPulseUntilReady allSubInstances
		collect: [ :anInstance | 
			GtMonitoredScripterPulser new
				pulser: anInstance;
				example: (allScripterExamples
						detect: [ :each | each isSuccess and: [ each result returnValue == anInstance scripter ] ]
						ifNone: [ nil ]) ]
]

{ #category : #accessing }
GtMonitoredScripterPulsersElement class >> allScripters [
	| allPulsers allScripterExamples |
	allPulsers := self allScripterPulsers.
	allScripterExamples := self allScripterExamples.

	^ BlScripter allSubInstances
		collect: [ :anInstance | 
			GtMonitoredScripter new
				scripter: anInstance;
				pulsers: (allPulsers select: [ :each | each scripter == anInstance ]) ]
]

{ #category : #initialization }
GtMonitoredScripterPulsersElement >> initialize [
	super initialize.

	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].

	pulserList := BrColumnedTree new.
	pulserList
		addEventHandler: (GtPhlowListToSelectHandler new
				transformation: [ :variableNode | variableNode value ]).
	pulserList
		rowStencil: (BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new
				cellSpacing: 10;
				padding: (BlInsets top: 4 bottom: 4)).

	pulserList column
		title: 'Title';
		stencil: [ :aNode | 
			| aTitle |
			aTitle := aNode title
					ifEmpty: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].

			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aTitle;
				hMatchParent ].

	pulserList column
		title: 'Status';
		stencil: [ :aNode | 
			| aTitle |
			aTitle := aNode status
					ifEmpty: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].

			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aTitle;
				hMatchParent ];
		width: 100.

	pulserList column
		title: 'Since';
		stencil: [ :aNode | 
			| aText |
			aText := aNode startTime
					ifNil: [ '~Garbage collected~' asRopedText italic foreground: Color gray ]
					ifNotNil: [ :aTime | 'Started {1} ago' format: {(DateAndTime now - aTime) gtHumanReadableString} ].

			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aText;
				hMatchParent ];
		width: 150.

	pulserList column
		title: 'Example';
		stencil: [ :aNode | 
			| aText |
			aText := aNode example
					ifNil: [ '~Garbage collected~' asRopedText italic foreground: Color gray ]
					ifNotNil: [ :anExampleWithResult | anExampleWithResult methodClass asRopedText ].

			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aText;
				hMatchParent ];
		width: 150.

	self addChild: pulserList.

	self updateList
]

{ #category : #updating }
GtMonitoredScripterPulsersElement >> updateList [
	pulserList
		items: self class allScripters
		immediate: [ :aNode | aNode children ].
	pulserList expandUpTo: 2.
]
