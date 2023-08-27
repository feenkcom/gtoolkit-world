Class {
	#name : #GtWorldPreviewerSelectPagerPageWish,
	#superclass : #BrWish,
	#instVars : [
		'worldTabPreview'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerSelectPagerPageWish >> sendTo: anObject [
	anObject previewerSelectEvent: self
]

{ #category : #accessing }
GtWorldPreviewerSelectPagerPageWish >> worldTabPreview [
	^ worldTabPreview
]

{ #category : #accessing }
GtWorldPreviewerSelectPagerPageWish >> worldTabPreview: aPreview [ 
	worldTabPreview := aPreview
]
