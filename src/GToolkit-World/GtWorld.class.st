Class {
	#name : #GtWorld,
	#superclass : #BlSpace,
	#instVars : [
		'worldElement'
	],
	#classInstVars : [
		'defaultId'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #'instance creation' }
GtWorld class >> buildWithDefaultTitle [
	| aSpace |
	aSpace := self new.
	aSpace title: self defaultTitle.
	aSpace extent: (800*1.6) @ 800.
	^ aSpace
]

{ #category : #accessing }
GtWorld class >> defaultId [
	^ defaultId
]

{ #category : #accessing }
GtWorld class >> defaultId: anId [
	"Set the id of the default space opened initially."
	defaultId := anId
]

{ #category : #defaults }
GtWorld class >> defaultTitle [
	^ 'Glamorous Toolkit'
]

{ #category : #'class initialization' }
GtWorld class >> initialize [
	"Register the handler to execute after the default priority that reads preferences."
	SessionManager default
		register: (ClassSessionHandler forClassNamed: self name)
		inCategory: SessionManager default guiCategory  
		atPriority: SessionManager default defaultPriority + 1
]

{ #category : #'class initialization' }
GtWorld class >> notifyDefaultInstance [
	self defaultId ifNil: [ ^ self ].
 	self
		spaceWithId: self defaultId 
		do: [ :aSpace | 
			aSpace enqueueTask: (BlTaskAction new action: [ 
				aSpace refreshContent ]) ] 
]

{ #category : #'instance creation' }
GtWorld class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := self new.
	aSpace title: self defaultTitle.
	aSpace knowledgeBase: LeDatabasesRegistry uniqueInstance 
		currentLoadedDefaultLogicalDatabase.
	aSpace show.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> openDefault [
	"Open an instance with shutdown handlers and mark it as default."
	<script: 'self openDefault'>
	| aSpace |
	aSpace := self buildWithDefaultTitle.
	aSpace knowledgeBase: LeDatabasesRegistry uniqueInstance 
		ensureDatabase.
	aSpace markAsDefault.
	aSpace prepareForRelease.
	aSpace show.
	
	GtImageSetup printNotRegisteredFFIMethods.
	[1 second wait. GtImageSetup printNotRegisteredFFIMethods.] fork.
	"Record a tally"
	"GtSpaceTallyHistory recordDefaultSystemWideDataLabeled: 'Open Default GtWorld'."
	
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> openOnCurrentDefaultDatabase [
	| aSpace |
	aSpace := self buildWithDefaultTitle.
	aSpace knowledgeBase: LeDatabasesRegistry uniqueInstance 
		defaultLogicalDatabase .
	aSpace markAsDefault.
	aSpace prepareForRelease.
	aSpace show.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> openWithSpaces: aCollectionOfSpaces [
	| aSpace |

	aSpace := self new.
	aSpace title: self defaultTitle.

	aCollectionOfSpaces do: [ :eachSpace |
		aSpace root showSpace: eachSpace ].
	aSpace knowledgeBase: LeDatabasesRegistry uniqueInstance 
		currentLoadedDefaultLogicalDatabase.

	aSpace show.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> openWithSpaces: aCollectionOfSpaces from: aSpace [
	| aNewSpace |
	aNewSpace := self openWithSpaces: aCollectionOfSpaces.
	aSpace class = self ifTrue: [ 
		aNewSpace knowledgeBase: aSpace knowledgeBase ].
	^ aNewSpace
]

{ #category : #updating }
GtWorld class >> requestAllInstancesHomeUpdate [
	self allInstances do: [ :aGtWorld |
		aGtWorld requestHomeUpdate ]
]

{ #category : #'api - notification' }
GtWorld class >> showNotification: aNotification [
	BlSpace
		spaceWithId: self defaultId 
		do: [ :aSpace | 
			aSpace showNotification: aNotification ].
]

{ #category : #'class initialization' }
GtWorld class >> startUp: resuming [
	"Implement an update mechanism to update the saved world on open."
	resuming
		ifFalse: [ ^ self ]. 
	self notifyDefaultInstance.
]

{ #category : #accessing }
GtWorld >> addShutdownListener [
	self addEventHandler: BlSpaceShutdownOnCloseListener new
]

{ #category : #accessing }
GtWorld >> database [
	^ self knowledgeBase
]

{ #category : #initialization }
GtWorld >> defaultTitle [
	^ self class defaultTitle
]

{ #category : #initialization }
GtWorld >> defaultWorldElement [
	^ GtWorldElement new
]

{ #category : #initialization }
GtWorld >> initialize [
	super initialize.
	worldElement := self defaultWorldElement beInSeparateCompositionLayer.
	worldElement
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ].
	self root addChild: worldElement.

	self withSceneDriller.
	self withWorldPreviewer.
	self withScreenshotHandler.
	self withGlamorousFullscreenMaxizimerHost.
	self withWorldCloseEventHandler
]

{ #category : #'focus managing' }
GtWorld >> initializeFocus [
	worldElement isFocusable
		ifTrue: [ worldElement requestFocus ]
]

{ #category : #accessing }
GtWorld >> knowledgeBase [
	^ worldElement knowledgeBase
]

{ #category : #accessing }
GtWorld >> knowledgeBase: aKnowledgeBase [
	worldElement knowledgeBase: aKnowledgeBase.
]

{ #category : #actions }
GtWorld >> markAsDefault [
	"Mark this instance as being the one that is saved and automatically opened when
	the image is opened. This instance will refresh it's content on start-up."
	self class defaultId: self id
]

{ #category : #actions }
GtWorld >> prepareForRelease [
	"Prepare this space to be saved as part of the release process."
	worldElement prepareForRelease
]

{ #category : #actions }
GtWorld >> refreshContent [
	"Refresh the content of the space. Is only called for the default instance on start-up."
	worldElement refreshContent
]

{ #category : #accessing }
GtWorld >> removeShutdownListener [
	self removeEventHandlersSuchThat: [ :eachHandler | eachHandler isKindOf: BlSpaceShutdownOnCloseListener ]
]

{ #category : #updating }
GtWorld >> requestHomeUpdate [
	self root children first home requestWidgetUpdate
]

{ #category : #'api - displaying' }
GtWorld >> showInGtWorld [
	self show
]

{ #category : #actions }
GtWorld >> showShutdownPrompt [
	worldElement showShutdownPrompt
]

{ #category : #'api - displaying' }
GtWorld >> showSpace: aSpace [
	worldElement showSpace: aSpace
]

{ #category : #'as yet unclassified' }
GtWorld >> tabGroup [
	^ worldElement children first
]

{ #category : #initialization }
GtWorld >> withWorldCloseEventHandler [
	self addEventHandler: GtWorldCloseEventHandler new
]

{ #category : #initialization }
GtWorld >> withWorldPreviewer [
	worldElement
		addShortcut: (BlShortcutWithAction new
				name: 'Open Previewer';
				repeatable: false;
				combination: BlKeyCombination builder primary shift t build;
				action: [ worldElement fireEvent: GtWorldPreviewerShowWish new ]).
	worldElement addEventHandler: GtWorldPreviewerEventHandler new
]
