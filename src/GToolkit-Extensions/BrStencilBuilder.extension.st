Extension { #name : #BrStencilBuilder }

{ #category : #'*GToolkit-Extensions' }
BrStencilBuilder >> gtSourceCodeFor: aView [
	<gtView>
	(executor respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Source code';
		object: [ executor ];
		view: #gtSourceCodeFor:
]
