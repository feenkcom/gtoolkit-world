Extension { #name : #BrMenuStreamingItems }

{ #category : #'*GToolkit-Extensions' }
BrMenuStreamingItems >> gtStreamFor: aView [
	<gtView>
	stream ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Items';
		object: [ stream ];
		view: #gtLiveFor:
]
