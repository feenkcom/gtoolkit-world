Class {
	#name : #GtHomeLepiterKnowledgeBaseDescriptionElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'descriptionElement',
		'updater',
		'details',
		'isReloading',
		'isUnloaded'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #'api - details' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> descriptionText [
	<return: #BlText or: #String>
	^ self details value: self database
]

{ #category : #'api - details' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> details [
	^ details ifNil: [ details := [ :aLeDatabase | aLeDatabase databaseName ] ].
]

{ #category : #'api - details' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> details: aBlock [
	"Block receives a database instance: [ :aLeDatabase | ].
	The block must return BlText or String instance"

	details := aBlock.
	
	self onDescriptionTextChanged
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseDescriptionElement >> initialize [
	super initialize.
	isReloading := false.
	isUnloaded := true.
	self initializeUpdater.
	
	self initializeDescriptionElement.
	self addChild: descriptionElement as: #'gt-home--lepiter-db-desciption'.

	self matchParent.
	self padding: (BlInsets all: 10)
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseDescriptionElement >> initializeDescriptionElement [
	descriptionElement := BrEditor new
			preventMeAndChildrenMouseEvents;
			padding: (BlInsets all: 10);
			aptitude: BrGlamorousRegularEditorAptitude;
			text: ''
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseDescriptionElement >> initializeUpdater [
	updater := BrElementUpdater new
			element: self selector: #updateElement;
			postponedDuration: 300 milliSeconds
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> isReloading [
	^ isReloading ifNil: [ false ]
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> isUnloaded [
	^ isUnloaded ifNil: [ self hasContent not ]
]

{ #category : #'api - ui model' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> onContentUIModelChanged [
	isUnloaded := false.
	super onContentUIModelChanged.
	self onDescriptionTextChanged
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> onDatabaseAboutToReload: anAnnouncement [
	isReloading := true.
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> onDatabaseReloaded: anAnnouncement [
	isReloading := false.
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> onDatabaseUnloaded: anAnnouncement [
	isUnloaded := true.
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> onDescriptionTextChanged [
	self assertUIProcess.
	self updateElement
]

{ #category : #'event handling' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> onDescriptionTextChanged: anAnnouncement [
	updater ifNil: [ ^ self ].
	updater requestUpdate
]

{ #category : #'private - subscriptions' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> subscribeToContent [
	"Subclasses can subscribe to what they are interested in.
	All subscriptions to the model should be weak.
	Announcements may happen in a non-UI process."

	super subscribeToContent.
	self database weak
		when: LeDatabasePageAdded send: #onDescriptionTextChanged: to: self;
		when: LeDatabasePageRemoved send: #onDescriptionTextChanged: to: self;
		when: LeContentTreeAdded send: #onDescriptionTextChanged: to: self;
		when: LeContentTreeRemoved send: #onDescriptionTextChanged: to: self;
		when: LeDatabaseAboutToReload send: #onDatabaseAboutToReload: to: self;
		when: LeDatabaseReloaded send: #onDatabaseReloaded: to: self;
		when: LeLogicalDatabaseAboutToReload send: #onDatabaseAboutToReload: to: self;
		when: LeLogicalDatabaseReloaded send: #onDatabaseReloaded: to: self;
		when: LeDatabaseUnloadAnnouncement send: #onDatabaseUnloaded: to: self.
]

{ #category : #'private - subscriptions' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	self database unsubscribe: self
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> updateDescriptionElement [
	self isUnloaded
		ifTrue: [ 
			descriptionElement text: 'Contents not yet loaded.'.
			descriptionElement aptitude
				foreground: self theme button disabledTextColor.
			^ self ].

	self isReloading
		ifFalse: [ 
			descriptionElement text: self descriptionText.
			descriptionElement aptitude
				foreground: self theme editor defaultTextForeground. ]
		ifTrue: [ 
			descriptionElement text: 'Reloading...'.
			descriptionElement aptitude
				foreground: self theme button disabledTextColor. ]
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> updateElement [
	self updateDescriptionElement
]
