Class {
	#name : #GtWorldPreviewerTabContentTreePagerElement,
	#superclass : #GtWorldPreviewerTabContentElement,
	#instVars : [
		'previewScale',
		'treePagerPaneElementClass'
	],
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
	
	treePagerPaneElementClass := GtWorldPreviewerTreePagerPaneWithLabelElement.
	previewScale := 0.3.
	
	self hMatchParent.
	self vFitContent.
	
	self
		when: BlMouseWheelEvent
		do: [ :anEvent | 
			self layoutDo: [ :aLayout | aLayout mouseWheelEvent: anEvent ] ]
]

{ #category : #'private - updating' }
GtWorldPreviewerTabContentTreePagerElement >> newPreviewElementForPaneModel: aPaneModel paneElement: aPaneElement [
	| aTreePagerPaneModel |
	aTreePagerPaneModel := GtWorldPreviewerTreePagerPaneModel new
			paneElement: aPaneElement;
			paneModel: aPaneModel;
			treePager: self tabContentModel treePagerElement;
			tabModelWithSpace: self tabContentModel tabModelWithSpace.

	^ treePagerPaneElementClass new
		previewScale: self previewScale;
		treePagerPaneModel: aTreePagerPaneModel
]

{ #category : #'api - tab content model' }
GtWorldPreviewerTabContentTreePagerElement >> onTabContentModelChanged [
	self updateElement
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerElement >> previewScale [
	^ previewScale ifNil: [ previewScale := 0.3 ]
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerElement >> previewScale: anObject [
	previewScale := anObject
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerElement >> treePagerPaneElementClass [
	^ treePagerPaneElementClass
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerElement >> treePagerPaneElementClass: anElementClass [
	treePagerPaneElementClass := anElementClass
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
