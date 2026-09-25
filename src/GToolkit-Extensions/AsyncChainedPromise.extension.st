Extension { #name : #AsyncChainedPromise }

{ #category : #'*GToolkit-Extensions' }
AsyncChainedPromise >> gtFulfilledComputationSourceCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Source code';
		object: [ fulfilledComputation ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncChainedPromise >> gtFulfilledComputationVariablesFor: aView [
	<gtView>
	fulfilledComputation ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Variables';
		object: [ fulfilledComputation ];
		view: #gtVariablesFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncChainedPromise >> gtHandlesErrors [
	"Return true if the promise is able to handle errors"

	^ rejectedComputation notNil
]

{ #category : #'*GToolkit-Extensions' }
AsyncChainedPromise >> gtPrecedingPromises [
	"Return a collection promises on which this promise depends"
	<return: #Collection of: #TAsyncPromise>

	^ { previousPromise }
]
