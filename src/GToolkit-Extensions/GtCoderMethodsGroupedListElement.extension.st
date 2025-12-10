Extension { #name : #GtCoderMethodsGroupedListElement }

{ #category : #'*GToolkit-Extensions' }
GtCoderMethodsGroupedListElement >> gtOverviewProperty [
	<gtInspectorElementOverview>
	self navigationModel ifNil: [ ^ self ].

	^ GtInspectorElementOverviewProperty new
		label: 'Navigation model';
		object: [ self navigationModel ]
]
