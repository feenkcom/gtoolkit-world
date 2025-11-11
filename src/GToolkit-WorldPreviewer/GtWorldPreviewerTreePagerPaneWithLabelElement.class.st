Class {
	#name : #GtWorldPreviewerTreePagerPaneWithLabelElement,
	#superclass : #BlElement,
	#traits : 'TGtWorldWithPreviewerTreePagerPaneModel + TBrLayoutResizable',
	#classTraits : 'TGtWorldWithPreviewerTreePagerPaneModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'paneElement',
		'labelElement'
	],
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneWithLabelElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneWithLabelElement >> initialize [
	| labelContainer |
	super initialize.

	labelElement := BrLabel new
			addAptitude: (BrGlamorousShrinkingLabelAptitude new foreground: Color white);
			margin: (BlInsets all: 0);
			padding: (BlInsets top: 2 left: 5 bottom: 0 right: 5);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			background: (Color lightGray alpha: 0.7);
			constraintsDo: [ :c | 
				c horizontal fitContentLimited.
				c vertical fitContent.
				c frame horizontal alignCenter.
				c frame vertical alignTop ].

	paneElement := GtWorldPreviewerTreePagerPaneElement new
			constraintsDo: [ :c | c frame horizontal alignCenter ].
	self addAptitude: (BrLayoutResizerAptitude new common: paneElement).

	labelContainer := BrFrame new
			hMatchParent;
			vFitContent.
	labelContainer addChild: labelElement.

	self addChild: paneElement.
	self addChild: labelContainer.

	self fitContent
]

{ #category : #'api - tree pager pane model' }
GtWorldPreviewerTreePagerPaneWithLabelElement >> onTreePagerPaneModelChanged [
	paneElement treePagerPaneModel: self treePagerPaneModel.
	self updateElement
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneWithLabelElement >> previewScale [
	^ paneElement previewScale
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneWithLabelElement >> previewScale: anObject [
	paneElement previewScale: anObject
]

{ #category : #'private - updating' }
GtWorldPreviewerTreePagerPaneWithLabelElement >> updateElement [
	| aText |
	aText := self treePagerPaneModel paneElement
			ifNotNil: [ :anElement | anElement paneModel ifNotNil: #title ifNil: [ '' ] ]
			ifNil: [ '' ].
	labelElement text: aText asRopedText glamorousRegularFont
]
