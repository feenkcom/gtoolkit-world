Class {
	#name : #GtHomeLepiterBaseCard,
	#superclass : #GtHomeLepiterBasicCard,
	#instVars : [
		'databaseName',
		'details',
		'toolbarStencil'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #'view creation' }
GtHomeLepiterBaseCard >> create [
	| container detailsPane contents |
	detailsPane := BrVerticalPane new matchParent.
	detailsPane
		addChild: self createTitleElement;
		addChild: self createDatabaseDescriptionElement;
		addChild: self createToolbarElement.

	contents := BrHorizontalPane new matchParent.
	contents addChild: detailsPane.
	contents addChild: self createTabGroup.

	container := self createContainer.
	container addChild: contents.

	^ container
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createContainer [
	^ BrButton new
		layout: (BlLinearLayout horizontal );
		exact: 500 @ 250;
		background: Color white;
		aptitude: BrShadowAptitude new beLarge + BrGlamorousButtonWithLabelTooltipAptitude new;
		label: self description;
		padding: (BlInsets top: 10 left: 10 bottom: 10 right: 0 );
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
		margin: (BlInsets all: 3);
		headerElementStencil: [ BrLabel new
				beSmallSize;
				aptitude: (BrGlamorousLabelAptitude new);
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
		padding: (BlInsets all: 10);
		aptitude: (BrGlamorousRegularEditorAptitude new foreground: Color black);
		text: self databaseDescriptionText
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createTabGroup [
	^ BrTabGroup new
		aptitude: BrGlamorousTabGroupAptitude new;
		margin: (BlInsets all: 10);
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
		margin: (BlInsets top: 5 left: 3);
		nodeStencil: [ BrLabel new
				beSmallSize;
				aptitude: (BrGlamorousLabelAptitude new) ];
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
		label: 'Table of contents';
		stencil: [ self createTableOfContentsElement ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createTitleElement [
	^ BrEditor new
		hMatchParent
		vFitContent;
		padding: (BlInsets all: 10);
		aptitude: (BrGlamorousRegularEditorAptitude new bold; fontSize: 18);
		text: self title
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> createToolbarElement [
	^ self toolbarStencil
		card: self;
		asElement
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
	^ self page ifNil: [ super defaultDescription ] ifNotNil: [ :aPage | aPage title ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> defaultTitle [
	^ self pageName ifNil: [ 'A Home Page Card' ] ifNotNil: [ :aString | aString ]
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> details [
	^ details
]

{ #category : #accessing }
GtHomeLepiterBaseCard >> details: anObject [
	details := anObject
]

{ #category : #'api - toolbar' }
GtHomeLepiterBaseCard >> editableToolbar [
	"For knowledge bases that are supposed to be edited by users, e.g., personal notes."

	self toolbarStencil: GtHomeLepiterEditToolbarStencilBuilder new
]

{ #category : #initialization }
GtHomeLepiterBaseCard >> initialize [
	super initialize.
	self readMoreToolbar
]

{ #category : #'api - toolbar' }
GtHomeLepiterBaseCard >> readMoreToolbar [
	"For knowledge bases that served as read-only books.
	In other words, for knowledge bases that are NOT used to personal notes."

	self toolbarStencil: GtHomeLepiterReadMoreToolbarStencilBuilder new
]

{ #category : #'api - toolbar' }
GtHomeLepiterBaseCard >> toolbarStencil [
	^ toolbarStencil
]

{ #category : #'api - toolbar' }
GtHomeLepiterBaseCard >> toolbarStencil: aStencilBuilder [
	toolbarStencil := aStencilBuilder asStencilBuilder: GtHomeLepiterReadMoreToolbarStencilBuilder
]
