Extension { #name : #BlInfiniteRecyclerAboutToRecycleInPoolSignal }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerAboutToRecycleInPoolSignal >> gtItemElementFor: aView [
	<gtView>
	self holder ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Item element';
		object: [ self holder ];
		view: #gtItemElementFor:
]
