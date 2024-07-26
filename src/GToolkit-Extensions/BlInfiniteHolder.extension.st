Extension { #name : #BlInfiniteHolder }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteHolder >> gtItemElementFor: aView [
	<gtView>
	self itemElement ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Item element';
		object: [ self itemElement ];
		view: #gtLiveFor:
]
