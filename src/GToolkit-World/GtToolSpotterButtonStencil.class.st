"
I create {{gtClass:GtSpotter}} in dropdown. 
I reuse {{gtClass:GtSpotterDropdownButtonStencil}}. 

"
Class {
	#name : #GtToolSpotterButtonStencil,
	#superclass : #GtToolButtonStencil,
	#instVars : [
		'valuable',
		'extent',
		'spotterModelDo',
		'objectActOn',
		'espaceActOn'
	],
	#category : #'GToolkit-World-Stencils'
}

{ #category : #accessing }
GtToolSpotterButtonStencil >> create [
	| button |
	button := super create.

	button addAptitude: (self createDropdownAptitudeForButton: button).
	
	^ button
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> createDropdownAptitudeForButton: aButton [
	^ BrGlamorousWithExplicitDropdownAptitude
		handle: [ self createHandleButton ]
		content: [ | aSpotterElement |
			aSpotterElement := self spotterElementFor: aButton.
			aSpotterElement
				addAptitude: (BrGlamorousMenuResizableAptitude new
						whenResizedDo: [ :anEvent | 
							anEvent resizeTarget
								ifNotNil: [ :anElement | 
									anElement
										fireEvent: (GtSpotterResizedEvent new
												extent: anEvent extent;
												resizeTarget: anElement) ] ]) ]
		containerDo: [ :aMenuContainer | 
			aMenuContainer background: BrGlamorousColors secondaryHeaderBackgroundColor ]
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> createHandleButton [
	| aButton |
	aButton := self createBasicButton.
	^ aButton
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> espaceActOn [
	^ espaceActOn
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> espaceActOn: anObject [
	espaceActOn := anObject
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> extent [
	^ extent ifNil: [ extent := 400@600 ]
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> objectActOn [
	^ objectActOn
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> objectActOn: anObject [
	objectActOn := anObject
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> spotterElementFor: aButton [ 
	<return: #GtStreamingSpotterElement>
	^ GtSpotterDropdownButtonStencil new
		in: [ :theStencil | 
			self valuable ifNotNil: [ :anObject | theStencil valuable: anObject ].
			self extent ifNotNil: [ :anObject | theStencil extent: anObject ].
			self spotterModelDo ifNotNil: [ :anObject | theStencil spotterModelDo: anObject ].
			self objectActOn ifNotNil: [ :anObject | theStencil objectActOn: anObject ].
			self espaceActOn ifNotNil: [ :aBlock | theStencil escapeActOn: aBlock ].
		];
		spotterElementFor: aButton
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> spotterModelDo [
	^ spotterModelDo
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> spotterModelDo: anObject [
	spotterModelDo := anObject
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> valuable [
	^ valuable
]

{ #category : #accessing }
GtToolSpotterButtonStencil >> valuable: anObject [
	valuable := anObject
]
