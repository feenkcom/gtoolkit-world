Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-World' }
TBlDevScripterActionStep >> worldStep [
	^ self addStep: GtWorldElementStep new referenceSender
]
