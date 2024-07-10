Class {
	#name : #GtHomeLepiterBaseCard,
	#superclass : #GtHomeLepiterBasicCard,
	#instVars : [
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

{ #category : #'private - widgets' }
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

{ #category : #'private - widgets' }
GtHomeLepiterBaseCard >> createDatabaseDescriptionElement [
	^ GtHomeLepiterKnowledgeBaseDescriptionElement new
		databaseViewModel: self database asContentUIModel;
		details: self details
]

{ #category : #'private - widgets' }
GtHomeLepiterBaseCard >> createTabGroup [
	^ GtHomeLepiterKnowledgeBaseTabGroupElement new
		margin: (BlInsets all: 10);
		databaseViewModel: self database asContentUIModel
]

{ #category : #'private - widgets' }
GtHomeLepiterBaseCard >> createTitleElement [
	^ BrEditor new
		hMatchParent
		vFitContent;
		padding: (BlInsets all: 10);
		aptitude: (BrGlamorousRegularEditorAptitude new bold; fontSize: 18);
		text: self title
]

{ #category : #'private - widgets' }
GtHomeLepiterBaseCard >> createToolbarElement [
	^ self toolbarStencil
		card: self;
		asElement
]

{ #category : #'api - database' }
GtHomeLepiterBaseCard >> databaseSnippets [
	^ self database pages flatCollect: #allChildrenDepthFirst
]

{ #category : #initialization }
GtHomeLepiterBaseCard >> defaultAction [
	^ [  ]
]

{ #category : #initialization }
GtHomeLepiterBaseCard >> defaultDescription [
	^ self page ifNil: [ super defaultDescription ] ifNotNil: [ :aPage | aPage title ]
]

{ #category : #initialization }
GtHomeLepiterBaseCard >> defaultTitle [
	^ self pageName ifNil: [ 'A Home Page Card' ] ifNotNil: [ :aString | aString ]
]

{ #category : #'api - details' }
GtHomeLepiterBaseCard >> details [
	^ details
]

{ #category : #'api - details' }
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
