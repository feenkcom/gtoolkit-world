Extension { #name : #BrTextEditorSignal }

{ #category : #'*GToolkit-Extensions' }
BrTextEditorSignal >> gtTestEditorFor: aView [
	<gtView>
	self textEditor ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Editor';
		priority: 0;
		object: [ self textEditor ];
		view: #gtLiveFor:
]
