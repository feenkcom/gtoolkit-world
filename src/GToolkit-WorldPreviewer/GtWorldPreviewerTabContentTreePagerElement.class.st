Class {
	#name : #GtWorldPreviewerTabContentTreePagerElement,
	#superclass : #GtWorldPreviewerTabContentElement,
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #'children - enumerating' }
GtWorldPreviewerTabContentTreePagerElement >> childNodeForPaneModel: aPaneModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self children
		detect: [ :eachElement | eachElement graph isNode and: [ eachElement paneModel = aPaneModel ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #initialization }
GtWorldPreviewerTabContentTreePagerElement >> defaultLayout [
	^ BlHorizontalTreeFlowLayout new
		numberOfVisibleColumns: 2;
		firstVisibleColumn: 1;
		horizontalOffset: 0;
		horizontalCellSpacing: GtTreePagerConstants horizontalCellSpacing;
		verticalCellSpacing: GtTreePagerConstants verticalCellSpacing;
		fillEntireColumnHeight
]

{ #category : #'private - updating' }
GtWorldPreviewerTabContentTreePagerElement >> ensurePreviewForPaneElement: aPaneElement [
	| aPreviewElement |
	aPreviewElement := self
			childNodeForPaneModel: aPaneElement paneModel
			ifFound: [ :theElement | theElement ]
			ifNone: [ self
					newPreviewElementForPaneModel: aPaneElement paneModel
					paneElement: aPaneElement ].

	aPreviewElement
		constraintsDo: [ :c | 
			| layoutConstraints |
			layoutConstraints := aPaneElement constraints horizontalTreeFlow.
			c horizontalTreeFlow
				row: layoutConstraints row;
				depth: layoutConstraints depth;
				span: layoutConstraints span ].

	aPreviewElement hasParent
		ifFalse: [ self addChild: aPreviewElement ].

	^ aPreviewElement
]

{ #category : #initialization }
GtWorldPreviewerTabContentTreePagerElement >> initialize [
	super initialize.
	
	self hMatchParent.
	self vFitContentLimited.
	
	self
		when: BlMouseWheelEvent
		do: [ :anEvent | 
			self layoutDo: [ :aLayout | aLayout mouseWheelEvent: anEvent ] ]
]

{ #category : #'private - updating' }
GtWorldPreviewerTabContentTreePagerElement >> newPreviewElementForPaneModel: aPaneModel paneElement: aPaneElement [
	^ GtWorldPreviewerTreePagerPaneModel new
		paneElement: aPaneElement;
		paneModel: aPaneModel;
		treePager: self tabContentModel treePagerElement;
		tabModelWithSpace: self tabContentModel tabModelWithSpace;
		asElement
]

{ #category : #'api - tab content model' }
GtWorldPreviewerTabContentTreePagerElement >> onTabContentModelChanged [
	self updateElement
]

{ #category : #'private - updating' }
GtWorldPreviewerTabContentTreePagerElement >> updateElement [
	| displayedElements paneElements maxDepth |
	displayedElements := OrderedCollection new.

	paneElements := self tabContentModel treePagerElement children
			select: [ :eachChild | eachChild graph isNode ].

	paneElements
		do: [ :eachPaneElement | displayedElements add: (self ensurePreviewForPaneElement: eachPaneElement) ].

	maxDepth := 1.
	paneElements
		do: [ :eachPaneElement | eachPaneElement constraints horizontalTreeFlow depth max: maxDepth ].

	(self children difference: displayedElements) do: #removeFromParent.

	self layoutDo: [ :l | l numberOfVisibleColumns: maxDepth ]
]
