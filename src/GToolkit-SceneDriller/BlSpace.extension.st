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
				combination: BlKeyCombination primaryShiftP;
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
	"self addShortcut: (BlShortcutWithAction new
		name: 'Increase font size';
		combination: BlKeyCombination builder primary equal build;
		action: [ self increaseFontSize ]).
		
	self addShortcut: (BlShortcutWithAction new
		name: 'Decrease font size';
		combination: BlKeyCombination builder primary minus build;
		action: [ self decreaseFontSize ]).
		
	self addShortcut: (BlShortcutWithAction new
		name: 'Reset to default font size';
		combination: (BlKeyCombination builder primary key: BlKeyboardKey zero) build;
		action: [ self resetFontSize ])."

	<spaceCommonSettings>
	self root
		addShortcut: (BlShortcutWithAction new
				name: 'Zoom in';
				repeatable: false;
				combination: BlKeyCombination builder primary equal build;
				action: [ :aShortcutEvent :aShortcut | BlSpace userScale: BlSpace userScale + 0.1 ]).
	self root
		addShortcut: (BlShortcutWithAction new
				name: 'Zoom out';
				repeatable: false;
				combination: BlKeyCombination builder primary minus build;
				action: [ :aShortcutEvent :aShortcut | BlSpace userScale: BlSpace userScale - 0.1 ]).
	self root
		addShortcut: (BlShortcutWithAction new
				name: 'Zoom normal';
				repeatable: false;
				combination: (BlKeyCombination builder primary key: BlKeyboardKey zero) build;
				action: [ :aShortcutEvent :aShortcut | BlSpace userScale: 1 ])
]
