Class {
	#name : #GtHomeLepiterKnowledgeBaseTabGroupElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'tabGroupElement',
		'tocTab',
		'tocPage',
		'isReloading',
		'isUnloaded',
		'dailyNotesTab',
		'updater'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> createDailyNotesElement [
	^ GtHomeLepiterDailyNotesElement new
		databaseViewModel: self database asContentUIModel
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> createDailyNotesTabElement [
	^ BrTab new
		aptitude: GtHomeLepiterCardTabAptitude new;
		label: 'Pages';
		stencil: [ self createDailyNotesElement ]
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> createTableOfContentsElement [
	^ GtHomeLepiterTableOfContentsElement new
		databaseViewModel: self database asContentUIModel
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> createTableOfContentsTabElement [
	^ BrTab new
		aptitude: GtHomeLepiterCardTabAptitude new;
		label: 'Table of contents';
		stencil: [ self createTableOfContentsElement ];
		selected: true
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> ensureDailyNotesTab [
	dailyNotesTab ifNil: [ dailyNotesTab := self createDailyNotesTabElement ].
	(tabGroupElement hasTab: dailyNotesTab) ifTrue: [ ^ self ].

	tabGroupElement addTab: dailyNotesTab.
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> ensureTableOfContentsTab [
	tocTab ifNil: [ tocTab := self createTableOfContentsTabElement ].
	(tabGroupElement hasTab: tocTab) ifTrue: [ ^ self ].

	tabGroupElement addTab: tocTab at: 1.
]

{ #category : #testing }
GtHomeLepiterKnowledgeBaseTabGroupElement >> hasTableOfContents [
	<return: #Boolean>
	^ self database tableOfContents isNotNil
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseTabGroupElement >> initialize [
	super initialize.
	isReloading := false.
	isUnloaded := true.
	self initializeUpdater.
	
	self initializeTabGroupElement.
	self addChild: tabGroupElement as: #group.

	self matchParent.
	self padding: (BlInsets all: 10)
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseTabGroupElement >> initializeTabGroupElement [
	tabGroupElement := BrTabGroup new
			aptitude: BrGlamorousTabGroupAptitude new;
			actionbarStencil: [ BrToolbar new
					aptitude: BrGlamorousToolbarAptitude new;
					addItem: self searchButton;
					yourself ]
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseTabGroupElement >> initializeUpdater [
	updater := BrElementUpdater new
			element: self selector: #updateElement;
			postponedDuration: 300 milliSeconds
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> isReloading [
	^ isReloading ifNil: [ false ]
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> isUnloaded [
	^ isUnloaded ifNil: [ self hasContent not ]
]

{ #category : #'api - ui model' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> onContentUIModelChanged [
	super onContentUIModelChanged.
	isUnloaded := false.
	self removeTableOfContentsTab.
	self removeDailyNotesTab.
	self onTableOfContentsPageUUIDChanged.
	self updateElement
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> onDatabaseAboutToReload: anAnnouncement [
	isReloading := true.
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> onDatabaseReloaded: anAnnouncement [
	isReloading := false.
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> onDatabaseUnloaded: anAnnouncement [
	isUnloaded := true.
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> onTableOfContentsPageUUIDChanged [
	| aNewTocPage |
	aNewTocPage := self tableOfContents.
	tocPage == aNewTocPage ifTrue: [ ^ self ].
	
	tocPage := aNewTocPage.
	self removeTableOfContentsTab.
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> onTableOfContentsPageUUIDChanged: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ 
			self onTableOfContentsPageUUIDChanged.
			self updateElement ]
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> removeDailyNotesTab [
	dailyNotesTab ifNil: [ ^ self ].
	tabGroupElement removeTab: dailyNotesTab.
	dailyNotesTab := nil
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> removeTableOfContentsTab [
	tocTab ifNil: [ ^ self ].
	tabGroupElement removeTab: tocTab.
	tocTab := nil
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> searchButton [
	^ GtSpotterDropdownButtonStencil new
		beSmallSize;
		aptitude: [ BrGlamorousButtonWithIconAptitude 
			- BrGlamorousButtonExteriorAptitude  ];
		valuable: (GtHomeLepiterKnowledgeBaseSpotterStart new databaseProvider: self);
		tooltip: 'Search Pages';
		objectActOn: [ :anActOnEvent :anItem :theButton | 
			theButton fireEvent: BrDropdownHideWish new.
			self spawnPage: anItem from: theButton.
			anActOnEvent beActed. ];
		asElement
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> spawnPage: aPage from: aButton [
	"If we are in a pager, spawn the page in the current phlow, else create a new pager."

	^ aButton phlow spaceBuilder spawnPage: aPage
]

{ #category : #'private - subscriptions' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> subscribeToContent [
	"Subclasses can subscribe to what they are interested in.
	All subscriptions to the model should be weak.
	Announcements may happen in a non-UI process."

	super subscribeToContent.
	self database weak
		when: LeDatabaseTableOfContentsUUIDChanged send: #onTableOfContentsPageUUIDChanged: to: self;
		when: LeDatabaseAboutToReload send: #onDatabaseAboutToReload: to: self;
		when: LeDatabaseReloaded send: #onDatabaseReloaded: to: self;
		when: LeLogicalDatabaseAboutToReload send: #onDatabaseAboutToReload: to: self;
		when: LeLogicalDatabaseReloaded send: #onDatabaseReloaded: to: self;
		when: LeDatabaseUnloadAnnouncement send: #onDatabaseUnloaded: to: self.
]

{ #category : #'private - subscriptions' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	self database unsubscribe: self
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> updateElement [
	self updateTabGroupElement
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> updateTabGroupElement [
	(self isUnloaded or: [ self isReloading ]) ifTrue: [
		self visibility: BlVisibility gone.
		self removeTableOfContentsTab.
		self removeDailyNotesTab.
		^ self ].

	self visibility: BlVisibility visible.
	
	self ensureDailyNotesTab.
	self hasTableOfContents
		ifTrue: [ self ensureTableOfContentsTab ]
		ifFalse: [ self removeTableOfContentsTab ]
]
