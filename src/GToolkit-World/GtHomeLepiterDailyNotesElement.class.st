Class {
	#name : #GtHomeLepiterDailyNotesElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'groupedListElement',
		'updater'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #'private - updating' }
GtHomeLepiterDailyNotesElement >> createDailyNoteGroupFor: aDailyNote [
	^ BrGroup new
		stream: aDailyNote children asAsyncStream;
		domainObject: aDailyNote date;
		itemStencil: [ :aNodeType | 
			LePageTitleAndSummaryElement new
				hMatchParent;
				vFitContent;
				addAptitude: GtHomeLepiterCardListItemAptitude;
				margin: (BlInsets left: 3) ];
		itemDataBinder: [ :anItemElement :aPage | anItemElement contentViewModel: aPage asContentUIModel ]
]

{ #category : #accessing }
GtHomeLepiterDailyNotesElement >> dailyNotes [
	<return: #Collection of: #LeDailyNote>
	^ self database dailyNotesGroup
]

{ #category : #'private - updating' }
GtHomeLepiterDailyNotesElement >> dailyNotesGroup [
	<return: #TAsyncStream of: #BrGroup>
	^ self dailyNotes asAsyncStream
		collect: [ :aDailyNote | self createDailyNoteGroupFor: aDailyNote ]
]

{ #category : #initialization }
GtHomeLepiterDailyNotesElement >> initialize [
	super initialize.
	self initializeUpdater.
	
	self initializeGroupedListElement.
	self addChild: groupedListElement as: #group.

	self matchParent.
	self padding: (BlInsets all: 3)
]

{ #category : #initialization }
GtHomeLepiterDailyNotesElement >> initializeGroupedListElement [
	groupedListElement := BrGroupedList new
			padding: (BlInsets top: 3 right: 5 bottom: 3 left: 3);
			headerElementStencil: [ 
				BrLabel new
					beSmallSize;
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
					hMatchParent;
					vFitContent;
					margin: (BlInsets top: 3 left: 3) ];
			headerDataBinder: [ :aLabelElement :aGroup | 
				aLabelElement text: aGroup domainObject asString ];
			when: BrSelectionDoubleClicked
				do: [ :anEvent | 
					anEvent selection
						ifNotEmpty: [ :theIndices | 
							| selectedObject |
							selectedObject := anEvent currentTarget viewModel entityAt: theIndices first.
							self spawnPage: selectedObject itemObject from: anEvent currentTarget ] ];
			matchParent;
			groups: #()
]

{ #category : #initialization }
GtHomeLepiterDailyNotesElement >> initializeUpdater [
	updater := BrElementUpdater new
			element: self selector: #updateElement;
			postponedDuration: 300 milliSeconds
]

{ #category : #'api - ui model' }
GtHomeLepiterDailyNotesElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateElement
]

{ #category : #'event handling' }
GtHomeLepiterDailyNotesElement >> onDailyNotesChanged: anAnnouncement [
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'event handling' }
GtHomeLepiterDailyNotesElement >> spawnPage: aPage from: aButton [
	"If we are in a pager, spawn the page in the current phlow, else create a new pager."

	^ aButton
		allParentsDetect: [ :aParent | aParent isKindOf: GtPager ]
		ifFound: [ :aParent | aButton phlow spawnTool: aPage asPhlowTool ]
		ifNone: [ 
			GtWorldUtility
				showSpaceWithTitle: aPage title
				inPagerWith: [ aPage asLepiterPagePhlowTool asElementDo: [ :e | e ] ]
						asStencil
				from: aButton ]
]

{ #category : #'private - subscriptions' }
GtHomeLepiterDailyNotesElement >> subscribeToContent [
	"Subclasses can subscribe to what they are interested in.
	All subscriptions to the model should be weak.
	Announcements may happen in a non-UI process."

	super subscribeToContent.
	self flag: LeContentChangeSubscriber.
	self database weak
		when: LeDatabasePageAdded send: #onDailyNotesChanged: to: self;
		when: LeDatabasePageRemoved send: #onDailyNotesChanged: to: self;
		when: LePageTitleChanged send: #onDailyNotesChanged: to: self;
		when: LeContentTreeChanged send: #onDailyNotesChanged: to: self;
		when: LeSnippetContentChanged send: #onDailyNotesChanged: to: self.
]

{ #category : #'private - subscriptions' }
GtHomeLepiterDailyNotesElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	self database unsubscribe: self
]

{ #category : #'private - updating' }
GtHomeLepiterDailyNotesElement >> updateElement [
	self updateGroupedListElement
]

{ #category : #'private - updating' }
GtHomeLepiterDailyNotesElement >> updateGroupedListElement [
	groupedListElement stream: self dailyNotesGroup
]
