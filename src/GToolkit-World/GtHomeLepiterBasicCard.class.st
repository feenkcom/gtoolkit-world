Class {
	#name : #GtHomeLepiterBasicCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'databaseFinder',
		'pageFinder'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #private }
GtHomeLepiterBasicCard >> createDailyNoteGroupFor: aDailyNote [
	^ BrGroup new
		stream: aDailyNote children asAsyncStream;
		domainObject: aDailyNote date;
		itemStencil: [ :aNodeType | 
			LePageTitleAndSummaryElement new
				hMatchParent;
				vFitContent;
				addAptitude: GtHomeLepiterCardListItemAptitude;
				margin: (BlInsets left: 3) ];
		itemDataBinder: [ :anItemElement :aPage | 
			anItemElement contentViewModel: aPage asContentUIModel ]
]

{ #category : #'api - database' }
GtHomeLepiterBasicCard >> dailyNotes [
	<return: #Collection of: #LeDailyNote>
	^ self database dailyNotesGroup
]

{ #category : #'private - widgets' }
GtHomeLepiterBasicCard >> dailyNotesGroup [
	<return: #TAsyncStream of: #BrGroup>
	^ self dailyNotes asAsyncStream
		collect: [ :aDailyNote | self createDailyNoteGroupFor: aDailyNote ]
]

{ #category : #'api - database' }
GtHomeLepiterBasicCard >> database [
	<return: #LeDatabase>
	^ self databaseFinder database
]

{ #category : #'api - database' }
GtHomeLepiterBasicCard >> databaseFinder [
	<return: #TGtHomeLepiterKnowledgeBaseFinder>
	^ databaseFinder
]

{ #category : #'api - database' }
GtHomeLepiterBasicCard >> databaseFinder: aFinder [
	databaseFinder := aFinder
]

{ #category : #'api - database' }
GtHomeLepiterBasicCard >> databaseName: aLeDatabaseName [
	self
		databaseFinder: (GtHomeLepiterByDatabaseNameFinder new databaseName: aLeDatabaseName)
]

{ #category : #'api - database' }
GtHomeLepiterBasicCard >> hasTableOfContents [
	<return: #Boolean>
	^ self database tableOfContents isNotNil
]

{ #category : #initialization }
GtHomeLepiterBasicCard >> initialize [
	super initialize.
	self primaryKnowledgebase.
	self recentlyEditedPage.
]

{ #category : #'api - page' }
GtHomeLepiterBasicCard >> page [
	<return: #LePage>
	^ self pageFinder pageIn: self database
]

{ #category : #'api - page' }
GtHomeLepiterBasicCard >> page: aLePage [
	self pageFinder: (GtHomeLepiterExplicitPageFinder new page: aLePage)
]

{ #category : #'api - page' }
GtHomeLepiterBasicCard >> pageFinder [
	<return: #TGtHomeLepiterPageFinder>
	^ pageFinder
]

{ #category : #'api - page' }
GtHomeLepiterBasicCard >> pageFinder: anObject [
	pageFinder := anObject
]

{ #category : #'api - page' }
GtHomeLepiterBasicCard >> pageName [
	<return: #String or: nil>
	^ (self pageFinder pageIn: self database) title
]

{ #category : #'api - page' }
GtHomeLepiterBasicCard >> pageName: aPageName [
	self pageFinder: (GtHomeLepiterPageNameFinder new pageName: aPageName)
]

{ #category : #'api - database' }
GtHomeLepiterBasicCard >> primaryKnowledgebase [
	self databaseFinder: GtHomeLepiterPrimaryDatabaseFinder new
]

{ #category : #'api - page' }
GtHomeLepiterBasicCard >> recentlyEditedPage [
	self pageFinder: GtHomeLepiterRecentlyEditedPageFinder new
]

{ #category : #'api - database' }
GtHomeLepiterBasicCard >> tableOfContentsNodes [
	^ self database tableOfContentsNodes
]
