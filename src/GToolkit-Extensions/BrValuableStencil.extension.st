Extension { #name : #BrValuableStencil }

{ #category : #'*GToolkit-Extensions' }
BrValuableStencil >> gtSourceCodeFor: aView [
	<gtView>
	(valuable respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source code';
		object: [ valuable ];
		view: #gtSourceCodeFor:
]
