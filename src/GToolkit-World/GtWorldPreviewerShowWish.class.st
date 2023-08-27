Class {
	#name : #GtWorldPreviewerShowWish,
	#superclass : #BrWish,
	#instVars : [
		'worldTabPreview'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerShowWish >> sendTo: anObject [
	anObject previewerShowEvent: self
]
