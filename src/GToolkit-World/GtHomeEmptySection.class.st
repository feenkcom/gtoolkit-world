Class {
	#name : #GtHomeEmptySection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #'api - instantiation' }
GtHomeEmptySection >> create [
	^ BrFrame new
]

{ #category : #testing }
GtHomeEmptySection >> isEmptySection [
	^ true
]
