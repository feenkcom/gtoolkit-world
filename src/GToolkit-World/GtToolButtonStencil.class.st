Class {
	#name : #GtToolButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'icon',
		'title',
		'description',
		'action',
		'iconSize',
		'margin',
		'priority',
		'elementId',
		'definingMethod'
	],
	#category : #'GToolkit-World-Stencils'
}

{ #category : #accessing }
GtToolButtonStencil >> action [
	^ action
]

{ #category : #accessing }
GtToolButtonStencil >> action: anObject [
	action := anObject
]

{ #category : #'api - instantiation' }
GtToolButtonStencil >> create [
	<return: #BrButton>
	| button |
	button := self createBasicButton.
	button 
		margin: self margin;
		action: self action;
		aptitude: BrGlamorousButtonExteriorAptitude new;
		addAptitude: BrGlamorousButtonWithLabelTooltipAptitude new;
		addAptitude: (GtPhlowBrowseDefinitionAptitude new definition: [ definingMethod ]).
	elementId ifNotNil: [ button id: elementId ].
	^ button
]

{ #category : #'api - instantiation' }
GtToolButtonStencil >> createBasicButton [
	| iconElement labelElement button |
	iconElement := (self icon asElement asScalableElement) 
		size: self iconSize; 
		margin: (BlInsets bottom: 5).
	labelElement := BrLabel new 
	    text: self title;
	    aptitude: (BrGlamorousLabelAptitude new fontSize: 10).
	button := BrButton new
		label: self description;
		constraintsDo:[ :c | 
	        c horizontal exact: 100.
	        c vertical exact: 70 ];
		padding: (BlInsets all: 10);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		layout: BlLinearLayout vertical alignCenter;
		addChild: iconElement;
		addChild: labelElement.
	^ button
]

{ #category : #accessing }
GtToolButtonStencil >> definingMethod: aMethod [
	definingMethod := aMethod
]

{ #category : #accessing }
GtToolButtonStencil >> description [
	^ description
]

{ #category : #accessing }
GtToolButtonStencil >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtToolButtonStencil >> elementId [
	^ elementId
]

{ #category : #accessing }
GtToolButtonStencil >> elementId: anObject [
	elementId := anObject
]

{ #category : #accessing }
GtToolButtonStencil >> icon [
	^ icon
]

{ #category : #accessing }
GtToolButtonStencil >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GtToolButtonStencil >> iconSize [
	^ iconSize
]

{ #category : #accessing }
GtToolButtonStencil >> iconSize: aPoint [
	iconSize := aPoint
]

{ #category : #initialization }
GtToolButtonStencil >> initialize [
	super initialize.
	description := 'Some tool'.
	title := 'Some tool'.
	action := [  ].
	priority := 50.

	iconSize := 32@32.
	margin := BlInsets top: 10 left: 20 bottom: 10 right: 20.
	
	icon := BlElement new size: iconSize.
]

{ #category : #accessing }
GtToolButtonStencil >> margin [
	^ margin
]

{ #category : #accessing }
GtToolButtonStencil >> margin: anObject [
	margin := anObject
]

{ #category : #accessing }
GtToolButtonStencil >> priority [
	^ priority
]

{ #category : #accessing }
GtToolButtonStencil >> priority: anObject [
	priority := anObject
]

{ #category : #accessing }
GtToolButtonStencil >> smallIcon [
	self iconSize: 32@32
]

{ #category : #accessing }
GtToolButtonStencil >> smallMargin [
	self margin: (BlInsets top: 10 left: 10 bottom: 10 right: 10)
]

{ #category : #accessing }
GtToolButtonStencil >> title [
	^ title
]

{ #category : #accessing }
GtToolButtonStencil >> title: anObject [
	title := anObject
]
