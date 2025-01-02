Extension { #name : #GtPharoBehaviorCoderElement }

{ #category : #'*GToolkit-Extensions' }
GtPharoBehaviorCoderElement >> gtBehaviorCoderViewModelProperty [
	<gtInspectorElementOverview>
	behaviorCoderViewModel ifNil: [ ^ nil ].
	
	^ GtInspectorElementOverviewProperty new
		label: 'Behavior view model';
		object: [ behaviorCoderViewModel ]
]
