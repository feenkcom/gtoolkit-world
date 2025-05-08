Extension { #name : #BrTextTooltipsCache }

{ #category : #'*GToolkit-Extensions' }
BrTextTooltipsCache >> gtCacheFor: aView [
	<gtView>
	cache ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Cache';
		items: [ cache associations ];
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]
]
