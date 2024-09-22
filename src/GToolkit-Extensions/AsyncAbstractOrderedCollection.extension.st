Extension { #name : #AsyncAbstractOrderedCollection }

{ #category : #'*GToolkit-Extensions' }
AsyncAbstractOrderedCollection >> gtItemsFor: aView [
	<gtView>
	collection ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Items';
		object: [ self asArray ];
		view: #gtItemsFor:
]
