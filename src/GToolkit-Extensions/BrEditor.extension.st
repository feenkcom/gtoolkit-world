Extension { #name : #BrEditor }

{ #category : #'*GToolkit-Extensions' }
BrEditor >> gtTextEditorModeProperty [
	<gtInspectorElementOverview>
	self viewModel ifNil: [ ^ nil ].
	
	^ GtInspectorElementOverviewProperty new
		label: 'Editor mode';
		object: [ self viewModel mode ]
]
