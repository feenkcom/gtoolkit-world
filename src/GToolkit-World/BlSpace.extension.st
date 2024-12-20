Extension { #name : #BlSpace }

{ #category : #'*GToolkit-World' }
BlSpace >> showInGtWorld [
	<return: #GtWorld>
	| aWorldSpace |
	aWorldSpace := GtWorld openWithSpaces: {self}.
	self extent ifNotNil: [ :aPoint | 
		aWorldSpace extent: aPoint ].
	aWorldSpace show.
		
	^ aWorldSpace
]
