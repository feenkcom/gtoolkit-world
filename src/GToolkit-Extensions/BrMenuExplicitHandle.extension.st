Extension { #name : #BrMenuExplicitHandle }

{ #category : #'*GToolkit-Extensions' }
BrMenuExplicitHandle >> gtSourceCodeFor: aView [
	<gtView>
	(handleStencil respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Source code';
		object: [ (submenuStencil respondsTo: #gtSourceCodeFor:)
				ifTrue: [ submenuStencil ]
				ifFalse: [ handleStencil ] ];
		view: #gtSourceCodeFor:
]
