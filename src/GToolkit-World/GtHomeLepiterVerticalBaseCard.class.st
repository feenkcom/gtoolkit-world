Class {
	#name : #GtHomeLepiterVerticalBaseCard,
	#superclass : #GtHomeLepiterBasicCard,
	#instVars : [
		'details',
		'toolbarStencil'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #'view creation' }
GtHomeLepiterVerticalBaseCard >> create [
	| container detailsPane contents |
	detailsPane := BrVerticalPane new
			hMatchParent;
			vFitContent.
	detailsPane
		addChild: self createTitleElement;
		addChild: self createDatabaseDescriptionElement.

	contents := BrVerticalPane new matchParent.
	contents addChild: detailsPane.
	contents
		addChild: self createTabGroup;
		addChild: self createToolbarElement.
	container := self createContainer.
	container addChild: contents.
	container
		addAptitude: (BrGlamorousWithHorizontalResizerAptitude new
				beRight;
				resizerDo: [ :aResizer | 
					container
						addAptitude: (BrLazyStyleCommonAptitude new
								default: [ :aStyle | aStyle do: [ :aWidget | aResizer visibility: BlVisibility hidden ] ];
								hovered: [ :aStyle | 
									aStyle
										do: [ :aWidget | aResizer visibility: BlVisibility visible ]
										after: [ :aWidget | aResizer visibility: BlVisibility hidden ] ]) ]).
	container
		addAptitude: (BrGlamorousWithVerticalResizerAptitude new
				beBottom;
				resizerDo: [ :aResizer | 
					container
						addAptitude: (BrLazyStyleCommonAptitude new
								default: [ :aStyle | aStyle do: [ :aWidget | aResizer visibility: BlVisibility hidden ] ];
								hovered: [ :aStyle | 
									aStyle
										do: [ :aWidget | aResizer visibility: BlVisibility visible ]
										after: [ :aWidget | aResizer visibility: BlVisibility hidden ] ]) ]).
	^ container
]

{ #category : #'private - widgets' }
GtHomeLepiterVerticalBaseCard >> createContainer [
	^ BrButton new
		layout: BlLinearLayout horizontal;
		exact: 500 @ 400;
		background: BlTheme default default contentBackground;
		aptitude: BrShadowAptitude new beLarge + BrGlamorousButtonWithLabelTooltipAptitude2 new;
		label: self description;
		padding: (BlInsets
				top: 10
				left: 10
				bottom: 10
				right: 0);
		margin: (BlInsets
				top: self spaceGap
				left: 2 * self spaceGap
				bottom: 2 * self spaceGap
				right: 2 * self spaceGap);
		action: self action;
		addAptitude: (GtPhlowBrowseDefinitionAptitude new definition: [ self definingMethod ])
]

{ #category : #'private - widgets' }
GtHomeLepiterVerticalBaseCard >> createDatabaseDescriptionElement [
	^ GtHomeLepiterKnowledgeBaseDescriptionElement new
		databaseViewModel: self database asContentUIModel;
		details: self details;
		hMatchParent;
		vFitContent
]

{ #category : #'private - widgets' }
GtHomeLepiterVerticalBaseCard >> createTabGroup [
	^ GtHomeLepiterKnowledgeBaseTabGroupElement new
		margin: (BlInsets all: 10);
		databaseViewModel: self database asContentUIModel
]

{ #category : #'private - widgets' }
GtHomeLepiterVerticalBaseCard >> createTitleElement [
	^ BrEditor new
		hMatchParent
		vFitContent;
		padding: (BlInsets top: 10 left: 10 bottom: 0 right: 10);
		aptitude: (BrGlamorousRegularEditorAptitude new bold; fontSize: 18);
		text: self title
]

{ #category : #'private - widgets' }
GtHomeLepiterVerticalBaseCard >> createToolbarElement [
	^ self toolbarStencil
		card: self;
		asElement
]

{ #category : #'api - database' }
GtHomeLepiterVerticalBaseCard >> databaseSnippets [
	^ self database pages flatCollect: #allChildrenDepthFirst
]

{ #category : #initialization }
GtHomeLepiterVerticalBaseCard >> defaultAction [
	^ [  ]
]

{ #category : #initialization }
GtHomeLepiterVerticalBaseCard >> defaultDescription [
	^ self page ifNil: [ super defaultDescription ] ifNotNil: [ :aPage | aPage title ]
]

{ #category : #initialization }
GtHomeLepiterVerticalBaseCard >> defaultTitle [
	^ self pageName ifNil: [ 'A Home Page Card' ] ifNotNil: [ :aString | aString ]
]

{ #category : #'api - details' }
GtHomeLepiterVerticalBaseCard >> details [
	^ details
]

{ #category : #'api - details' }
GtHomeLepiterVerticalBaseCard >> details: anObject [
	details := anObject
]

{ #category : #'api - toolbar' }
GtHomeLepiterVerticalBaseCard >> editableToolbar [
	"For knowledge bases that are supposed to be edited by users, e.g., personal notes."

	self toolbarStencil: GtHomeLepiterEditToolbarStencilBuilder new
]

{ #category : #initialization }
GtHomeLepiterVerticalBaseCard >> initialize [
	super initialize.
	self readMoreToolbar
]

{ #category : #'api - toolbar' }
GtHomeLepiterVerticalBaseCard >> readMoreToolbar [
	"For knowledge bases that served as read-only books.
	In other words, for knowledge bases that are NOT used to personal notes."

	self toolbarStencil: GtHomeLepiterReadMoreToolbarStencilBuilder new
]

{ #category : #'api - toolbar' }
GtHomeLepiterVerticalBaseCard >> toolbarStencil [
	^ toolbarStencil
]

{ #category : #'api - toolbar' }
GtHomeLepiterVerticalBaseCard >> toolbarStencil: aStencilBuilder [
	toolbarStencil := aStencilBuilder asStencilBuilder: GtHomeLepiterReadMoreToolbarStencilBuilder
]
