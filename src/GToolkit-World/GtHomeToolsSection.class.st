Class {
	#name : #GtHomeToolsSection,
	#superclass : #GtHomeSection,
	#instVars : [
		'knowledgeBaseComputation'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #'gt - extensions' }
GtHomeToolsSection class >> gtAllButtonStencilsFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'Tool buttons';
		object: [ self new ];
		view: #gtAllButtonStencilsFor:
]

{ #category : #'private - accessing' }
GtHomeToolsSection >> allButtonStencils [
	"Answer the stencils to be displayed in the GT home tab.
	Buttons are defined by methods with the #gtToolButton pragma and sorted by priority."

	^ ((GtPhlowCollector new
		fromObject: self;
		pragmaName: #gtToolButton;
		collectAllPragmas)
			collect: [ :aPragma | [ (self perform: aPragma methodSelector) definingMethod: aPragma method ]
				on: Error
				do: [ :ex | self handleButtonCreationException: ex ] ])
					sorted: #priority ascending
]

{ #category : #'private - accessing' }
GtHomeToolsSection >> allButtons [
	"Answer the buttons to be displayed in the GT home tab.
	Buttons are defined by methods with the #gtToolButton pragma and sorted by priority."

	^ self allButtonStencils collect: [ :stencil |
		[ stencil create ]
			on: Error
			do: [ :ex | (self handleButtonCreationException: ex) create ] ]
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		background: Color white; 
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		aptitude: (BrShadowAptitude new beLarge);
		padding: (BlInsets top: 10 left: 0 bottom: 10 right: 0).
	cardsContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets all: 0).
	cardsContainer addChildren: self allButtons.
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #'gt - extensions' }
GtHomeToolsSection >> gtAllButtonStencilsFor: aView [
	<gtView>
	^ aView forward
		title: 'Tool buttons';
		object: [ #gtToolButton gtPragmas ];
		view: #gtItemsFor:
]

{ #category : #'private ' }
GtHomeToolsSection >> handleButtonCreationException: anException [
	"Answer a button stencil that opens an inspector on the supplied exception"
	| frozenException |

	frozenException := anException freeze.
	^ GtToolButtonStencil new
		title: 'Error';
		priority: 5;
		icon: BrGlamorousVectorIcons debug;
		action: [ :card | 
			self
				showSpaceWithIcon: (BrGlamorousVectorIcons debug asElement asPannableElement size: 16@16)
				title: 'Error during button creation'
				with: (GtInspector
					createOn: frozenException) maximized
				from: card ];
		description:
			'An error occured while creating the button'
]

{ #category : #accessing }
GtHomeToolsSection >> knowledgeBase [
	^ knowledgeBaseComputation ifNotNil: [ :aValuable | aValuable value ]
]

{ #category : #accessing }
GtHomeToolsSection >> knowledgeBaseComputation: aValuable [
	knowledgeBaseComputation := aValuable
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newAddSnippetStencil [
	<gtToolButton>

	^ GtToolSpotterButtonStencil new 
		title: 'Page';
		priority: 9;
		icon: (GtPlaygroundStencil playgroundClass defaultIcon);
		valuable: (LeContextMenuSpotterStart new
			database: self knowledgeBase);
		extent: [ 300 @ 400 ];
		spotterModelDo: [ :aSpotter | aSpotter hidePreview ];
		objectActOn: [ :anActOnEvent :aMenuItem :theButton | 
			self
				pageWithSnippetRequested: aMenuItem asSnippet
				button: theButton.
			anActOnEvent beActed ];
		espaceActOn: [ :anAnchorElement | anAnchorElement requestFocus ];
		description: 'Play with code. Live.'
]

{ #category : #accessing }
GtHomeToolsSection >> newCodeChangesButtonStencil [
	<gtToolButton>

	^ GtToolButtonStencil new
		title: 'Code changes';
		priority: 35;

		icon: BrGlamorousVectorIcons largeChanges;
		action: [ :card | 
			self
				showSpaceWithIcon: (BrGlamorousVectorIcons changes asElement asPannableElement size: 16@16)
				title: 'Code changes'
				with: GtEpiceaStencil new
				from: card ];
		description:
			'Browse the local code changes from the current and previous sessions.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newCoderButtonStencil [
	<gtToolButton>

	^ GtToolButtonStencil new 
		title: 'Coder';
		priority: 25;
		icon: BrGlamorousVectorIcons largeBook;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedBrowse
				title: 'Coder'
				with: GtCoderStencil new
				from: card ];
		description: 'Browse and manipulate code.';
		elementId: GtHomeCoderButtonId.
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newGitButtonStencil [
	<gtToolButton>

	^ GtToolButtonStencil new 
		title: 'Git';
		priority: 30;
		icon: BrGlamorousVectorIcons largebranching;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedInspect
				title: 'Git'
				with: GtGitStencil new
				from: card ];
		description: 'Manage git repositories.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newLepiterButtonStencil [
	<gtToolButton>

	^ GtToolButtonStencil new 
		title: 'Knowledge bases';
		priority: 20;
		icon: LeIcons lepiterDatabase;
		action: [ :card | 
			self
				showSpaceWithIcon: LeIcons lepiterDatabase
				title: 'Knowledge bases'
				with: (LeLepiterToolStencil new
					knowledgeBase: self knowledgeBase)
				from: card ];
		description: 'Knowledge bases'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newMonitorButtonStencil [
	<gtToolButton>

	^ GtToolButtonStencil new 
		title: 'Monitor';
		priority: 40;
		icon: BrGlamorousVectorIcons largeSignal;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedInspect
				title: 'Monitor'
				with: (GtInspector createOn: GtMonitor new) maximized
				from: card ];
		description: 'Monitor processes and high level tasks.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newNotesButtonStencil [
	"<gtToolButton>"

	^ GtToolButtonStencil new 
		title: 'Note';
		priority: 15;
		icon: LeIcons lepiterPage;
		action: [ :card | 
			self
				showSpaceWithIcon: LeIcons lepiterPage
				title: 'Note'
				with: (LeNotePlaygroundStencil new
					knowledgeBase: self knowledgeBase)
				from: card ];
		description: 'Take notes. Live.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newPlaygroundButtonStencil [
	"<gtToolButton>"

	^ GtToolButtonStencil new 
		title: 'Playground';
		priority: 10;
		icon: (GtPlaygroundStencil playgroundClass defaultIcon);
		action: [ :card | 
			self
				showSpaceWithIcon: GtPlaygroundStencil playgroundClass defaultIcon
				title: 'Playground'
				with: (GtPlaygroundStencil new
					knowledgeBase: self knowledgeBase)
				from: card ];
		description: 'Play with code. Live.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newTranscriptButtonStencil [
	<gtToolButton>

	^ GtToolButtonStencil new 
		title: 'Transcript';
		priority: 50;
		icon: BrGlamorousVectorIcons largeTranscript;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedInspect
				title: 'Transcript'
				with: GtTranscriptStencil new
				from: card ];
		description: 'Transcript is the place to see logs.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> pageWithSnippetRequested: aSnippet button: aButton [
	| aPage |
	self knowledgeBase ifNil: [ ^ self ].
	aPage := LePage unnamedPage.
	aPage addSnippet: aSnippet.
	self knowledgeBase addPage: aPage.
	
	BlTaskAction enqueueElement: aButton action: [
		self spawnPage: aPage from: aButton.
		aButton parent ifNotNil: [ :aParent | 
			aParent fireEvent: BrDropdownHideWish new ] ]
]

{ #category : #'event handling' }
GtHomeToolsSection >> spawnPage: aPage from: aButton [
	"If we are in a pager, spawn the page in the current phlow, else create a new pager."

	^ BlSpace spawnPage: aPage from: aButton
]
