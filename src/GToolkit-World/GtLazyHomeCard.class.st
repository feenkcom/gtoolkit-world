"
I am a kind of GtHomeCard for a page in a database that might not yet be loaded.
"
Class {
	#name : #GtLazyHomeCard,
	#superclass : #GtHomeCard,
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
	^ [ :aButton :aModel :anEvent | 
	self page
		ifNotNil: [ GtWorldUtility
				showSpaceWithTitle: self page title
				inPagerWith: [ self page asLepiterPagePhlowTool asElementDo: [ :e | e ] ]
						asStencil
				from: aButton ] ]
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
