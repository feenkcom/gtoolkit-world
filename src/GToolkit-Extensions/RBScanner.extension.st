Extension { #name : #RBScanner }

{ #category : #'*GToolkit-Extensions' }
RBScanner >> gtStreamStateFor: aView [
	<gtView>
	stream ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Stream';
		priority: 15;
		object: [ stream ];
		view: #gtStreamStateFor:
]
