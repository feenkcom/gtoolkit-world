Extension { #name : #TGtWithTextualCoderViewModel }

{ #category : #'*GToolkit-Extensions' }
TGtWithTextualCoderViewModel >> gtTextualCoderModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Coder model';
		object: [ self hasTextualCoderViewModel
			ifTrue: [ self textualCoderViewModel coderModel ]
			ifFalse: [ nil ] ]
]

{ #category : #'*GToolkit-Extensions' }
TGtWithTextualCoderViewModel >> gtTextualCoderViewModelAndModelSubscriptionsProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Subscriptions';
		object: [ self hasTextualCoderViewModel
				ifTrue: [ GtTextualCoderSubscriptionOverview new
						subscriber: self;
						textualCoderViewModel: self textualCoderViewModel ]
				ifFalse: [ nil ] ]
]

{ #category : #'*GToolkit-Extensions' }
TGtWithTextualCoderViewModel >> gtTextualCoderViewModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Coder view model';
		object: [ self hasTextualCoderViewModel
			ifTrue: [ self textualCoderViewModel ]
			ifFalse: [ nil ] ]
]
