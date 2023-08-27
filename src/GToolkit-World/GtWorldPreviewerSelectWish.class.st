Class {
	#name : #GtWorldPreviewerSelectWish,
	#superclass : #BrWish,
	#instVars : [
		'worldTabPreview'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerSelectWish >> sendTo: anObject [
	anObject previewerSelectEvent: self
]

{ #category : #accessing }
GtWorldPreviewerSelectWish >> worldTabPreview [
	^ worldTabPreview
]

{ #category : #accessing }
GtWorldPreviewerSelectWish >> worldTabPreview: aPreview [ 
	worldTabPreview := aPreview
]
