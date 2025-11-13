Extension { #name : #BrEditor }

{ #category : #'*GToolkit-Extensions' }
BrEditor >> gtTextEditorModeProperty [
	<gtInspectorElementOverview>
	self viewModel ifNil: [ ^ nil ].
	
	^ GtInspectorElementOverviewProperty new
		label: 'Editor mode';
		object: [ self viewModel mode ]
]

{ #category : #'*GToolkit-Extensions' }
BrEditor >> gtTextEditorProperty [
	<gtInspectorElementOverview>
	
	^ GtInspectorElementOverviewProperty new
		label: 'Editor model';
		object: [ self editor ]
]

{ #category : #'*GToolkit-Extensions' }
BrEditor >> gtTextEditorWidgetModelProperty [
	<gtInspectorElementOverview>
	self viewModel ifNil: [ ^ nil ].
	
	^ GtInspectorElementOverviewProperty new
		label: 'Editor widget model';
		object: [ self viewModel ]
]
