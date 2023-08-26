Class {
	#name : #GtWorldPagerPagePreview,
	#superclass : #Object,
	#instVars : [
		'page',
		'pageIndex',
		'tabSpace',
		'pager'
	],
	#category : #'GToolkit-World-UI - Preview '
}

{ #category : #accessing }
GtWorldPagerPagePreview >> gtPreviewFor: aView [
	<gtView>
	^ aView forward 
		title: 'Preview';
		object: [ page widget ];
		view: #gtPreviewFor:
]

{ #category : #accessing }
GtWorldPagerPagePreview >> page [ 
	^ page
]

{ #category : #accessing }
GtWorldPagerPagePreview >> page: aPage [ 
	page := aPage
]

{ #category : #accessing }
GtWorldPagerPagePreview >> pageIndex: index [ 
	pageIndex := index
]

{ #category : #accessing }
GtWorldPagerPagePreview >> pagePreviewScaled: aScale [
	^ BlExporter form
		element: page widget;
		scaled: aScale;
		export
]

{ #category : #accessing }
GtWorldPagerPagePreview >> pager: aPager [ 
	pager := aPager.
]

{ #category : #accessing }
GtWorldPagerPagePreview >> select [
	tabSpace select.
	pager scrollTo: pageIndex
]

{ #category : #accessing }
GtWorldPagerPagePreview >> tabSpace: aTabSpace [ 
	tabSpace := aTabSpace
]
