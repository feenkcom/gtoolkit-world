Class {
	#name : #BrKeyboardFocusChangeAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'rootValuable'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #accessing }
BrKeyboardFocusChangeAptitude >> defaultRoot [
	^ self widget parent
]

{ #category : #initialization }
BrKeyboardFocusChangeAptitude >> initialize [
	super initialize
]

{ #category : #initialization }
BrKeyboardFocusChangeAptitude >> initializeListeners [
	super initializeListeners.
	self
		when: BlKeyDownEvent
			do: [ :anEvent | 
				| key |
				key := anEvent key.
				anEvent consumed: true.
				key = BlKeyboardKey arrowLeft
					ifTrue: [ BlFocusFinder new
							left;
							root: self rootElement;
							referenceElement: self widget;
							nextFocusDo: #requestFocus ifNone: [  ] ].
				key = BlKeyboardKey arrowUp
					ifTrue: [ BlFocusFinder new
							up;
							root: self rootElement;
							referenceElement: self widget;
							nextFocusDo: #requestFocus ifNone: [  ] ].
				key = BlKeyboardKey arrowRight
					ifTrue: [ BlFocusFinder new
							right;
							root: self rootElement;
							referenceElement: self widget;
							nextFocusDo: #requestFocus ifNone: [  ] ].
				key = BlKeyboardKey arrowDown
					ifTrue: [ BlFocusFinder new
							down;
							root: self rootElement;
							referenceElement: self widget;
							nextFocusDo: #requestFocus ifNone: [  ] ].
				key isReturn
					ifTrue: [ self widget aptitude actors
							detect: [ :each | 
								(each isKindOf: BrWithExplicitMenuAptitude)
									and: [ (each isKindOf: BrGlamorousWithExplicitTooltipAptitude) not ] ]
							ifFound: [ :dropdown | dropdown show ] ] ];
		when: BlMouseEnterEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				self widget requestFocus ];
		when: BlMouseLeaveEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				self widget loseFocus ]
]

{ #category : #'api - hooks' }
BrKeyboardFocusChangeAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	self widget beFocusable
]

{ #category : #accessing }
BrKeyboardFocusChangeAptitude >> rootElement [
	^ rootValuable
		ifNil: [ self defaultRoot ]
		ifNotNil: [ self rootValuable value: self widget ]
]

{ #category : #accessing }
BrKeyboardFocusChangeAptitude >> rootValuable [
	^ rootValuable
]

{ #category : #accessing }
BrKeyboardFocusChangeAptitude >> rootValuable: aValuable [
	rootValuable := aValuable
]
