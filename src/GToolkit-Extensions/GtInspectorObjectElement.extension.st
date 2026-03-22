Extension { #name : #GtInspectorObjectElement }

{ #category : #'*GToolkit-Extensions' }
GtInspectorObjectElement >> gtObjectHolderOverviewProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Object holder';
		object: [ self objectHolder ]
]

{ #category : #'*GToolkit-Extensions' }
GtInspectorObjectElement >> gtObjectOverviewProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Object';
		object: [ self object ]
]
