Class {
	#name : #GtHomeLepiterKnowledgeBaseDescriptionElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'descriptionElement',
		'updater',
		'details'
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
	self initializeUpdater.
	
	self initializeDescriptionElement.
	self addChild: descriptionElement as: #description.

	self matchParent.
	self padding: (BlInsets all: 10)
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseDescriptionElement >> initializeDescriptionElement [
	descriptionElement := BrEditor new
			preventMeAndChildrenMouseEvents;
			padding: (BlInsets all: 10);
			aptitude: (BrGlamorousRegularEditorAptitude new foreground: Color black);
			text: ''
]

{ #category : #initialization }
GtHomeLepiterKnowledgeBaseDescriptionElement >> initializeUpdater [
	updater := BrElementUpdater new
			element: self selector: #updateElement
]

{ #category : #'api - ui model' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> onContentUIModelChanged [
	super onContentUIModelChanged.
	self onDescriptionTextChanged
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
		when: LeContentTreeRemoved send: #onDescriptionTextChanged: to: self
]

{ #category : #'private - subscriptions' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	self database unsubscribe: self
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> updateDescriptionElement [
	descriptionElement text: self descriptionText
]

{ #category : #'private - updating' }
GtHomeLepiterKnowledgeBaseDescriptionElement >> updateElement [
	self updateDescriptionElement
]
