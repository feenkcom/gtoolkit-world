"
I demo how to have a home card that lazily loads a lepiter database.
"
Class {
	#name : #GtLazyHomeCardExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #accessing }
GtLazyHomeCardExamples >> gtDemosDbName [
	^ 'feenkcom/gtoolkit-demos/lepiter'
]

{ #category : #accessing }
GtLazyHomeCardExamples >> lazyGtDemosCard [
	"The database will be loaded the first time the button is clicked."

	<gtExample>
	<noTest>
	^ GtLazyHomeCard new
		title: 'GT Demos';
		description: 'GT Demos';
		databaseName: self gtDemosDbName;
		pageName: 'GToolkitDemos TOC';
		loadLepiter: [ BaselineOfGToolkitDemos loadLepiter ];
		priority: 20
]

{ #category : #accessing }
GtLazyHomeCardExamples >> lazyGtDemosCardUnloadedFirst [
	"Unload the database first, if necessary, to demo the loading."

	<gtExample>
	<noTest>
	self unloadGtDemosDatabase.
	self assert: (self registry hasDatabaseNamed: self gtDemosDbName) not.
	^ self lazyGtDemosCard
]

{ #category : #accessing }
GtLazyHomeCardExamples >> registry [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
]

{ #category : #accessing }
GtLazyHomeCardExamples >> unloadGtDemosDatabase [
	<gtExample>
	<noTest>
	| db registry dbName |
	registry := self registry.
	dbName := self gtDemosDbName.
	(registry hasDatabaseNamed: dbName)
		ifTrue: [ db := registry databaseNamed: dbName.
			registry removeDB: db ].
	self assert: (registry hasDatabaseNamed: dbName) not.
	^ registry
]
