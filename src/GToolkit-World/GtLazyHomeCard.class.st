"
I am a kind of GtHomeCard for a page in a database that might not yet be loaded.
For an example, see {{gtMethod:name=GtLazyHomeCardExamples>>#lazyGtDemosCard}}. 
"
Class {
	#name : #GtLazyHomeCard,
	#superclass : #GtHomePageCard,
	#instVars : [
		'databaseName',
		'pageName',
		'loadLepiter'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtLazyHomeCard >> database [
	(self registry hasDatabaseNamed: self databaseName)
		ifFalse: [ self loadLepiter value ].
	^ self registry databaseNamed: self databaseName
]

{ #category : #accessing }
GtLazyHomeCard >> databaseName [
	^ databaseName
]

{ #category : #accessing }
GtLazyHomeCard >> databaseName: aLeDatabaseName [
	databaseName := aLeDatabaseName
]

{ #category : #accessing }
GtLazyHomeCard >> defaultAction [
	"If the page is missing, load the database."

	^ [ :aButton :aModel :anEvent | 
	self page
		ifNil: [ [ UIManager default
				informUser: 'Loading ' , self databaseName
				during: [ page := self database pageNamed: self pageName.

					self spawnPage: self page from: aButton ] ] fork ]
		ifNotNil: [ self spawnPage: self page from: aButton ] ]
]

{ #category : #accessing }
GtLazyHomeCard >> defaultTitle [
	^ 'A Lazy Home Page Card'
]

{ #category : #accessing }
GtLazyHomeCard >> loadLepiter [
	^ loadLepiter
]

{ #category : #accessing }
GtLazyHomeCard >> loadLepiter: aBlock [
	loadLepiter := aBlock
]

{ #category : #accessing }
GtLazyHomeCard >> pageName [
	^ pageName
]

{ #category : #accessing }
GtLazyHomeCard >> pageName: aLePageName [
	pageName := aLePageName
]

{ #category : #accessing }
GtLazyHomeCard >> registry [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
]
