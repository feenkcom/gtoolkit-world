Class {
	#name : #GtWorldPreviewerTabItemStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'tabModelWithSpace',
		'element'
	],
	#category : #'GToolkit-WorldPreviewer-Support'
}

{ #category : #'api - instantiation' }
GtWorldPreviewerTabItemStencilBuilder >> buildDefault [
	<return: #GtWorldPreviewerTabContentModel or: #nil>
	^ nil
]

{ #category : #accessing }
GtWorldPreviewerTabItemStencilBuilder >> element [
	^ element
]

{ #category : #accessing }
GtWorldPreviewerTabItemStencilBuilder >> element: anElement [
	element := anElement
]

{ #category : #'api - instantiation' }
GtWorldPreviewerTabItemStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.

	aStencilExecutor
		push: tabModelWithSpace;
		push: element
]

{ #category : #initialization }
GtWorldPreviewerTabItemStencilBuilder >> reset [
	super reset.
	tabModelWithSpace := nil.
	element := nil
]

{ #category : #accessing }
GtWorldPreviewerTabItemStencilBuilder >> tabModelWithSpace [
	^ tabModelWithSpace
]

{ #category : #accessing }
GtWorldPreviewerTabItemStencilBuilder >> tabModelWithSpace: aTabModel [
	tabModelWithSpace := aTabModel
]
