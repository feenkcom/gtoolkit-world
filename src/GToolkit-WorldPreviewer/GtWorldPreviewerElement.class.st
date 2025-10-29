Class {
	#name : #GtWorldPreviewerElement,
	#superclass : #BlElement,
	#traits : 'TGtWorldWithPreviewerModel + TBrLayoutResizable',
	#classTraits : 'TGtWorldWithPreviewerModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'listElement'
	],
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #initialization }
GtWorldPreviewerElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtWorldPreviewerElement >> initialize [
	| aLabelElement |
	super initialize.
	self
		background: self theme default contentBackground;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		addAptitude: BrShadowAptitude new beLarge;
		margin: (BlInsets all: 100);
		matchParent.

	aLabelElement := self newLabelElement.
	self initializeListElement.

	self addAptitude: (BrLayoutResizerAptitude new common: listElement).

	self addChild: aLabelElement.
	self addChild: listElement as: #tabContent
]

{ #category : #initialization }
GtWorldPreviewerElement >> initializeListElement [
	listElement := BrSimpleList vertical matchParent
			itemStencil: [ self newTabPreviewElement ];
			itemDataBinder: [ :anElement :aPreview :anIndex | 
				anElement
					removeChildren;
					addChild: aPreview asElement ]
]

{ #category : #initialization }
GtWorldPreviewerElement >> newLabelElement [
	^ BrLabel new
		text: 'Preview of all tabs and pager panes. Select to navigate.';
		margin: (BlInsets
				top: 10
				left: 20
				bottom: 10
				right: 10);
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray)
]

{ #category : #initialization }
GtWorldPreviewerElement >> newTabPreviewElement [
	^ BrVerticalPane new
		margin: (BlInsets
				top: 20
				left: 10
				bottom: 10
				right: 10);
		hMatchParent;
		vFitContentLimited
]

{ #category : #'api - previewer' }
GtWorldPreviewerElement >> onPreviewerChanged [
	self updateElement
]

{ #category : #'private - updating' }
GtWorldPreviewerElement >> updateElement [
	listElement items: self previewer worldTabs
]
