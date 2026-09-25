Extension { #name : #GtPharoBehaviorDefinitionCoderElement }

{ #category : #'*GToolkit-Extensions' }
GtPharoBehaviorDefinitionCoderElement >> gtBehaviorCoderViewModelOverviewProperty [
	<gtInspectorElementOverview>
	self coderViewModel ifNil: [ ^ nil ].

	^ GtInspectorElementOverviewProperty new
		label: 'Behavior view model';
		object: [ self coderViewModel ]
]
