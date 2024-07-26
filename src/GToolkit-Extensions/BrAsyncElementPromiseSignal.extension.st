Extension { #name : #BrAsyncElementPromiseSignal }

{ #category : #'*GToolkit-Extensions' }
BrAsyncElementPromiseSignal >> gtElementFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Element';
		priority: 1;
		object: [ self element ];
		view: #gtLiveFor:
]

{ #category : #'*GToolkit-Extensions' }
BrAsyncElementPromiseSignal >> gtPromiseFor: aView [
	<gtView>
	self promise ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Promise';
		priority: 1;
		object: [ self promise ];
		view: #gtPromiseFor:
]
