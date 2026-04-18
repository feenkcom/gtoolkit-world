Extension { #name : #GtExpandableSourceCoderElement }

{ #category : #'*GToolkit-Extensions' }
GtExpandableSourceCoderElement >> gtActionInspectInnerTextEditorFor: anAction [
	<gtAction>
	^ anAction button
		priority: 80;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect inner text editor';
		id: GtInspectorInspectButtonId;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ (self query // GtSourceCoderEditorInnerId) anyOne gtDisplayText ];
		action: [ :aButton | aButton phlow spawnObject: (self query // GtSourceCoderEditorInnerId) anyOne ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					withCommonSettings;
					objectInPager: (self query // GtSourceCoderEditorInnerId) anyOne;
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'*GToolkit-Extensions' }
GtExpandableSourceCoderElement >> gtActionInspectInnerTextEditorModelFor: anAction [
	<gtAction>
	((self query // GtSourceCoderEditorInnerId) anyOne isKindOf: BrEditorElement)
		ifFalse: [ ^ anAction noAction ].

	^ anAction button
		priority: 81;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect inner text editor model';
		id: GtInspectorInspectButtonId;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ (self query // GtSourceCoderEditorInnerId) anyOne editor gtDisplayText ];
		action: [ :aButton | 
			aButton phlow
				spawnObject: (self query // GtSourceCoderEditorInnerId) anyOne editor ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					withCommonSettings;
					objectInPager: (self query // GtSourceCoderEditorInnerId) anyOne editor;
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]
