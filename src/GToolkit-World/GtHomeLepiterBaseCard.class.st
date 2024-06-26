Class {
	#name : #GtHomeLepiterBaseCard,
	#superclass : #GtHomeLepiterBasicCard,
	#instVars : [
		'databaseName',
		'pageName',
		'page',
		'details'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #asserting }
GtHomeLepiterBaseCard >> assertInvariant [
	self assert: pageName isNotNil description: 'pageName must not be nil.'.
	self assert: databaseName isNotNil description: 'databaseName must not be nil.'.
	self assert: details isNotNil description: 'details must not be nil.'.
]

{ #category : #'view creation' }
GtHomeLepiterBaseCard >> create [
	| container detailsPane contents |
	detailsPane := BrVerticalPane new matchParent.
	detailsPane addChild: self createDatabaseDescriptionElement.

	contents := BrHorizontalPane new matchParent.
	contents addChild: detailsPane.
	contents addChild: self createTabGroup.
	
	container := self createContainer.
	container addChild: self createTitleElement.
	container addChild: contents.
	container addChild: (self createToolbarElement).
	
	^ container
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createContainer [
	^ BrButton new
		layout: (BlLinearLayout vertical cellSpacing: 5);
		exact: 500 @ 250;
		background: Color white;
		aptitude: BrShadowAptitude new beLarge + BrGlamorousButtonWithLabelTooltipAptitude new;
		label: self description;
		padding: (BlInsets all: 10);
		margin: (BlInsets
				top: self spaceGap
				left: 2 * self spaceGap
				bottom: 2 * self spaceGap
				right: 2 * self spaceGap);
		action: self action;
		addAptitude: (BrGlamorousButtonExteriorAptitude new
				backgroundPaint: Color white;
				borderPaint: Color transparent);
		addAptitude: (GtPhlowBrowseDefinitionAptitude new definition: [ self definingMethod ])
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createDailyNotesElement [
	^ BrGroupedList new
		padding: (BlInsets left: 3 right: 5);
		headerElementStencil: [ BrLabel new
				beSmallSize;
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 3) ];
		headerDataBinder: [ :aLabelElement :aGroup | aLabelElement text: aGroup domainObject asString ];
		when: BrSelectionDoubleClicked
			do: [ :e | 
				e selection
					ifNotEmpty: [ :theIndices | 
						| selectedObject |
						selectedObject := e currentTarget viewModel entityAt: theIndices first.
						self spawnPage: selectedObject itemObject from: e currentTarget ] ];
		stream: self dailyNotesGroup;
		matchParent
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createDailyNotesTabElement [
	^ BrTab new
		aptitude: GtHomeLepiterCardTabAptitude new;
		label: 'Pages';
		stencil: [ self createDailyNotesElement ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createDatabaseDescriptionElement [
	^ BrEditor new
		preventMeAndChildrenMouseEvents;
		padding: (BlInsets left: 6 right: 5);
		aptitude: (BrGlamorousRegularEditorAptitude new foreground: Color black);
		text: self databaseDescriptionText
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createTabGroup [
	^ BrTabGroup new
		aptitude: BrGlamorousTabGroupAptitude new;
		in: [ :theGroup | 
			self hasTableOfContents
				ifTrue: [ theGroup addTab: self createTableOfContentsTabElement ] ];
		addTab: self createDailyNotesTabElement
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createTableOfContentsElement [
	| tree |
	tree := BrSimpleTree new.
	tree
		padding: (BlInsets left: 3 right: 5);
		nodeStencil: [ BrLabel new
				beSmallSize;
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ];
		nodeDataBinder: [ :aLabel :aNode | aLabel text: aNode page title ];
		items: self tableOfContentsNodes lazy: #children;
		expandUpTo: 1;
		when: BrSelectionDoubleClicked
			do: [ :e | 
				e selection
					ifNotEmpty: [ :theIndices | 
						| selectedObject |
						selectedObject := e currentTarget viewModel itemAt: theIndices first.
						self spawnPage: selectedObject value page from: e currentTarget ] ].
						
		"rowStencil: BrGlamorousSimpleTreeSelectableRowElementStencilBuilder new"
		
	^ tree
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createTableOfContentsTabElement [
	^ BrTab new
		aptitude: GtHomeLepiterCardTabAptitude new;
		label: 'ToC';
		stencil: [ self createTableOfContentsElement ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createTitleElement [
	^ BrLabel new
		beLargeSize;
		padding: (BlInsets top: 10 left: 5 bottom: 10 right: 20);
		aptitude: BrGlamorousLabelAptitude new bold;
		text: self title
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createToolbarElement [
	^ BrToolbar new
		aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
		fitContent;
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
				icon: LeIcons lepiterIcon;
				label: 'Read more';
				action: self action)
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> databaseDescriptionText [
	^ details value: self database
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> databaseSnippets [
	^ self database pages flatCollect: #allChildrenDepthFirst
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> defaultAction [
	^ [ :aButton :aModel :anEvent | self page ifNotNil: [ self spawnPage: self page from: aButton ] ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> defaultDescription [
	^ page ifNil: [ super defaultDescription ] ifNotNil: [ page title ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> defaultTitle [
	^ self pageName ifNil: [ 'A Home Page Card' ] ifNotNil: [ self pageName ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> details [
	^ details
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> details: anObject [
	details := anObject
]
