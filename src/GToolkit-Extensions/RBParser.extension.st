Extension { #name : #RBParser }

{ #category : #'*GToolkit-Extensions' }
RBParser >> gtStreamStateFor: aView [
	<gtView>
	scanner ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Scanner stream';
		priority: 15;
		object: [ scanner ];
		view: #gtStreamStateFor:
]
