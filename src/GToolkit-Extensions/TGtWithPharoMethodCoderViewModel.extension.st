Extension { #name : #TGtWithPharoMethodCoderViewModel }

{ #category : #'*GToolkit-Extensions' }
TGtWithPharoMethodCoderViewModel >> gtPharoMethodCoderModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Coder model';
		object: [ self hasPharoMethodCoderViewModel
			ifTrue: [ self pharoMethodCoderViewModel coderModel ]
			ifFalse: [ nil ] ]
]

{ #category : #'*GToolkit-Extensions' }
TGtWithPharoMethodCoderViewModel >> gtPharoMethodCoderViewModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Coder view model';
		object: [ self hasPharoMethodCoderViewModel
			ifTrue: [ self pharoMethodCoderViewModel ]
			ifFalse: [ nil ] ]
]

{ #category : #'*GToolkit-Extensions' }
TGtWithPharoMethodCoderViewModel >> gtTextualCoderViewModelAndModelSubscriptionsProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Subscriptions';
		object: [ self hasPharoMethodCoderViewModel
				ifTrue: [ GtTextualCoderSubscriptionOverview new
						subscriber: self;
						textualCoderViewModel: self pharoMethodCoderViewModel ]
				ifFalse: [ nil ] ]
]
