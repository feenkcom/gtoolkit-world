Extension { #name : #BrMenuModelElement }

{ #category : #'*GToolkit-Extensions' }
BrMenuModelElement >> gtMenuModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Menu model';
		object: [ self menuModel ]
]
