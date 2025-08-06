Extension { #name : #BrMenuExplicit }

{ #category : #'*GToolkit-Extensions' }
BrMenuExplicit >> gtSourceCodeFor: aView [
	<gtView>
	(self stencil respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Source code';
		object: [ self stencil ];
		view: #gtSourceCodeFor:
]
