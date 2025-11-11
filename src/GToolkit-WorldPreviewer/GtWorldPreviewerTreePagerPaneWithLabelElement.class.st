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
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneWithLabelElement >> initialize [
	super initialize.

	labelElement := BrLabel new
			text: 'Pane: ';
			margin: (BlInsets left: 0);
			aptitude: BrGlamorousLabelAptitude new;
			hMatchParent;
			vFitContent.
	paneElement := GtWorldPreviewerTreePagerPaneElement new.
	self addAptitude: (BrLayoutResizerAptitude new common: paneElement).

	self addChild: labelElement.
	self addChild: paneElement.

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
	labelElement text: aText
]
