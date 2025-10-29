Class {
	#name : #GtWorldPreviewerTabContentPagerElement,
	#superclass : #GtWorldPreviewerTabContentElement,
	#instVars : [
		'listElement'
	],
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #initialization }
GtWorldPreviewerTabContentPagerElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtWorldPreviewerTabContentPagerElement >> initialize [
	super initialize.

	self initializeListElement.

	self addAptitude: (BrLayoutResizerAptitude new common: listElement).

	self addChild: listElement.

	self matchParent
]

{ #category : #initialization }
GtWorldPreviewerTabContentPagerElement >> initializeListElement [
	listElement := BrSimpleList horizontal
			hMatchParent;
			vFitContent;
			itemStencil: [ self newItemElement ];
			itemDataBinder: [ :anElement :aPagePreview :anIndex | 
				anElement
					enqueueTask: (BlTaskAction new
							action: [ anElement
									removeChildren;
									addChild: aPagePreview asElement ]) ]
]

{ #category : #initialization }
GtWorldPreviewerTabContentPagerElement >> newItemElement [
	^ BrVerticalPane new
		hFitContent;
		vFitContentLimited;
		margin: (BlInsets all: 10);
		background: Color white;
		addAptitude: BrShadowAptitude
]

{ #category : #'api - tab content model' }
GtWorldPreviewerTabContentPagerElement >> onTabContentModelChanged [
	self updateElement
]

{ #category : #'private - updating' }
GtWorldPreviewerTabContentPagerElement >> updateElement [
	self updateListElement
]

{ #category : #'private - updating' }
GtWorldPreviewerTabContentPagerElement >> updateListElement [
	listElement items: self tabContentModel pagerPagePreviews
]
