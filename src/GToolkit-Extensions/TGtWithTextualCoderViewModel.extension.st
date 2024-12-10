Extension { #name : #TGtWithTextualCoderViewModel }

{ #category : #'*GToolkit-Extensions' }
TGtWithTextualCoderViewModel >> gtTextualCoderViewModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Coder view model';
		object: [ self hasTextualCoderViewModel
			ifTrue: [ self textualCoderViewModel ]
			ifFalse: [ nil ] ]
]
