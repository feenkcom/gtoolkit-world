Extension { #name : #BlCurveElement }

{ #category : #'*GToolkit-Extensions' }
BlCurveElement >> fromAnchorProperty [
	<gtInspectorElementOverview>
	self fromAnchor ifNil: [ ^ nil ].

	^ GtInspectorElementOverviewProperty new
		label: ('From anchor {1}' format: {self fromAnchor gtDisplayString});
		object: [ self fromAnchor ]
]

{ #category : #'*GToolkit-Extensions' }
BlCurveElement >> toAnchorProperty [
	<gtInspectorElementOverview>
	self fromAnchor ifNil: [ ^ nil ].

	^ GtInspectorElementOverviewProperty new
		label: ('To anchor {1}' format: {self toAnchor gtDisplayString});
		object: [ self toAnchor ]
]
