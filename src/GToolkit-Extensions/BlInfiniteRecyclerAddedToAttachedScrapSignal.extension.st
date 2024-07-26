Extension { #name : #BlInfiniteRecyclerAddedToAttachedScrapSignal }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerAddedToAttachedScrapSignal >> gtFlagsFor: aView [
	<gtView>
	flags ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Flags';
		object: [ flags ];
		view: #gtItemsFor:
]
