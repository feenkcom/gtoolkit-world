Class {
	#name : #GtWorldPreviewerPagerPageElement,
	#superclass : #GtWorldPreviewerFormElement,
	#traits : 'TGtWorldWithPreviewerPagerPageModel',
	#classTraits : 'TGtWorldWithPreviewerPagerPageModel classTrait',
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #accessing }
GtWorldPreviewerPagerPageElement >> itemElement [
	"Return a model element for which a preview is created"

	<return: #BlElement>
	^ self itemModel pageElement
]

{ #category : #accessing }
GtWorldPreviewerPagerPageElement >> itemModel [
	"Return a model which represents a given preview"

	^ self pagerPageModel
]

{ #category : #'api - pager page model' }
GtWorldPreviewerPagerPageElement >> onPagerPageModelChanged [
	self updateElement
]
