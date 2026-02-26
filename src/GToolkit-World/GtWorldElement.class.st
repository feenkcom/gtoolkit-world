Class {
	#name : #GtWorldElement,
	#superclass : #GtWorldTabElement,
	#instVars : [
		'spotterDropdown',
		'subSpaceDropdown',
		'notificationsDropdown',
		'announcer'
	],
	#classVars : [
		'IsWorldSpotterPreviewDisplayed',
		'WorldSpotterSize'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #accessing }
GtWorldElement class >> isWorldSpotterPreviewDisplayed [
	^ IsWorldSpotterPreviewDisplayed ifNil: [ IsWorldSpotterPreviewDisplayed := true ]
]

{ #category : #'event handling' }
GtWorldElement class >> onShowWorldSpotterPreview: anAnnouncement [
	self showWorldSpotterPreview: anAnnouncement shouldShowPreview
]

{ #category : #accessing }
GtWorldElement class >> showWorldSpotterPreview: aBoolean [
	IsWorldSpotterPreviewDisplayed := aBoolean
]

{ #category : #accessing }
GtWorldElement class >> worldSpotterSize [
	^ WorldSpotterSize ifNil: [ WorldSpotterSize := 640@480 ]
]

{ #category : #accessing }
GtWorldElement class >> worldSpotterSize: aPoint [
	WorldSpotterSize := aPoint
]

{ #category : #accessing }
GtWorldElement >> announcer [
	^ announcer
]

{ #category : #updating }
GtWorldElement >> clearKnowledgeBase [
	| currentKnowledgeBase |
	currentKnowledgeBase := self home knowledgeBase.
	currentKnowledgeBase ifNotNil: [ :aKnowledgeBase | 
		self home clearKnowledgeBase.
		self announcer announce: (LeWorldElementDatabaseRemoved new
			database: aKnowledgeBase;
			source: self) ]
]

{ #category : #'accessing - elements' }
GtWorldElement >> currentNotificationsBadge [
	^ tabs childWithId: GtWorldNotificationsBadgeElementId 
]

{ #category : #'accessing - elements' }
GtWorldElement >> currentSpotterButton [
	^ tabs childWithId: GtWorldSpotterSearchElementId 
]

{ #category : #'accessing - elements' }
GtWorldElement >> currentSubSpaceButton [
	^ tabs childWithId: GtWorldMenuElementId 
]

{ #category : #accessing }
GtWorldElement >> database [
	^ self knowledgeBase
]

{ #category : #initialization }
GtWorldElement >> defaultHomeElement [
	^ GtHome new
]

{ #category : #'toolbar actions' }
GtWorldElement >> gtWorldNotificationsActionFor: anAction [
	<gtWorldAction>
	
	^ anAction explicit
		priority: 10;
		stencil: [ self newNotificationsBadge ]
]

{ #category : #'toolbar actions' }
GtWorldElement >> gtWorldSpotterActionFor: anAction [
	<gtAction>
	
	^ anAction explicit
		priority: 20;
		stencil: [ self newSpotterButton ]
]

{ #category : #'toolbar actions' }
GtWorldElement >> gtWorldStatusActionFor: anAction [
	<gtWorldAction>
	
	^ anAction explicit
		priority: 30;
		stencil: [ self newStatusButton ]
]

{ #category : #'toolbar actions' }
GtWorldElement >> gtWorldSubSpaceActionFor: anAction [
	<gtWorldAction>
	
	^ anAction explicit
		priority: 50;
		stencil: [ self newSubSpaceButton ]
]

{ #category : #'toolbar actions' }
GtWorldElement >> gtWorldSynchronizeActionFor: anAction [
	<gtWorldAction>
	
	GtImage isSyncEnabled 
		ifFalse: [ ^ anAction noAction ].
	
	^ anAction explicit
		priority: 40;
		stencil: [ self newSynchronizeButton ]
]

{ #category : #initialization }
GtWorldElement >> initialize [ 
	announcer := Announcer new.
	super initialize.
	
	self background: self theme default appBackground.
]

{ #category : #initialization }
GtWorldElement >> initializeListeners [
	super initializeListeners.

	self
		when: GtSpawnSpotter
		do: [ :anEvent | 
			anEvent consumed: true.
			self currentSpotterButton dispatchEvent: BrDropdownShowWish new ].
]

{ #category : #initialization }
GtWorldElement >> initializeShortcuts [
	super initializeShortcuts.
	self
		addShortcut: (BlShortcutWithAction new
				name: 'Open global Spotter';
				repeatable: false;
				combination: BlKeyCombination shiftReturn;
				action: [ self dispatchEvent: GtSpawnSpotter new ]).
	self
		addShortcut: (BlShortcutWithAction new
				name: 'Open global menu';
				repeatable: false;
				combination: BlKeyCombination primaryT;
				action: [ self currentSubSpaceButton
						ifNotNil: [ self currentSubSpaceButton
								dispatchEvent: (BrDropdownShowWish new
										anchor: self currentSubSpaceButton;
										yourself) ] ]).
	self
		addShortcut: (BlShortcutWithAction new
				name: 'Select previous tab';
				repeatable: true;
				combination: (BlKeyCombinationBuilder new primary shift key: BlKeyboardKey leftBracket) build;
				action: [ self tabs selectTabToTheLeft ]).
	self
		addShortcut: (BlShortcutWithAction new
				name: 'Select next tab';
				repeatable: true;
				combination: (BlKeyCombinationBuilder new primary shift key: BlKeyboardKey rightBracket)
						build;
				action: [ self tabs selectTabToTheRight ]).
	self
		addShortcut: (BlShortcutWithAction new
				name: 'Close tab';
				repeatable: true;
				combination: BlKeyCombination primaryW;
				action: (BrTabGroupPreventableSelectedTabCloseAction new
					tabGroup: self tabs;
					keepContentElement: home;
					inquire)).
	self
		addShortcut: (BlShortcutWithAction new
				name: 'Close world';
				repeatable: true;
				combination: BlKeyCombination primaryQ;
				action: [ self spaceDo: [ :aSpace | aSpace requestClose ] ])
]

{ #category : #accessing }
GtWorldElement >> knowledgeBase [
	^ self home knowledgeBase
]

{ #category : #accessing }
GtWorldElement >> knowledgeBase: aKnowledgeBase [
	self home knowledgeBase:  aKnowledgeBase.
	self announcer announce: (LeWorldElementDatabaseChanged new
		database: aKnowledgeBase;
		source: self)
]

{ #category : #initialization }
GtWorldElement >> newActionItemsInto: anActionbar [
	super newActionItemsInto: anActionbar.

	self worldToolbarActions do: [ :each | 
		each
			asElement: [ :actionElement | 
				anActionbar addItem: actionElement ]
			withHostElement: anActionbar ]
]

{ #category : #'private - instance creation' }
GtWorldElement >> newNotificationsBadge [
	 ^ GtNotificationsBadgeElement new
			id: GtWorldNotificationsBadgeElementId;
			addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: 'Notifications');
			hide.
]

{ #category : #'private - instance creation' }
GtWorldElement >> newSpotterButton [
	| newspotterDropdown |
	
	newspotterDropdown := GtSpotterDropdownButtonStencil new
		id: GtWorldSpotterSearchElementId;
		tooltip: 'Search';
		valuable: [ GtWorldSpotterSearchStart new
			knowledgeBase: self knowledgeBase ];
		extent: [ self class worldSpotterSize ];
		showPreview: [ self class isWorldSpotterPreviewDisplayed ];
		onPreviewChangedSend: #onShowWorldSpotterPreview: to: self class;
		spotterElementDo: [ :aSpotterElement |
			aSpotterElement 
				when: GtSpotterResizedEvent 
				do: [ :anEvent | 
					self onResizedSpotter: aSpotterElement event: anEvent ] ];
		actOn: [ :anAnnouncement :aRawObject :aButton |
			anAnnouncement beActed.
			aButton phlow spawnTool: anAnnouncement toolToSend ];
		asElement.
	newspotterDropdown aptitude - BrGlamorousButtonExteriorAptitude.
	newspotterDropdown
		when: GtPhlowObjectToSpawn
		do: [ :anEvent |
			anEvent consumed: true.
			
			anEvent object gtSpotterActDefaultFrom: self currentSpotterButton ].

	^ newspotterDropdown
]

{ #category : #'instance creation' }
GtWorldElement >> newStatusButton [
	"Answer a dropdown button for the  status of knowledge base associated with the current world"

	^ LeWorldStatusDropdown new
		leWorldElement: self
]

{ #category : #'private - instance creation' }
GtWorldElement >> newSubSpaceButton [
	| newSubSpaceDropdown |
	
	newSubSpaceDropdown := BrButton new
			id: GtWorldMenuElementId;
			aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude
					+ (BrGlamorousWithExplicitDropdownAptitude new
							withGainFocusOnShow;
							handle: [ BrButton new
										aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
												- BrGlamorousButtonExteriorAptitude;
										icon: BrGlamorousVectorIcons hamburger;
										label: 'Menu';
										yourself ]
								content: [ BrScrollPane new
										aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
										hExact: 420;
										vMatchParent;
										content: (GtToolsMenu new
												knowledgeBase: self knowledgeBase;
												yourself) ]);
			icon: BrGlamorousVectorIcons hamburger;
			label: 'Menu';
			yourself.
			
	^ newSubSpaceDropdown
]

{ #category : #accessing }
GtWorldElement >> newSynchronizeButton [
	"Answer a dropdown button for syncronizing databases"

	^ #LeSyncClientAccountSyncBadge asClass new
		leWorldElement: self
]

{ #category : #'hooks - children' }
GtWorldElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	SystemAnnouncer uniqueInstance weak
		when: ClassAnnouncement
		send: #update:
		to: self home. 

	SystemAnnouncer uniqueInstance weak
		when: MethodAnnouncement
		send: #update:
		to: self home. 
]

{ #category : #'hooks - children' }
GtWorldElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	SystemAnnouncer uniqueInstance unsubscribe: self home
]

{ #category : #'private - instance creation' }
GtWorldElement >> onResizedSpotter: aSpotterElement event: anEvent [
	self class worldSpotterSize: aSpotterElement extent
]

{ #category : #updating }
GtWorldElement >> prepareForRelease [
	self home prepareForRelease.
]

{ #category : #updating }
GtWorldElement >> refreshContent [
	"Refresh all notifications in the home screen."
	self home refreshNotifications
]

{ #category : #'api - notification' }
GtWorldElement >> removeNotification: aNotification [
	self currentNotificationsBadge ifNotNil: [ :anElement | 
		anElement removeNotification: aNotification ]
]

{ #category : #'api - notification' }
GtWorldElement >> showNotification: aNotification [
	"I am a root element of the default space ID, I will display the notification."
	self currentNotificationsBadge ifNotNil: [ :anElement | 
		anElement notification: aNotification ]
]

{ #category : #toolbar }
GtWorldElement >> worldToolbarActions [
	^ GtPhlowActionsCollector new
		pragmaName: #gtWorldAction;
		fromObject: self;
		collect
]
