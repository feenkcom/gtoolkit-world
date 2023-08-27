Class {
	#name : #GtWorldPreviewerSelectSpaceTabWish,
	#superclass : #BrWish,
	#instVars : [
		'spaceTabPreview'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerSelectSpaceTabWish >> sendTo: anObject [
	anObject previewerSelectSpaceTabEvent: self
]

{ #category : #accessing }
GtWorldPreviewerSelectSpaceTabWish >> spaceTabPreview [
	^ spaceTabPreview
]

{ #category : #accessing }
GtWorldPreviewerSelectSpaceTabWish >> spaceTabPreview: aSpaceTab [
	spaceTabPreview := aSpaceTab
]
