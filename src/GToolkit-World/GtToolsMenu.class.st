Class {
	#name : #GtToolsMenu,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'knowledgeBase',
		'dropDownAptitude'
	],
	#classInstVars : [
		'world'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #'system startup' }
GtToolsMenu class >> cleanUp [
	<script: 'self cleanUp'>

	world ifNotNil: [
		world isOpened
			ifTrue: [ world close ].
		world := nil ]
]

{ #category : #'instance creation' }
GtToolsMenu class >> create [
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace title: 'Glamorous Toolkit'.
	aSpace addChild: self new.
	aSpace extent: 260@500.
	^ aSpace
]

{ #category : #'instance creation' }
GtToolsMenu class >> open [
	<script: 'self open'>

	(world isNotNil and: [ world isOpened ])
		ifTrue: [ world close ].

	world := self create.

	world isOpened
		ifFalse: [ world show ]
]

{ #category : #initialization }
GtToolsMenu >> addBottomButtons [
	| buttonList |
	buttonList :=
			{(BrButton new)
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Save';
				hMatchParent;
				action: [:aButton | self saveFrom: aButton].
			self renameButton.
			(BrButton new)
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Quit';
				hMatchParent;
				action: [:aButton | self quitFrom: aButton]}.
	self addChild: ((BlElement new)
				layout: (BlLinearLayout horizontal cellSpacing: 10);
				margin: (BlInsets
							top: 25
							left: 0
							bottom: 5
							right: 0);
				constraintsDo: 
						[:c |
						c horizontal matchParent.
						c vertical fitContent];
				addChildren: (buttonList reject: [:e | e isNil]))
]

{ #category : #initialization }
GtToolsMenu >> addSections [
	self
		addChild: ((GtHomeToolsSection new
				knowledgeBaseComputation: [self knowledgeBase]) newPlaygroundButtonStencil
				smallIcon smallMargin
				create size: self iconSize).
	self
		addChild: ((GtHomeToolsSection new
				knowledgeBaseComputation: [self knowledgeBase]) newNotesButtonStencil
				smallIcon smallMargin
				create size: self iconSize).
	self
		addChild: ((GtHomeToolsSection new
				knowledgeBaseComputation: [self knowledgeBase]) newLepiterButtonStencil
				smallIcon smallMargin
				create size: self iconSize).
	self
		addChild: (GtHomeToolsSection new newCoderButtonStencil smallIcon
				smallMargin create
				size: self iconSize).
	self
		addChild: (GtHomeToolsSection new newGitButtonStencil smallIcon smallMargin
				create size: self iconSize).
	self
		addChild: (GtHomeToolsSection new newCodeChangesButtonStencil smallIcon
				smallMargin create
				size: self iconSize).
	self
		addChild: (GtHomeToolsSection new newMonitorButtonStencil smallIcon
				smallMargin create
				size: self iconSize).
	self
		addChild: (GtHomeToolsSection new newExamplesButtonStencil smallIcon
				smallMargin create
				size: self iconSize).
	self
		addChild: (GtHomeToolsSection new newTranscriptButtonStencil smallIcon
				smallMargin create
				size: self iconSize).
	self
		addChild: (GtHomeToolsSection new newFileSystemButtonStencil smallIcon
				smallMargin create
				size: self iconSize).
	self
		addChild: (GtHomeToolsSection new newMorphicWorldButtonStencil smallIcon
				smallMargin create
				size: self iconSize)
]

{ #category : #accessing }
GtToolsMenu >> dropDownAptitude: anAptitude [
	dropDownAptitude := anAptitude
]

{ #category : #initialization }
GtToolsMenu >> iconSize [
	^ 75 asPoint
]

{ #category : #initialization }
GtToolsMenu >> initialize [
	super initialize.
	
	self layout: BlFlowLayout new.
	self hMatchParent.
	self vFitContent.
	self padding: (BlInsets all: 10).
	self initializeElements
]

{ #category : #initialization }
GtToolsMenu >> initializeElements [
	self removeChildren.
	self addSections.
	self addBottomButtons
]

{ #category : #accessing }
GtToolsMenu >> knowledgeBase [
	^ knowledgeBase
]

{ #category : #accessing }
GtToolsMenu >> knowledgeBase: aKnowledgeBase [
	knowledgeBase := aKnowledgeBase
]

{ #category : #'hooks - children' }
GtToolsMenu >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self initializeElements
]

{ #category : #'private - actions' }
GtToolsMenu >> quitFrom: aButton [
	aButton label: 'Quitting...'.
	aButton disable.
	aButton space universe snapshot: false andQuit: true.
	aButton space universe postpone: [
		aButton enqueueTask: (BlTaskAction new action: [
			aButton label: 'Quit'; enable ]) ].
]

{ #category : #initialization }
GtToolsMenu >> renameButton [
	"Stub for Extension for Lifeware"
	^nil
]

{ #category : #'private - actions' }
GtToolsMenu >> saveFrom: aButton [
	aButton label: 'Saving...'.
	aButton disable.
	aButton space universe snapshot: true andQuit: false.
	aButton space universe postpone: [
		dropDownAptitude hide.
		aButton enqueueTask: (BlTaskAction new action: [
			aButton label: 'Save'; enable ]) ].
]
