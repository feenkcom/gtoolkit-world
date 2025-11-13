Extension { #name : #AsyncFutureThreadPoolQueue }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolQueue >> gtItemsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Items';
		importantFutureExecutionConfiguration;
		priority: 10;
		object: [ queue ];
		view: #gtItemsFor:
]
