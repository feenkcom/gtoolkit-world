Extension { #name : #GtPharoNewMethodCoderElement }

{ #category : #'*GToolkit-Extensions' }
GtPharoNewMethodCoderElement >> gtPharoMethodCoderModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Coder model';
		object: [ self hasPharoMethodCoderViewModel
			ifTrue: [ self pharoMethodCoderViewModel coderModel ]
			ifFalse: [ nil ] ]
]

{ #category : #'*GToolkit-Extensions' }
GtPharoNewMethodCoderElement >> gtPharoMethodCoderViewModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Coder view model';
		object: [ self hasPharoMethodCoderViewModel
			ifTrue: [ self pharoMethodCoderViewModel ]
			ifFalse: [ nil ] ]
]
