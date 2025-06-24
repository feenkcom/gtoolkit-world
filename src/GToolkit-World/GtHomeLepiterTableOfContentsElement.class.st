Class {
	#name : #GtHomeLepiterTableOfContentsElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'updater',
		'treeElement',
		'tocPage'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeLepiterTableOfContentsElement >> initialize [
	super initialize.
	self initializeUpdater.
	
	self initializeTreeElement.
	self addChild: treeElement as: #toc.

	self matchParent.
	self padding: (BlInsets all: 3)
]

{ #category : #accessing }
GtHomeLepiterTableOfContentsElement >> initializeTreeElement [
	treeElement := BrSimpleTree new.
	treeElement
		padding: (BlInsets
				top: 3
				right: 5
				bottom: 3
				left: 3);
		nodeStencil: [ GtHomeListItemElement new ];
		nodeDataBinder: [ :aLabel :aNode | aLabel item: aNode ];
		when: BrSelectionDoubleClicked
			do: [ :e | 
				e selection
					ifNotEmpty: [ :theIndices | 
						| selectedObject |
						selectedObject := e currentTarget viewModel itemAt: theIndices first.

						selectedObject value isForPage
							ifTrue: [ self spawnPage: selectedObject value page from: e currentTarget ] ] ].

	^ treeElement
]

{ #category : #accessing }
GtHomeLepiterTableOfContentsElement >> initializeUpdater [
	updater := BrElementUpdater new
			element: self selector: #updateElement;
			postponedDuration: 300 milliSeconds
]

{ #category : #'api - ui model' }
GtHomeLepiterTableOfContentsElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self onTableOfContentsPageUUIDChanged.
	self updateElement
]

{ #category : #'event handling' }
GtHomeLepiterTableOfContentsElement >> onTableOfContentsChanged: anAnnouncement [
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'event handling' }
GtHomeLepiterTableOfContentsElement >> onTableOfContentsPageUUIDChanged [
	| aNewPage |
	aNewPage := self tableOfContents.
	aNewPage == tocPage ifTrue: [ ^ self ].
	
	tocPage ifNotNil: [ :aPage | self unsubcribeFromTocPage ].
	tocPage := aNewPage.
	
	tocPage ifNil: [ ^ self ].
	self subscribeToTocPage.
]

{ #category : #'event handling' }
GtHomeLepiterTableOfContentsElement >> onTableOfContentsPageUUIDChanged: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ 
			self onTableOfContentsPageUUIDChanged.
			self onTableOfContentsChanged: anAnnouncement ]
]

{ #category : #'event handling' }
GtHomeLepiterTableOfContentsElement >> spawnPage: aPage from: aButton [
	"If we are in a pager, spawn the page in the current phlow, else create a new pager."

	^ BlSpace spawnPage: aPage from: aButton
]

{ #category : #'private - subscriptions' }
GtHomeLepiterTableOfContentsElement >> subscribeToContent [
	"Subclasses can subscribe to what they are interested in.
	All subscriptions to the model should be weak.
	Announcements may happen in a non-UI process."

	super subscribeToContent.
	self database weak
		when: LePageTitleChanged send: #onTableOfContentsChanged: to: self;
		when: LeDatabaseTableOfContentsUUIDChanged send: #onTableOfContentsPageUUIDChanged: to: self
]

{ #category : #'private - subscriptions' }
GtHomeLepiterTableOfContentsElement >> subscribeToTocPage [
	tocPage weak
		when: LeContentTreeChanged send: #onTableOfContentsChanged: to: self;
		when: LeSnippetContentChanged send: #onTableOfContentsChanged: to: self
]

{ #category : #accessing }
GtHomeLepiterTableOfContentsElement >> tableOfContentsNodes [
	^ self database tableOfContentsNodes
]

{ #category : #'private - subscriptions' }
GtHomeLepiterTableOfContentsElement >> unsubcribeFromTocPage [
	tocPage unsubscribe: self
]

{ #category : #'private - subscriptions' }
GtHomeLepiterTableOfContentsElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	self database unsubscribe: self
]

{ #category : #'private - updating' }
GtHomeLepiterTableOfContentsElement >> updateElement [
	self updateTreeElement
]

{ #category : #'private - updating' }
GtHomeLepiterTableOfContentsElement >> updateTreeElement [
	treeElement
		items: self tableOfContentsNodes lazy: #children;
		expandUpTo: 1
]
