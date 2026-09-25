Extension { #name : #BlSpaceKeymapRegistry }

{ #category : #'*GToolkit-World' }
BlSpaceKeymapRegistry >> initializeWorldShortcutCombinations [
	<gtKeymapRegistration>
	self 
		initializeShortcut: BlSpaceShortcutIds default openSpotterShortcutId
		with: BlKeyCombination shiftReturn.
	self 
		initializeShortcut: BlSpaceShortcutIds default openGlobalMenuShortcutId
		with: BlKeyCombination primaryT.
	self 
		initializeShortcut: BlSpaceShortcutIds default selectPreviousTabShortcutId
		with: (BlKeyCombinationBuilder new primary shift 
			key: BlKeyboardKey leftBracket) build.
	self 
		initializeShortcut: BlSpaceShortcutIds default selectNextTabShortcutId
		with: (BlKeyCombinationBuilder new primary shift 
			key: BlKeyboardKey rightBracket) build.
	self 
		initializeShortcut: BlSpaceShortcutIds default closeTabShortcutId
		with: BlKeyCombination primaryW.
	self 
		initializeShortcut: BlSpaceShortcutIds default closeWorldShortcutId
		with: BlKeyCombination primaryQ.
	self 
		initializeShortcut: BlSpaceShortcutIds default openPreviewerShortcutId
		with: (BlKeyCombination builder primary shift t build)
]
