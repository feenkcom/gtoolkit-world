Extension { #name : #BlInfiniteElementSignal }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteElementSignal >> gtElementFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Element';
		priority: 20;
		object: [ self element ];
		view: #gtLiveFor:
]
