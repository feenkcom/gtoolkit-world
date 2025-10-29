Class {
	#name : #GtWorldPreviewerTabContentPagerModel,
	#superclass : #GtWorldPreviewerTabContentModel,
	#instVars : [
		'pagerElement'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - converting' }
GtWorldPreviewerTabContentPagerModel >> asElement [
	<return: #BlElement>
	^ GtWorldPreviewerTabContentPagerElement new tabContentModel: self
]

{ #category : #views }
GtWorldPreviewerTabContentPagerModel >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]

{ #category : #views }
GtWorldPreviewerTabContentPagerModel >> gtPagePreviewsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Page previews';
		priority: 10;
		items: [ self pagerPagePreviews ];
		column: 'Value' text: [ :each | each gtDisplayString ];
		column: 'Page index' text: [:each | each pageIndex ]
]

{ #category : #accessing }
GtWorldPreviewerTabContentPagerModel >> pagerElement [
	^ pagerElement
]

{ #category : #accessing }
GtWorldPreviewerTabContentPagerModel >> pagerElement: anElement [
	pagerElement := anElement
]

{ #category : #'api - items' }
GtWorldPreviewerTabContentPagerModel >> pagerPagePreviews [
	^ self pagerElement pages
		collectWithIndex: [ :each :index | 
			GtWorldPreviewerPagerPageModel new
				page: each;
				tabModelWithSpace: tabModelWithSpace;
				pager: self pagerElement;
				pageIndex: index ]
]
