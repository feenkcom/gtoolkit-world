Class {
	#name : #GtHomePageCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'databaseName',
		'pageName',
		'page'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomePageCard >> assertInvariant [
	self assert: pageName isNotNil description: 'pageName must not be nil.'.
	self assert: databaseName isNotNil description: 'databaseName must not be nil.'.
]

{ #category : #accessing }
GtHomePageCard >> database [
	^ self registry databaseNamed: self databaseName
]

{ #category : #accessing }
GtHomePageCard >> databaseName [
	^ databaseName
]

{ #category : #accessing }
GtHomePageCard >> databaseName: aLeDatabaseName [
	databaseName := aLeDatabaseName
]

{ #category : #accessing }
GtHomePageCard >> defaultAction [
	^ [ :aButton :aModel :anEvent | self page ifNotNil: [ self spawnPage: self page from: aButton ] ]
]

{ #category : #accessing }
GtHomePageCard >> defaultDescription [
	^ page ifNil: [ super defaultDescription ] ifNotNil: [ page title ]
]

{ #category : #accessing }
GtHomePageCard >> defaultTitle [
	^ self pageName ifNil: [ 'A Home Page Card' ] ifNotNil: [ self pageName ]
]

{ #category : #accessing }
GtHomePageCard >> page [
	^ page ifNil: [ page := self database pageNamed: self pageName ]
]

{ #category : #accessing }
GtHomePageCard >> page: aLePage [
	page := aLePage
]

{ #category : #accessing }
GtHomePageCard >> pageName [
	^ pageName
]

{ #category : #accessing }
GtHomePageCard >> pageName: aLePageName [
	pageName := aLePageName
]

{ #category : #accessing }
GtHomePageCard >> registry [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
]
