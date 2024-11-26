Extension { #name : #GtPhlowSpaceBuilder }

{ #category : #'*GToolkit-World' }
GtPhlowSpaceBuilder >> showInGtWorld [
	<return: #GtWorld>
	| aSpace aWorldSpace |
	aSpace := self create.

	aWorldSpace := GtWorld openWithSpaces: {aSpace}.
	self extent ifNotNil: [ :aPoint | 
		aWorldSpace extent: aPoint ].

	^ aWorldSpace
]
