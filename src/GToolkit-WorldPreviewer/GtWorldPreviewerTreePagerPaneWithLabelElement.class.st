Class {
	#name : #GtWorldPreviewerTreePagerPaneWithLabelElement,
	#superclass : #BlElement,
	#traits : 'TGtWorldWithPreviewerTreePagerPaneModel + TBrLayoutResizable',
	#classTraits : 'TGtWorldWithPreviewerTreePagerPaneModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'paneElement',
		'labelElement',
		'iconElement',
		'headerElement'
	],
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneWithLabelElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneWithLabelElement >> initialize [
	| headerContainer |
	super initialize.

	self clipChildren: false.
	self outskirts: BlOutskirts outside.
	self padding: (BlInsets all: 0).

	labelElement := self newLabelElement.
	iconElement := BrFrame new
			fitContent;
			constraintsDo: [ :c | c linear vertical alignCenter ].

	paneElement := GtWorldPreviewerTreePagerPaneElement new
			constraintsDo: [ :c | c frame horizontal alignCenter ].
	self addAptitude: (BrLayoutResizerAptitude new common: paneElement).

	headerElement := BrHorizontalPane new
			hFitContentLimited;
			vFitContent;
			margin: (BlInsets all: 0);
			padding: (BlInsets
					top: 2
					left: 5
					bottom: 0
					right: 5);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			background: (Color lightGray alpha: 0.7);
			constraintsDo: [ :c | 
				c horizontal fitContentLimited.
				c vertical fitContent.
				c frame horizontal alignCenter.
				c frame vertical alignTop ];
			addChild: iconElement as: #icon;
			addChild: labelElement as: #label.

	headerContainer := BrFrame new
			hMatchParent;
			vFitContent;
			addChild: headerElement as: #header.

	self addChild: paneElement.
	self addChild: headerContainer.

	self initializeStyling.
	self fitContent
]

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneWithLabelElement >> initializeStyling [
	self
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: Color transparent ];
				hovered: [ :aStyle | 
					aStyle border: (BlBorder paint: BrGlamorousColors primaryBorderColor width: 1).
					aStyle
						do: [ :aWidget | headerElement background: BrGlamorousColors primaryBorderColor ]
						after: [ :aWidget | headerElement background: (Color lightGray alpha: 0.7) ] ])
]

{ #category : #initialization }
GtWorldPreviewerTreePagerPaneWithLabelElement >> newLabelElement [
	^ BrLabel new
		addAptitude: (BrGlamorousShrinkingLabelAptitude new
				foreground: Color white;
				labelMeasurement);
		constraintsDo: [ :c | 
			c horizontal fitContentLimited.
			c vertical fitContent.
			c linear vertical alignCenter ]
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
	labelElement text: aText asRopedText glamorousRegularFont.

	iconElement removeChildren.
	self treePagerPaneModel paneElement
		ifNotNil: [ :anElement | iconElement addChild: (anElement paneModel icon asElement background: Color white) ]
]
