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
