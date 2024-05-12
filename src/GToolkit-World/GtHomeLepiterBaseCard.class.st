Class {
	#name : #GtHomeLepiterBaseCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'databaseName',
		'pageName',
		'page'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeLepiterBaseCard >> assertInvariant [
	self assert: pageName isNotNil description: 'pageName must not be nil.'.
	self assert: databaseName isNotNil description: 'databaseName must not be nil.'.
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> create [
	| container tree |
	container := BrButton new
			layout: (BlLinearLayout vertical cellSpacing: 5);
			exact: 300 @ 300;
			background: Color white;
			aptitude: BrShadowAptitude new beLarge + BrGlamorousButtonWithLabelTooltipAptitude new;
			label: self description;
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

	container
		addChild: (BrLabel new
				beLargeSize;
				padding: (BlInsets left: 5 right: 5);
				aptitude: BrGlamorousLabelAptitude new bold;
				text: self database databaseName).
	container
		addChild: (BrLabel new
				beSmallSize;
				padding: (BlInsets left: 5 right: 5);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
				text: self database pages size asString , ' lovely pages').
	tree := BrSimpleTree new.
	tree
		"when: BrSelectionDoubleClicked
			do: [ :e | 
				e selection
					ifNotEmpty: [ :theIndices | 
						| selectedObject |
						selectedObject := e currentTarget viewModel itemAt: theIndices first.
						self spawnPage: selectedObject value page from: e currentTarget ] ];"
		padding: (BlInsets left: 5 right: 5);
		nodeStencil: [ BrLabel new
				beSmallSize;
				aptitude: BrGlamorousLabelAptitude new ];
		nodeDataBinder: [ :aLabel :aNode | aLabel text: aNode page title ];
		items: self database tableOfContentsNodes lazy: #children;
		expandUpTo: 1";
		rowStencil: BrGlamorousSimpleTreeSelectableRowElementStencilBuilder new".
	container addChild: tree.	"container
	addChild: (BrToolbar new
			aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
			fitContent;
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					beSmallSize;
					icon: BrGlamorousVectorIcons add;
					label: 'Add page';
					action: [ self halt ]))."
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
