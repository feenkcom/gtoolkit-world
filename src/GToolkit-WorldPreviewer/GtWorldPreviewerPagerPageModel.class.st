Class {
	#name : #GtWorldPreviewerPagerPageModel,
	#superclass : #Object,
	#traits : 'TGtWorldWithTabModelWithSpace',
	#classTraits : 'TGtWorldWithTabModelWithSpace classTrait',
	#instVars : [
		'page',
		'pageIndex',
		'pager'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> asElement [
	^ (self asElementScaled: 0.3)
]

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> asElementScaled: aScale [
	| aPreviewElement |
	
	aPreviewElement := BrElementAsFormPreview
		forElement: page widget
		preferredScale: aScale.

	^ aPreviewElement
			aptitude: (BrStyleCommonAptitude new
					default: [ :f | f border: Color transparent ];
					hovered: [ :f | f border: BrGlamorousColors primaryBorderColor ]);
			when: BlClickEvent
				do: [ :e | 
					e consumed: true.
					e target
						fireEvent: (GtWorldPreviewerSelectPagerPageWish new pagerPagePreview: self) ]
]

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> gtPreviewFor: aView [
	<gtView>
	^ aView forward 
		title: 'Preview';
		object: [ page widget ];
		view: #gtPreviewFor:
]

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> page [ 
	^ page
]

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> page: aPage [ 
	page := aPage
]

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> pageIndex [
	^ pageIndex
]

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> pageIndex: index [ 
	pageIndex := index
]

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> pager: aPager [ 
	pager := aPager.
]

{ #category : #accessing }
GtWorldPreviewerPagerPageModel >> select [
	tabModelWithSpace select.
	pager scrollTo: pageIndex
]
