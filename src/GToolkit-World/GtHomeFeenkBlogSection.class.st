Class {
	#name : #GtHomeFeenkBlogSection,
	#superclass : #GtHomeSection,
	#instVars : [
		'client'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #defaults }
GtHomeFeenkBlogSection class >> defaultClient [
	^ XdClient new
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection class >> newDefault [
	^ self new 
		client: self defaultClient
]

{ #category : #private }
GtHomeFeenkBlogSection >> addChildren: aNewCards in: aCardsContainer [
	aCardsContainer enqueueTask: (BlTaskAction new action: [ aCardsContainer 
		removeChildren;
		addChildren: aNewCards ])
]

{ #category : #defaults }
GtHomeFeenkBlogSection >> cardSize [
	^ 200 @ 100
]

{ #category : #accessing }
GtHomeFeenkBlogSection >> client [
	^ client
]

{ #category : #accessing }
GtHomeFeenkBlogSection >> client: anObject [
	client := anObject
]

{ #category : #'api - instantiation' }
GtHomeFeenkBlogSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := BrVerticalPane new fitContent.
	cardsContainer := BrVerticalPane new fitContent.
	sectionContainer addChild: (self newSectionTitleWithUpdatesIn: cardsContainer).
	self documentsInto: cardsContainer.
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #defaults }
GtHomeFeenkBlogSection >> defaultClient [
	^ XdClient null
]

{ #category : #blog }
GtHomeFeenkBlogSection >> documentsInto: aCardsContainer [
	| aClient |
	self flag: 'XdClient does not understand onSuccessDo: and onFailureDo:, we should implement it'.
	aClient := BlUseAsyncFeatures 
		ifEnabledDo: [ self client async ]
		otherwise: [ self client async ].
	aClient		 
		onSuccessDo: [ :aResult | self onPosts: aResult in: aCardsContainer ];
		onFailureDo: [ :anException | self onFailure: anException in: aCardsContainer ];
		documents
]

{ #category : #initialization }
GtHomeFeenkBlogSection >> initialize [
	super initialize.
	client := self defaultClient.
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newDocsExplorerWith: aCollectionOfPosts [
	^ self
		newHeaderCardWithTitle: 'Post'
		description: 'Browse all feenk blog posts.'
		size: self cardSize
		content:
			(BrLabel new
				text: 'More posts ...';
				aptitude: BrGlamorousLabelAptitude;
				padding: (BlInsets all: 20)) asScalableElement
		action: [ :card | 
			self
				showSpaceWithTitle: 'Feenk Blog'
				with: (GtInspector createOn: (GtBlogPostList new posts: aCollectionOfPosts))
				from: card ]
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newExceptionLabelFor: anException [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			foreground: BrGlamorousColors linkWithErrorColor;
			fontSize: 14);
		padding: self newSectionTitlePaddingInsets;
		text: anException messageText
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newPostCardContentFor: aXdFileInfo [
	| container |
	container := BrVerticalPane new 
		vFitContent;
		hMatchParent;
		padding: (BlInsets all: 5).
	container 
		addChild: (BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude;
			vFitContent;
			hMatchParent;
			beReadOnlyWithoutSelection;
			text: (self newTextFor: aXdFileInfo));
		addChild: (BrLabel new
			padding: (BlInsets left: 5);
			aptitude: (BrGlamorousLabelAptitude new foreground: Color gray); 
			text: 'by ', aXdFileInfo author);
		addChild: (BrLabel new
			padding: (BlInsets left: 5);
			aptitude: (BrGlamorousLabelAptitude new foreground: Color gray); 
			text: aXdFileInfo createdOn asLocalStringYMDHM).
	^ container
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newPostCardFor: aXdFileInfo [
	^ (self 
		newHeaderCardWithTitle: 'Post'
		description: aXdFileInfo title
		width: 200
		content: (self newPostCardContentFor: aXdFileInfo) 
		action: [ :aCard | 
			self
				showSpaceWithTitle: aXdFileInfo title
				with: (GtPagerSettings usedPager createWrappedOn: aXdFileInfo asElement)
				from: aCard ])
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newPostCardsFor: aCollectionOfPosts into: aStream [
	aCollectionOfPosts do: [ :eachXdFileInfo | 
		| anElement |
		anElement := self newPostCardFor: eachXdFileInfo.
		aStream nextPut: anElement ]
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newSectionTitleWithUpdatesIn: aCardsContainer [
	| aLabel aButton aContainer |
	aLabel := self newSectionTitle: 'blog.feenk.com'.
	aButton := self newSectionButtonWithIcon: BrGlamorousVectorIcons refresh.
	aButton margin: (BlInsets left: 5).
	aButton label: 'Update blog feed'.
	aButton action: [ :card | self documentsInto: aCardsContainer ].
	aButton beSmallSize.
	aContainer := self newSectionTitleContainer.
	^ aContainer addChild: aLabel; addChild: aButton
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newTextFor: aXdFileInfo [

	| aTitle aDescription aText |
	aTitle := aXdFileInfo title asString asRopedText.
	aTitle bold.
	aDescription := aXdFileInfo description asString asRopedText.
	aText := aTitle append: (String cr) asRopedText.
	aText := aTitle append: aDescription.
	^ aText
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newUpdateDocsContent [
	^ BrLabel new
		text: 'Update ...';
		aptitude: BrGlamorousLabelAptitude;
		padding: (BlInsets all: 20)
]

{ #category : #hooks }
GtHomeFeenkBlogSection >> onFailure: anException in: aCardsContainer [
	| aCard |
	aCard := self newExceptionLabelFor: anException.
	self addChildren: { aCard } in: aCardsContainer.
]

{ #category : #hooks }
GtHomeFeenkBlogSection >> onPosts: aCollectionOfPosts in: aCardsContainer [
	| newCards |
	newCards := OrderedCollection 
		streamContents: [ :aStream |
			self newPostCardsFor: aCollectionOfPosts into: aStream ]
		limitedTo: 5.
	newCards := newCards asOrderedCollection.
	newCards add: (self newDocsExplorerWith: aCollectionOfPosts).
	self addChildren: newCards in: aCardsContainer.
]
