Extension { #name : #TGtWithTextualCoderViewModel }

{ #category : #'*GToolkit-Extensions' }
TGtWithTextualCoderViewModel >> gtActionInspectTextualCoderViewModelFor: anAction [
	<gtAction>
	^ anAction button
		priority: 80;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect coder view model';
		id: GtInspectorInspectButtonId;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ self textualCoderViewModel gtDisplayText ];
		action: [ :aButton | aButton phlow spawnObject: self textualCoderViewModel ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					withCommonSettings;
					objectInPager: self textualCoderViewModel;
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

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
