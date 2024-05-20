Class {
	#name : #GtExplicitHomeCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'stencil'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtExplicitHomeCard >> create [
	^ stencil value
]

{ #category : #accessing }
GtExplicitHomeCard >> stencil: aBlockOrStencil [
	stencil := aBlockOrStencil
]
