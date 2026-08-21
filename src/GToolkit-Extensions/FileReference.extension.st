Extension { #name : #FileReference }

{ #category : #'*GToolkit-Extensions' }
FileReference >> gtActionInspectBeaconJsonLogReaderFor: anAction [
	<gtAction>
	(self exists and: [ self isFile ]) ifFalse: [ ^ anAction noAction ].
	(self basename endsWith: 'beacon.log' caseSensitive: false)
		ifFalse: [ ^ anAction noAction ].

	^ anAction button
		priority: 80;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons note;
		tooltip: 'Read Beacon JSON log in reader';
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ self gtDisplayText ];
		action: [ :aButton | aButton phlow spawnObject: (GtBeaconJsonLogReader new filename: self) ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					withCommonSettings;
					objectInPager: (GtBeaconJsonLogReader new filename: self);
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'*GToolkit-Extensions' }
FileReference >> gtOpenWebBrowserActionFor: anAction [
	<gtAction>

	(self path isNetworkPath not and:
	[ (self isDirectory and: [ (self filesMatching: 'index.html;index.htm') size isZero not ]) ])
		ifFalse: [ ^ anAction noAction ].

	^ anAction button
		tooltip: 'Open in web browser';
		icon: BrGlamorousVectorIcons link;
		action: [ :aButton :aTab | 
			| someFiles |
			someFiles := self filesMatching: 'index.html;index.htm'.
			someFiles ifNotEmpty: [ 
				WebBrowser openOn: someFiles anyOne asZnUrl ] ]
]
