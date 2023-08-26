Class {
	#name : #GtWorldPagerPagePreview,
	#superclass : #Object,
	#instVars : [
		'page'
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
GtWorldPagerPagePreview >> pagePreviewScaled: aScale [
	^ BlExporter form
		element: page widget;
		scaled: aScale;
		export
]
