Extension { #name : #GtPharoSubscribedToMethodCoderSignal }

{ #category : #'*GToolkit-Extensions' }
GtPharoSubscribedToMethodCoderSignal >> gtMethodCoderFor: aView [
	<gtView>
	self methodCoder ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Coder';
		object: [ self methodCoder ];
		view: #gtLiveFor:
]
