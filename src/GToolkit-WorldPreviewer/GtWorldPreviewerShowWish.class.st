Class {
	#name : #GtWorldPreviewerShowWish,
	#superclass : #BrWish,
	#instVars : [
		'worldTabPreview'
	],
	#category : #'GToolkit-WorldPreviewer-Events'
}

{ #category : #accessing }
GtWorldPreviewerShowWish >> sendTo: anObject [
	anObject previewerShowEvent: self
]
