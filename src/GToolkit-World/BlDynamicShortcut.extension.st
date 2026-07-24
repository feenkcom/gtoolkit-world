Extension { #name : #BlDynamicShortcut }

{ #category : #'*GToolkit-World' }
BlDynamicShortcut >> spaceShortcutId: anId [
	self 
		shortcutId: anId 
		inRegistry: BlShortcutKeymapRegistry default space
]
