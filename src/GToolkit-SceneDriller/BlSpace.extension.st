Extension { #name : #BlSpace }

{ #category : #'*GToolkit-SceneDriller' }
BlSpace >> withSceneDriller [
	<spaceCommonSettings>
	self root addEventFilter: GtSceneDrillerEventHandler new
]

{ #category : #'*GToolkit-SceneDriller' }
BlSpace >> withScreenshotHandler [
	<spaceCommonSettings>
	self root
		addShortcut: (BlShortcutWithAction new
				name: 'Take screenshot';
				repeatable: false;
				spaceShortcutId: BlSpaceShortcutIds default takeScreenshotShortcutId;
				action: [ :aShortcutEvent :aShortcut | 
					aShortcutEvent currentTarget dispatchEvent: GtTakePicture new ]).
	self root
		when: GtTakePicture
		do: [ :anEvent | 
			| fileReference |
			anEvent consumed: true.
			fileReference := BlExporter png
					scaled: 2;
					element: anEvent currentTarget;
					export.
			Clipboard clipboardText: fileReference fullName ]
]

{ #category : #'*GToolkit-SceneDriller' }
BlSpace >> withZoomInOutShortcuts [
	<spaceCommonSettings>
	self root
		addShortcut: (BlShortcutWithAction new
				name: 'Zoom in';
				repeatable: false;
				spaceShortcutId: BlSpaceShortcutIds default zoomInShortcutId;
				action: [ :aShortcutEvent :aShortcut | BlSpace userScale: BlSpace userScale + 0.1 ]).
	self root
		addShortcut: (BlShortcutWithAction new
				name: 'Zoom out';
				repeatable: false;
				spaceShortcutId: BlSpaceShortcutIds default zoomOutShortcutId;
				action: [ :aShortcutEvent :aShortcut | BlSpace userScale: BlSpace userScale - 0.1 ]).
	self root
		addShortcut: (BlShortcutWithAction new
				name: 'Zoom normal';
				repeatable: false;
				spaceShortcutId: BlSpaceShortcutIds default zoomNormalShortcutId;
				action: [ :aShortcutEvent :aShortcut | BlSpace userScale: 1 ])
]
