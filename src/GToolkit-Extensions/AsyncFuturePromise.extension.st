Extension { #name : #AsyncFuturePromise }

{ #category : #'*GToolkit-Extensions' }
AsyncFuturePromise >> gtCompositionChildren [
	^ { future }
]

{ #category : #'*GToolkit-Extensions' }
AsyncFuturePromise >> gtCompositionFor: aView [
	<gtView>
	
	future ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Future composition';
		object: [ future ];
		view: #gtCompositionFor:
]
