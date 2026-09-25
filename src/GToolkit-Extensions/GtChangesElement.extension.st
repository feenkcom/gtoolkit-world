Extension { #name : #GtChangesElement }

{ #category : #'*GToolkit-Extensions' }
GtChangesElement >> gtElementOverviewPropertyOfChanges [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Changes';
		object: [ self changes ]
]
