Extension { #name : #GtTreePagerBasicElement }

{ #category : #'*GToolkit-Extensions' }
GtTreePagerBasicElement >> gtActionInspectPagerModelFor: anAction [
	<gtAction>
	self pagerModel ifNil: [ ^ anAction noAction ].
	
	^ anAction button
		priority: 78;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect pager model';
		id: GtInspectorInspectButtonId;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: self gtDisplayText;
		action: [ :aButton |
			aButton phlow spawnObject: self pagerModel ];
		primaryModifierAction: [ :aButton |
			BlSpace new
				withCommonSettings;
				objectInPager: self pagerModel;
				showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]
