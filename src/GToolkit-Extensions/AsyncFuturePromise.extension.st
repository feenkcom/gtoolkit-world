Extension { #name : #AsyncFuturePromise }

{ #category : #'*GToolkit-Extensions' }
AsyncFuturePromise >> gtCompositionChildren [
	^ super gtCompositionChildren copyWith: future
]
