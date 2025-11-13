Class {
	#name : #GtWorldPreviewerSelectPagerPageWish,
	#superclass : #BrWish,
	#instVars : [
		'pagerPagePreview'
	],
	#category : #'GToolkit-WorldPreviewer-Events'
}

{ #category : #accessing }
GtWorldPreviewerSelectPagerPageWish >> pagerPagePreview [
	^ pagerPagePreview
]

{ #category : #accessing }
GtWorldPreviewerSelectPagerPageWish >> pagerPagePreview: aPreview [ 
	pagerPagePreview := aPreview
]

{ #category : #accessing }
GtWorldPreviewerSelectPagerPageWish >> sendTo: anObject [
	anObject previewerSelectPagerPageEvent: self
]
