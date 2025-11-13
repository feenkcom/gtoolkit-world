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

{ #category : #converting }
GtWorldPreviewerPagerPageModel >> asElement [
	^ (self asElementScaled: 0.3)
]

{ #category : #converting }
GtWorldPreviewerPagerPageModel >> asElementScaled: aScale [
	^ GtWorldPreviewerPagerPageElement new
		withStyling;
		previewScale: aScale;
		pagerPageModel: self
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
GtWorldPreviewerPagerPageModel >> pageElement [
	^ page widget
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
