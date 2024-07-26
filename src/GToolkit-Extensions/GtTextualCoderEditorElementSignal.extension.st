Extension { #name : #GtTextualCoderEditorElementSignal }

{ #category : #'*GToolkit-Extensions' }
GtTextualCoderEditorElementSignal >> gtElementFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Element';
		object: [ self element ];
		view: #gtLiveFor:
]
