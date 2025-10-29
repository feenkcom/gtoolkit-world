Class {
	#name : #GtWorldPreviewerTabQueryStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'rootElement'
	],
	#category : #'GToolkit-WorldPreviewer-Support'
}

{ #category : #'api - instantiation' }
GtWorldPreviewerTabQueryStencilBuilder >> buildDefault [
	<return: #BlElement or: nil>
	^ self rootElement
]

{ #category : #'api - instantiation' }
GtWorldPreviewerTabQueryStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.

	aStencilExecutor push: self rootElement
]

{ #category : #initialization }
GtWorldPreviewerTabQueryStencilBuilder >> reset [
	super reset.
	rootElement := nil
]

{ #category : #accessing }
GtWorldPreviewerTabQueryStencilBuilder >> rootElement [
	^ rootElement
]

{ #category : #accessing }
GtWorldPreviewerTabQueryStencilBuilder >> rootElement: anObject [
	rootElement := anObject
]
