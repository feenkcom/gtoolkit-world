Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-World' }
TBlDevScripterActionStep >> worldStep [
	<scripterActionStep>
	
	^ self addStep: GtWorldElementStep new referenceSender
]
