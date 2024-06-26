Class {
	#name : #GtHomeLepiterKnowledgeBaseTabGroupElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'tabGroupElement',
		'tocTab',
		'tocPage'
	],
	#category : #'GToolkit-World-Sections'
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
		stencil: [ self createTableOfContentsElement ]
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

	self initializeTabGroupElement.
	self addChild: tabGroupElement as: #group.

	self matchParent.
	self padding: (BlInsets all: 10)
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseTabGroupElement >> initializeTabGroupElement [
	tabGroupElement := BrTabGroup new aptitude: BrGlamorousTabGroupAptitude new
]

{ #category : #'api - ui model' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	tabGroupElement tabs copy do: [ :eachTab | 
		tabGroupElement removeTab: eachTab ].
	tocTab := nil.
	tabGroupElement addTab: self createDailyNotesTabElement.
	self onTableOfContentsPageUUIDChanged.
	self updateElement
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
GtHomeLepiterKnowledgeBaseTabGroupElement >> removeTableOfContentsTab [
	tocTab ifNil: [ ^ self ].
	tabGroupElement removeTab: tocTab.
	tocTab := nil
]

{ #category : #'private - subscriptions' }
GtHomeLepiterKnowledgeBaseTabGroupElement >> subscribeToContent [
	"Subclasses can subscribe to what they are interested in.
	All subscriptions to the model should be weak.
	Announcements may happen in a non-UI process."

	super subscribeToContent.
	self database weak
		when: LeDatabaseTableOfContentsUUIDChanged send: #onTableOfContentsPageUUIDChanged: to: self
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
	self hasTableOfContents
		ifTrue: [ self ensureTableOfContentsTab ]
		ifFalse: [ self removeTableOfContentsTab ]
]
