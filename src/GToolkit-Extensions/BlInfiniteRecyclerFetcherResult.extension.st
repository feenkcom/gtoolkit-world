Extension { #name : #BlInfiniteRecyclerFetcherResult }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetcherResult >> gtFetcherSteps [
	^ #()
]

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetcherResult >> gtFetcherStepsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Steps';
		priority: 5;
		items: [ self gtFetcherSteps ];
		children: #gtFetcherSteps;
		expandAll;
		column: 'Fetcher' text: #gtDescription
]

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetcherResult >> gtItemElementFor: aView [
	<gtView>
	self holder ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Item element';
		object: [ self holder ];
		view: #gtItemElementFor:
]
