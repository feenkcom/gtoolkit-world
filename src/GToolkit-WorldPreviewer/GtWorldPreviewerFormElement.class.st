Class {
	#name : #GtWorldPreviewerFormElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'previewElement',
		'previewScale'
	],
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #initialization }
GtWorldPreviewerFormElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtWorldPreviewerFormElement >> initialize [
	super initialize.

	self initializePreviewElement.
	self addChild: previewElement.
	self addAptitude: (BrLayoutResizerAptitude new common: previewElement).

	self when: BlClickEvent do: [ :e | self onClickEvent: e ].

	self fitContent
]

{ #category : #initialization }
GtWorldPreviewerFormElement >> initializePreviewElement [
	previewElement := BrElementAsFormPreview new
]

{ #category : #accessing }
GtWorldPreviewerFormElement >> itemElement [
	"Return a model element for which a preview is created"

	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtWorldPreviewerFormElement >> itemModel [
	"Return a model which represents a given preview"

	^ self subclassResponsibility
]

{ #category : #'private - event handling' }
GtWorldPreviewerFormElement >> onClickEvent: anEvent [
	anEvent consumed: true.
	anEvent target
		fireEvent: (GtWorldPreviewerSelectPagerPageWish new
				pagerPagePreview: self itemModel)
]

{ #category : #accessing }
GtWorldPreviewerFormElement >> previewScale [
	^ previewScale
]

{ #category : #accessing }
GtWorldPreviewerFormElement >> previewScale: aNumber [
	"Define the preview scale before defining item model."

	previewScale := aNumber
]

{ #category : #'private - updating' }
GtWorldPreviewerFormElement >> updateElement [
	previewElement
		preferredScale: self previewScale;
		initializeForElement: self itemElement
]

{ #category : #initialization }
GtWorldPreviewerFormElement >> withStyling [
	self
		addAptitude: (BrStyleCommonAptitude new
				default: [ :f | f border: Color transparent ];
				hovered: [ :f | f border: BrGlamorousColors primaryBorderColor ])
]
