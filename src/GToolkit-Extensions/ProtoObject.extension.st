Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Extensions' }
ProtoObject >> gtActionBrowseFor: anAction [
	<gtAction>
	^ anAction button
		priority: 70;
		target: GtPhlowObjectContextMenuTarget;
		id: GtInspectorBrowseButtonId;
		tooltip: 'Browse class for current object';
		icon: BrGlamorousVectorIcons emphasizedBrowse;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: self class instanceSide name;
		action: [ :aButton | 
			aButton phlow
				spawnTool: (GtPhlowExplicitTool new
					name: self class name;
					stencil: [ GtCoderElement forObject: self ]) ];
		primaryModifierAction: [ :aButton | self gtBrowseFrom: aButton ]
			mouseCursor: BlCopyCursor new
]
