Class {
	#name : #GtCoderStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtCoderStencil >> asPreviewElement [
	^ GtCoderElement new asElement
]

{ #category : #'api - instantiation' }
GtCoderStencil >> create [
	^ GtCoderElement new createInPager maximized.
]

{ #category : #accessing }
GtCoderStencil >> icon [
	^ BrGlamorousVectorIcons emphasizedBrowse
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
