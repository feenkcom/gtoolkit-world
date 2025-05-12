Class {
	#name : #GtWorldPreviewerPagerPage,
	#superclass : #Object,
	#instVars : [
		'page',
		'pageIndex',
		'tabSpace',
		'pager'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerPagerPage >> asElement [
	^ (self asElementScaled: 0.3)
]

{ #category : #accessing }
GtWorldPreviewerPagerPage >> asElementScaled: aScale [
	| aPreviewElement |
	
	aPreviewElement := BrElementAsFormPreview
		forElement: page widget
		preferredScale: 0.3.

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
GtWorldPreviewerPagerPage >> gtPreviewFor: aView [
	<gtView>
	^ aView forward 
		title: 'Preview';
		object: [ page widget ];
		view: #gtPreviewFor:
]

{ #category : #accessing }
GtWorldPreviewerPagerPage >> page [ 
	^ page
]

{ #category : #accessing }
GtWorldPreviewerPagerPage >> page: aPage [ 
	page := aPage
]

{ #category : #accessing }
GtWorldPreviewerPagerPage >> pageIndex [
	^ pageIndex
]

{ #category : #accessing }
GtWorldPreviewerPagerPage >> pageIndex: index [ 
	pageIndex := index
]

{ #category : #accessing }
GtWorldPreviewerPagerPage >> pager: aPager [ 
	pager := aPager.
]

{ #category : #accessing }
GtWorldPreviewerPagerPage >> select [
	tabSpace select.
	pager scrollTo: pageIndex
]

{ #category : #accessing }
GtWorldPreviewerPagerPage >> tabSpace: aTabSpace [ 
	tabSpace := aTabSpace
]
