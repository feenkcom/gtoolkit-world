Extension { #name : #BlElementBoundsUpdaterChange }

{ #category : #'*GToolkit-Extensions' }
BlElementBoundsUpdaterChange >> gtElementFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Element';
		priority: 20;
		object: [ self element ];
		view: #gtLiveFor:
]
