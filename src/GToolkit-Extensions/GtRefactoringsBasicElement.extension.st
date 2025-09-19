Extension { #name : #GtRefactoringsBasicElement }

{ #category : #'*GToolkit-Extensions' }
GtRefactoringsBasicElement >> gtRefactoringsViewModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Refactorings view model';
		object: [ self refactoringsViewModel ]
]
