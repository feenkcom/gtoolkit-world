Extension { #name : #BrMenuInitialStencilBuilder }

{ #category : #'*GToolkit-Extensions' }
BrMenuInitialStencilBuilder >> gtSourceCodeFor: aView [
	<gtView>
	(executor respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Source code';
		object: [ executor ];
		view: #gtSourceCodeFor:
]
