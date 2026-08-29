Extension { #name : #LePageToolContentElement }

{ #category : #'*GToolkit-World' }
LePageToolContentElement >> gtActionInspectAllInnerTextEditorElementsFor: anAction [
	<gtAction>
	^ anAction button
		priority: 80;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect all inner text editor elements';
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ self gtDisplayText ];
		action: [ :aButton |
			aButton phlow spawnObject: (self query // GtSourceCoderEditorInnerId) ];
		primaryModifierAction: [ :aButton |
			BlSpace new
				withCommonSettings;
				objectInPager: (self query // GtSourceCoderEditorInnerId);
				showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]
