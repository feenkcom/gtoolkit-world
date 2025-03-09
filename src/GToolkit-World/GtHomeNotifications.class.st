Class {
	#name : #GtHomeNotifications,
	#superclass : #BlElement,
	#category : #'GToolkit-World-UI'
}

{ #category : #updating }
GtHomeNotifications >> availableNotifications [
	^ { 
		self takeATourNotification 
	}
]

{ #category : #updating }
GtHomeNotifications >> clearContent [
	self removeChildren.
	self visibility: BlVisibility gone
]

{ #category : #testing }
GtHomeNotifications >> hasNotifications [
	^ self hasChildren 
]

{ #category : #initialization }
GtHomeNotifications >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
]

{ #category : #'instance creation' }
GtHomeNotifications >> showSpaceWithTitle: aString with: anElement from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace extent: 1200@600.
	aSpace addChild: anElement asElement.
	aSpace withHalos.
	anotherElement showSpace: aSpace
]

{ #category : #accessing }
GtHomeNotifications >> statusRegistry [
	^ GtNotificationStatusRegistry loadDefault
]

{ #category : #'instance creation' }
GtHomeNotifications >> takeATourNotification [
	| database |
	^ GtNotification new
		id: 'notification/take-a-tour';
		openAction: [ :cardElement | 
			| aPage |
			database := LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
					databases detect: [ :each | each databaseName = 'Glamorous Toolkit Book' ].
			aPage := database pages
					detect: [ :each | each title = 'Get started' ].
			BlSpace new
				title: aPage title;
				inPager: [ aPage asLepiterPagePhlowTool asElementDo: [ :e | e ] ] asStencil;
				showFrom: cardElement ];
		refreshAction: [ self updateWidget ];
		cardStencil: (GtNotificationCardStencil new
				headerText: 'New to Glamorous Toolkit?';
				actionText: 'Get started';
				tooltipText: 'Get started with the steps from the Glamorous Toolkit book')
]

{ #category : #updating }
GtHomeNotifications >> updateWidget [
	| availableNotifications validNotifications statusRegistry |
	availableNotifications := self availableNotifications.
	
	statusRegistry := self statusRegistry.
	availableNotifications do: [ :aNews |
		aNews status: (statusRegistry statusForId: aNews id) ].
	
	validNotifications := availableNotifications reject: [ :aNews | 
		aNews status isViewed or: [
			aNews status isDismissed ] ].
	
	self removeChildren.
	validNotifications 
		ifEmpty: [
			self visibility: BlVisibility gone ]
		ifNotEmpty: [ validNotifications do: [ :aNews |
			self visibility: BlVisibility visible.
			self addChild: aNews cardStencil create ] ]
]
