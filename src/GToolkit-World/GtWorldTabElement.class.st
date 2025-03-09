Class {
	#name : #GtWorldTabElement,
	#superclass : #BlElement,
	#instVars : [
		'tabs',
		'home'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #accessing }
GtWorldTabElement class >> spaceCloseButtonName [
	^ #'gt-world--space-close-button'
]

{ #category : #accessing }
GtWorldTabElement class >> tabNameForSpaceId: aNumber [
	^ GtWorldSpaceTabId spaceId: aNumber
]

{ #category : #'api - opening' }
GtWorldTabElement >> addContextMenuTabActionsTo: contextMenu [
	contextMenu
		addChild: (BrGlamorousSimpleContextMenuContent new
				items: {'Close tabs to the left'
							-> [ :aButtonElement | self closeTabsLeftTo: aButtonElement viewModel ].
						'Close tabs to the right'
							-> [ :aButtonElement | self closeTabsRightTo: aButtonElement viewModel ].
						'Close all but this'
							-> [ :aButtonElement | 
								self closeTabsLeftTo: aButtonElement viewModel.
								self closeTabsRightTo: aButtonElement viewModel ].
						'Close all tabs' -> [ :aButtonElement | self closeAllTabs ]};
				constraintsDo: [ :c | c horizontal matchParent ];
				hMatchParent;
				yourself)
]

{ #category : #'api - opening' }
GtWorldTabElement >> addContextMoveActionsTo: contextMenu [
	| options |
	options := self moveOptions.
	options
		ifNotEmpty: [ | gray |
			gray := Color gray alpha: 0.2.
			contextMenu
				addChild: (BlElement new
						addChild: (BlElement new
								background: gray;
								margin: (BlInsets
										top: 12
										right: 2
										bottom: 12
										left: 5);
								constraintsDo: [ :c | 
									c vertical exact: 1.
									c horizontal exact: 10 ]);
						addChild: (BrLabel new
								text: 'move to window:';
								aptitude: (BrGlamorousLabelAptitude new
										glamorousRegularFontAndSize;
										foreground: Color lightGray;
										yourself);
								alignCenter;
								constraintsDo: [ :c | c vertical exact: 25 ]);
						addChild: (BlElement new
								background: gray;
								margin: (BlInsets
										top: 12
										right: 5
										bottom: 12
										left: 2);
								constraintsDo: [ :c | 
									c vertical exact: 1.
									c horizontal matchParent ]);
						layout: BlLinearLayout new alignCenter;
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 25 ];
						yourself).

			contextMenu
				addChild: (BrGlamorousSimpleContextMenuContent new
						items: options;
						hMatchParent;
						yourself) ]
]

{ #category : #'api - opening' }
GtWorldTabElement >> aptitudeForSpaceTab: aTab [ 
	| aTabViewModel |
	aTabViewModel := aTab viewModel.
	^ BrGlamorousSpaceTabWithIconAndLabelAptitude new
		+ ((BrGlamorousWithTooltipAptitude
				content: [ BrElementAsFormPreview
					forElement: (aTabViewModel
					cachedContentElementDo: [ :anElement | anElement ]
										ifAbsent: [ BlElement new ])
					preferredExtent: 400 @ 400 ])
				hideDelay: 50 milliSeconds;
				showDelay: 100 milliSeconds)
]

{ #category : #accessing }
GtWorldTabElement >> closeAllTabs [
	[ tabs tabs size = 1 ] whileFalse: [ tabs viewModel removeTab: tabs tabs last ]
]

{ #category : #accessing }
GtWorldTabElement >> closeButtonFor: aTabModel [
	^ BrButton new
		icon: BrGlamorousVectorIcons close;
		exact: 16 @ 16;
		aptitude: GtWorldTabToolbarButtonAptitude;
		label: 'Close';
		model: aTabModel;
		containerName: self class spaceCloseButtonName;
		action: [ :aButtonElement | tabs viewModel removeTab: aButtonElement model ]
]

{ #category : #accessing }
GtWorldTabElement >> closeTabsLeftTo: tab [
	[ tab == tabs tabs second ]
		whileFalse: [ tabs viewModel removeTab: tabs tabs second ]
]

{ #category : #accessing }
GtWorldTabElement >> closeTabsRightTo: tab [
	[ tab == tabs tabs last ]
		whileFalse: [ tabs viewModel removeTab: tabs tabs last ]
]

{ #category : #accessing }
GtWorldTabElement >> createBaseTab: aSpace [
	| aTab |
	aTab := BrTab new.
	aTab
		vExact: 36;
		aptitude: BrGlamorousSpaceTabWithIconAndLabelAptitude;
		label: aSpace title;
		icon: (aSpace icon ifNil: [ BrGlamorousVectorIcons noIcon ]).
	^ aTab
]

{ #category : #'api - opening' }
GtWorldTabElement >> createTabDragHandler [
	^ BlDragHandler new
		restrictDragToHorizontal;
		liftItem: [ :aSourceElement | 
			BlDragItem new
				sourceElement: aSourceElement;
				domainObject: aSourceElement model;
				stencil: [ :aDragItem | 
					(self createBaseTab: aDragItem domainObject)
						select;
						opacity: 0.85 ] ]
]

{ #category : #defaults }
GtWorldTabElement >> defaultHomeElement [
	^ BrLabel new
		text: 'Home';
		aptitude:
			(BrGlamorousLabelAptitude new
				fontSize: 42;
				foreground: self theme button disabledTextColor);
		matchParent;
		alignCenter;
		background: Color white
]

{ #category : #defaults }
GtWorldTabElement >> defaultHomeTab [
	^ BrTab new
		vExact: 36;
		aptitude: BrGlamorousSpaceTabWithIconAptitude;
		icon: self defaultHomeTabIcon;
		label: 'Home';
		stencil: [ self home ]
]

{ #category : #defaults }
GtWorldTabElement >> defaultHomeTabIcon [
	^ BrGlamorousVectorIcons gt
]

{ #category : #'private - accessing' }
GtWorldTabElement >> home [
	^ home
]

{ #category : #initialization }
GtWorldTabElement >> initialize [
	super initialize.
	
	self beFocusable.
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	
	self initializeHomeElement.
	self initializeTabGroup.
	self initializeTabs.
	self initializeElement.
	self initializeShortcuts.
	self initializeListeners.
]

{ #category : #initialization }
GtWorldTabElement >> initializeElement [
	self addChild: tabs as: GtWorldTabGroupId
]

{ #category : #initialization }
GtWorldTabElement >> initializeHomeElement [
	home := self defaultHomeElement
]

{ #category : #initialization }
GtWorldTabElement >> initializeListeners [
	"Subclasses may register listeners"
]

{ #category : #initialization }
GtWorldTabElement >> initializeShortcuts [
	"Subclasses may initialize shortcuts"
]

{ #category : #initialization }
GtWorldTabElement >> initializeTabGroup [
	tabs := BrTabGroup new.
	tabs aptitude: BrGlamorousSpaceTabGroupAptitude new.
	tabs actionbarStencil: [ self newActionbar ].
]

{ #category : #initialization }
GtWorldTabElement >> initializeTabs [
	tabs addTab: self defaultHomeTab
]

{ #category : #accessing }
GtWorldTabElement >> maximizeButtonFor: aTabModel [
	^ BrButton new
		icon: BrGlamorousIcons maximize;
		exact: 16 @ 16;
		aptitude: GtWorldTabToolbarButtonAptitude;
		model: aTabModel;
		label: 'Open in a new window';
		action: [ :aButtonElement | 
			tabs viewModel removeTab: aButtonElement model.
			self space class
				openWithSpaces: {aButtonElement model model}
				from: self space ]
]

{ #category : #accessing }
GtWorldTabElement >> moveOptions [
	| gtWorlds |
	gtWorlds := GtWorld allInstances
			select: [ :e | e isOpened and: [ (tabs == e tabGroup) not ] ].
	^ gtWorlds
		collect: [ :e | 
			e tabGroup viewModel selectedTab tabLabel text
				-> [ :aButtonElement | 
					| myTab |
					myTab := aButtonElement viewModel.
					tabs viewModel removeTab: myTab.
					e showSpace: myTab model ] ]
]

{ #category : #'private - instance creation' }
GtWorldTabElement >> newActionItemsInto: anActionbar [
	"Subclasses may add action items into the World toolbar"
]

{ #category : #'private - instance creation' }
GtWorldTabElement >> newActionbar [
	| anActionbar |

	anActionbar := BrToolbar new.
	anActionbar aptitude: BrGlamorousToolbarAptitude new.
	
	self newActionItemsInto: anActionbar.

	^ anActionbar
]

{ #category : #'private - instance creation' }
GtWorldTabElement >> newShutdownPrompt [
	| aPrompt aQuestion aSaveAndQuitButton aQuitWithoutSaveButton aCancelButton |
	
	aPrompt := BrHorizontalPane new
		hMatchParent;
		cellSpacing: 10;
		vFitContent;
		background: self theme status errorBackgroundColor lighter lighter;
		alignCenterLeft;
		padding: (BlInsets top: 10 bottom: 10).
	
	aQuestion := BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: 'Really quit?'.
	
	aSaveAndQuitButton := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		beSmallSize;
		label: 'Save and quit';
		action: [ :aButton |
			aButton disable.
			aPrompt removeFromParent.
			self space universe snapshot: true andQuit: true ].
		
	aQuitWithoutSaveButton := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		beSmallSize;
		label: 'Just quit';
		action: [ :aButton |
			aButton disable.
			aPrompt removeFromParent.
			self space universe snapshot: false andQuit: true ].
		
	aCancelButton := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		beSmallSize;
		label: 'Don''t quit';
		action: [ :aButton | aPrompt removeFromParent ].

	aPrompt addChildren: {
		aQuestion.
		aSaveAndQuitButton.
		aQuitWithoutSaveButton.
		aCancelButton.
	}.

	^ aPrompt
]

{ #category : #accessing }
GtWorldTabElement >> newToolbarForTabModel: aTabModel [
	^ BrToolbar new
		aptitude: (BrGlamorousToolbarAptitude new spacing: 0);
		margin: (BlInsets left: 6);
		addItems: {self maximizeButtonFor: aTabModel.
				self closeButtonFor: aTabModel}
]

{ #category : #releasing }
GtWorldTabElement >> prepareForRelease [
	"Space sends this message to be saved as part of a release process.
	Subclasses may trigger relevant actions."
	
]

{ #category : #'system startup & shutdown' }
GtWorldTabElement >> refreshContent [
	"Refresh the content of the space. Is only called for a default space instance on start-up.
	Subclasses may trigger relevant actions."
]

{ #category : #'api - shutdown' }
GtWorldTabElement >> showShutdownPrompt [
	self
		childWithId: GtWorldShutdownPromptId
		ifFound: [ ^ self ]
		ifNone: [ self addChildFirst: (self newShutdownPrompt id: GtWorldShutdownPromptId) ]
]

{ #category : #'api - opening' }
GtWorldTabElement >> showSpace: aSpace [
	self showSpace: aSpace select: true
]

{ #category : #'api - opening' }
GtWorldTabElement >> showSpace: aSpace select: shouldBeSelected [
	| aTab |
	aTab := self createBaseTab: aSpace.
	aTab
		model: aSpace;
		aptitude: (self aptitudeForSpaceTab: aTab);
		id: (self class tabNameForSpaceId: aSpace id);
		stencil: [ :aTabModel | 
			| anActualSpace |
			anActualSpace := aTabModel model.
			anActualSpace root hasParent
				ifTrue: [ anActualSpace root removeFromParent ]
				ifFalse: [ anActualSpace root dispatchRemovedFromSceneGraph ].

			aTabModel
				widgetDo: [ :aWidget | 
					aWidget enqueueTask: (GtWorldReEnqueueTasks new previousSpace: anActualSpace).
					anActualSpace root
						addEventHandler: (GtWorldChangeTabAppearanceChangeHandler new tab: aWidget) ].
			anActualSpace root
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ];
		actionbarStencil: [ :aTabModel | self newToolbarForTabModel: aTabModel ].

	aTab addEventHandler: self createTabDragHandler.

	aTab
		addAptitude: (BrLazyStyleCommonAptitude new
				when: BlElementDraggingState uniqueInstance
				style: [ :aStyle | aStyle background: (Color white alpha: 0.25) ]).


	aTab
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude content: [ self tabContextMenu ]).
	aTab selected: shouldBeSelected.
	tabs addTab: aTab.
	aTab := nil
]

{ #category : #'api - opening' }
GtWorldTabElement >> tabContextMenu [
	| contextMenu |
	contextMenu := BlElement new.
	contextMenu
		layout: (BlLinearLayout new
				alignCenterLeft;
				beVertical;
				yourself).
	contextMenu
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	self addContextMenuTabActionsTo: contextMenu.
	self addContextMoveActionsTo: contextMenu.
	^ contextMenu
]

{ #category : #'private - accessing' }
GtWorldTabElement >> tabs [
	<return: #BrTabGroup>
	^ tabs
]

{ #category : #'children - accessing' }
GtWorldTabElement >> topMostParent [
	"This method exists due to Driller.
	Driller places the world in another element,
	But popups still should appear in the world not in Driller."

	^ self
]
