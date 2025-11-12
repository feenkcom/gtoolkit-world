Class {
	#name : #GtWorldPreviewerTreePagerPaneElement,
	#superclass : #BlElement,
	#traits : 'TGtWorldWithPreviewerTreePagerPaneModel + TBrLayoutResizable',
	#classTraits : 'TGtWorldWithPreviewerTreePagerPaneModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'previewScale',
		'previewElement'
	],
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneElement >> initialize [
	super initialize.

	self initializePreviewElement.
	self addChild: previewElement.

	self
		addAptitude: (BrStyleCommonAptitude new
				default: [ :f | f border: Color transparent ];
				hovered: [ :f | f border: BrGlamorousColors primaryBorderColor ]).
	
	self addAptitude: (BrLayoutResizerAptitude new common: previewElement).
	
	self when: BlClickEvent do: [ :e | self onClickEvent: e ].

	self fitContent
]

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneElement >> initializePreviewElement [
	previewElement := BrElementAsFormPreview new
]

{ #category : #'private - event handling' }
GtWorldPreviewerTreePagerPaneElement >> onClickEvent: anEvent [
	anEvent consumed: true.
	anEvent target
		fireEvent: (GtWorldPreviewerSelectPagerPageWish new
				pagerPagePreview: self treePagerPaneModel)
]

{ #category : #'api - tree pager pane model' }
GtWorldPreviewerTreePagerPaneElement >> onTreePagerPaneModelChanged [
	self updateElement
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneElement >> previewScale [
	^ previewScale
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneElement >> previewScale: anObject [
	previewScale := anObject
]

{ #category : #'private - updating' }
GtWorldPreviewerTreePagerPaneElement >> updateElement [
	previewElement
		preferredScale: self previewScale;
		initializeForElement: self treePagerPaneModel paneElement
]
