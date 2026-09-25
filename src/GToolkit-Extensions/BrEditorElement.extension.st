Extension { #name : #BrEditorElement }

{ #category : #'*GToolkit-Extensions' }
BrEditorElement >> gtActionInspectEditorModelFor: anAction [
	<gtAction>
	^ anAction button
		priority: 80;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect editor model';
		id: GtInspectorInspectButtonId;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: self editor gtDisplayText;
		action: [ :aButton | aButton phlow spawnObject: self editor ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					withCommonSettings;
					objectInPager: self editor;
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]
