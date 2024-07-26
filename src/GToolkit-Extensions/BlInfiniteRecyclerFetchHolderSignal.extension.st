Extension { #name : #BlInfiniteRecyclerFetchHolderSignal }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetchHolderSignal >> gtFetcherStepsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Steps';
		priority: 0.5;
		object: [ fetcherResult ];
		view: #gtFetcherStepsFor:
]

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetchHolderSignal >> gtItemElementFor: aView [
	<gtView>
	self fetcherResult ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Item element';
		object: [ self fetcherResult ];
		view: #gtItemElementFor:
]
