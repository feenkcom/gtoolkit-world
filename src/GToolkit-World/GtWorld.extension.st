Extension { #name : #GtWorld }

{ #category : #'*GToolkit-World' }
GtWorld >> withWorldPreviewer [
	worldElement
		addShortcut: (BlShortcutWithAction new
				name: 'Open Previewer';
				repeatable: false;
				combination: BlKeyCombination builder primary shift t build;
				action: [ worldElement fireEvent: GtWorldPreviewerShowWish new ]).
	worldElement addEventHandler: GtWorldPreviewerEventHandler new
]
