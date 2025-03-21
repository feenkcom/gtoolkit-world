Class {
	#name : #GtHomeCardExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #example }
GtHomeCardExamples >> errorCard [
	<gtExample>
	^ GtHomeCard errorCard
		targetError: 
			(Error new messageText: 'An error occurred!')
]

{ #category : #example }
GtHomeCardExamples >> gtBookCard [
	<gtExample>
	^ GtHomeCard page
		title: 'Glamorous Toolkit Book';
		description: 'Read the Glamorous Toolkit book';
		priority: 10;
		pageName: 'Glamorous Toolkit';
		databaseName: LeDatabase gtBookName;
		yourself
]

{ #category : #accessing }
GtHomeCardExamples >> gtDemosDbName [
	^ 'feenkcom/gtoolkit-demos/lepiter'
]

{ #category : #example }
GtHomeCardExamples >> gtTourCard [
	<gtExample>
	^ GtHomeCard job
		title: 'GtTour';
		description: 'Open the GtTour slideshow';
		priority: 20;
		block: [ GtPresenterSlideShow openInSpace: GtTour ];
		yourself
]

{ #category : #example }
GtHomeCardExamples >> jobCard [
	"If you click multiple times on the button, this will trigger a warning that a job is still running."

	<gtExample>
	^ GtHomeCard job
		title: 'Test job card';
		description: 'Demo running a job from a card';
		priority: 20;
		block: [ 3 seconds asDelay wait ];
		yourself
]

{ #category : #example }
GtHomeCardExamples >> lazyGtDemosCard [
	"The database will be loaded the first time the button is clicked."

	<gtExample>
	<noTest>
	^ GtHomeCard lazy
		title: 'GT Demos';
		description: 'GT Demos';
		databaseName: self gtDemosDbName;
		pageName: 'GToolkitDemos TOC';
		loadLepiter: [ BaselineOfGToolkitDemos loadLepiter ];
		priority: 20
]

{ #category : #example }
GtHomeCardExamples >> lazyGtDemosCardUnloadedFirst [
	"Unload the database first, if necessary, to demo the loading."

	<gtExample>
	<noTest>
	self unloadGtDemosDatabase.
	self assert: (self registry hasDatabaseNamed: self gtDemosDbName) not.
	^ self lazyGtDemosCard
]

{ #category : #example }
GtHomeCardExamples >> primaryDbTocCard [
	"A card for the TOC of the user's default database, with default title and tooltip description.
	NB: this will fail for a new installation with an empty primary Lepiter database."

	<gtExample>
	<noTest>
	| toc |
	toc := LeDatabase primaryDB tableOfContents.
	self
		assert: toc notNil
		description: 'This example supposes the primary db has a TOC'.
	^ GtHomeCard page
		pageName: toc title;
		databaseName: toc database databaseName;
		yourself
]

{ #category : #accessing }
GtHomeCardExamples >> registry [
	<gtExample>
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
]

{ #category : #example }
GtHomeCardExamples >> slideshowCard [
	"Demo of a slideshow that requires a repo to be loaded."
	<gtExample>
	<noTest>
	^ GtHomeCard slideshow
		title: 'VISSOFT (2022)';
		description: 'VISSOFT Talk (2022)';
		"setPriority;"
		slideshowClassSymbol: #MakingSystemsExplainableSlideshow
			baseLineName: 'PaperExplainableSystemsVissoft2022'
			repo: 'github://feenkcom/paper-explainable-systems-vissoft2022:master/src'
			loadLepiterBaseline: #BaselineOfPaperExplainableSystemsVissoft2022;
		yourself
]

{ #category : #utility }
GtHomeCardExamples >> unloadGtDemosDatabase [
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
