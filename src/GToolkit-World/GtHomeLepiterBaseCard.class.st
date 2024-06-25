Class {
	#name : #GtHomeLepiterBaseCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'databaseName',
		'pageName',
		'page',
		'details'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeLepiterBaseCard >> assertInvariant [
	self assert: pageName isNotNil description: 'pageName must not be nil.'.
	self assert: databaseName isNotNil description: 'databaseName must not be nil.'.
	self assert: details isNotNil description: 'details must not be nil.'.
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> create [
	| container tree detailsPane contents |
	container := BrButton new
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
			action: self action.
	container
		addAptitude: (BrGlamorousButtonExteriorAptitude new
				backgroundPaint: Color white;
				borderPaint: Color transparent)
				+ (GtPhlowBrowseDefinitionAptitude new definition: [ self definingMethod ]).

	contents := BrHorizontalPane new matchParent.

	detailsPane := BrVerticalPane new matchParent.
	container
		addChild: (BrLabel new
				beLargeSize;
				padding: (BlInsets top: 10 left: 5 bottom: 10 right: 20);
				aptitude: BrGlamorousLabelAptitude new bold;
				text: self title).
	detailsPane
		addChild: (BrEditor new
				preventMeAndChildrenMouseEvents;
				padding: (BlInsets left: 6 right: 5);
				aptitude: (BrGlamorousRegularEditorAptitude new foreground: Color black);
				text: (details value: self database)).
	contents addChild: detailsPane.
	container addChild: contents.
	tree := BrSimpleTree new.
	tree
		padding: (BlInsets left: 5 right: 5);
		nodeStencil: [ BrLabel new
				beSmallSize;
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ];
		nodeDataBinder: [ :aLabel :aNode | aLabel text: aNode page title ];
		items: self database tableOfContentsNodes lazy: #children;
		expandUpTo: 1; 
		when: BrSelectionDoubleClicked
			do: [ :e | 
				e selection
					ifNotEmpty: [ :theIndices | 
						| selectedObject |
						selectedObject := e currentTarget viewModel itemAt: theIndices first.
						self spawnPage: selectedObject value page from: e currentTarget ] ].
		"rowStencil: BrGlamorousSimpleTreeSelectableRowElementStencilBuilder new"
	contents addChild: tree.	
	container addChild: (BrToolbar new
			aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
			fitContent;
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
					icon: LeIcons lepiterIcon;
					label: 'Read more';
					action: self action)).
	^ container
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> database [
	^ self registry databaseNamed: self databaseName
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> databaseName [
	^ databaseName
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> databaseName: aLeDatabaseName [
	databaseName := aLeDatabaseName
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

{ #category : #accessing }
GtHomeLepiterBaseCard >> page [
	^ page ifNil: [ page := self database pageNamed: self pageName ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> page: aLePage [
	page := aLePage
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> pageName [
	^ pageName
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> pageName: aLePageName [
	pageName := aLePageName
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> registry [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
]
