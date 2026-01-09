Extension { #name : #AsyncStreamTransitionBuffer }

{ #category : #'*GToolkit-Extensions' }
AsyncStreamTransitionBuffer >> gtBufferedItemsFor: aView [
	<gtView>
	^ aView forward
		title: 'New buffer items';
		priority: 5;
		object: [ newBuffer ];
		view: #gtBufferedItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncStreamTransitionBuffer >> gtPendingScanPromisesFor: aView [
	<gtView>
	pendingScanPromises ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Pending scan promises';
		object: [ pendingScanPromises ];
		view: #gtItemsFor:
]
