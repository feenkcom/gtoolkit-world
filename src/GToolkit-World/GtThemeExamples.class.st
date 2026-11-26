"
I provide shared theme assertions for World scenarios.
"
Class {
	#name : #GtThemeExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #assertions }
GtThemeExamples >> assertCloseIconIn: aScripter target: aButtonTarget [
	aScripter
		checkStep: [ :aStep | 
			aStep label: 'Check the close icon and its size'.
			aButtonTarget value: aStep.
			aStep
				value: [ :aButton | 
					| anIcon |
					anIcon := aButton childNamed: #icon.
					{aButton isVisible.
						anIcon geometry class.
						aButton bounds inSpace asRectangle
							containsRect: anIcon bounds inSpace asRectangle} ]
				equals: {true.
						BlSvgPath.
						true} ]
]

{ #category : #assertions }
GtThemeExamples >> assertLabels: someLabels foreground: aColor in: aScripter [
	someLabels
		do: [ :aString | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the foreground of ' , aString;
						onSpaceRoot;
						// BlAttributedTextElement;
						@ [ :aLabel | aLabel text asString = aString ];
						value: [ :aLabel | self resolvedTextForegroundOf: aLabel ] equals: aColor ] ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterBindingsButtonIconForegroundIn: aScripter [
	| aTheme aForeground aColorOf |
	aTheme := aScripter element theme.
	aForeground := aTheme button defaultTextForeground
			blocResolveColorForTheme: aTheme.
	aColorOf := [ :anIcon | 
		| aBackground |
		aBackground := anIcon background.
		aBackground isTransparent
			ifTrue: [ Color transparent ]
			ifFalse: [ aBackground paint color blocResolveColorForTheme: anIcon theme ] ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the variable bindings icon foreground';
				// #'lepiter--page-bindings-button';
				value: [ :aButton | aColorOf value: aButton icon ] equals: aForeground ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the variable bindings dropdown indicator foreground';
				// #'lepiter--page-bindings-button';
				// #iconDropdown;
				value: aColorOf equals: aForeground ]
]

{ #category : #assertions }
GtThemeExamples >> assertLepiterBindingsTableColorsIn: aScripter [
	| aTheme |
	aTheme := aScripter element theme.
	GtWorldByScripterExamples new openLepiterPageBindingsIn: aScripter.
	self
		assertLabels: #('Name' 'Value' 'Actions')
		foreground: (aTheme label metadataTextForeground
				blocResolveColorForTheme: aTheme)
		in: aScripter
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterCompositeToolSwitcherColorsIn: aScripter [
	| aTheme |
	aTheme := aScripter element theme.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the composite tool switcher surface';
				// #tool;
				/ #header;
				value: [ :aHeader | aHeader background paint color blocResolveColorForTheme: aHeader theme ]
					equals: (aTheme default contentBackground blocResolveColorForTheme: aTheme) ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Lepiter tab glyph foreground';
				// #tool;
				/ #header;
				// BrTab;
				@ [ :aTab | aTab label asString = 'Lepiter' ];
				// #icon;
				// BlTextElement;
				value: [ :aGlyph | self resolvedTextForegroundOf: aGlyph ]
					equals: (aTheme label defaultTextForeground blocResolveColorForTheme: aTheme) ].
	GtWorldByScripterExamples new
		visitLepiterCompositeToolTabStatesIn: aScripter
		afterEach: [ :aTarget :aColorSelector | 
			aScripter
				checkStep: [ :aStep | 
					aStep label: 'Check the composite tool tab background for ' , aColorSelector.
					aTarget value: aStep.
					aStep
						value: [ :aTab | 
							| aBackground |
							aBackground := aTab background.
							aBackground isTransparent
								ifTrue: [ Color transparent ]
								ifFalse: [ aBackground paint color blocResolveColorForTheme: aTab theme ] ]
						equals: ((aTheme item perform: aColorSelector)
								blocResolveColorForTheme: aTheme) ] ].
	self assertLepiterInspectorDatabaseIconForegroundIn: aScripter
]

{ #category : #assertions }
GtThemeExamples >> assertLepiterEvaluatedMetaColorsIn: aScripter [
	| aTheme |
	GtWorldByScripterExamples new openEvaluatedLepiterSnippetMetaViewIn: aScripter.
	aTheme := aScripter element theme.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Meta view backdrop and Coder background';
				// GtInspector;
				// GtCoderElement;
				value: [ :aCoder | 
						{aCoder parent background paint color blocResolveColorForTheme: aCoder theme.
							aCoder background paint color blocResolveColorForTheme: aCoder theme} ]
					equals: {aTheme default backdropBackground blocResolveColorForTheme: aTheme.
							aTheme default contentBackground blocResolveColorForTheme: aTheme} ].
	{GtBehaviorCoderActionsElement.
		GtFilterItemsElement}
		do: [ :aContainerClass | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the Meta view string icon foreground';
						// GtInspector;
						// GtCoderElement;
						// aContainerClass;
						// BlAttributedTextElement;
						@ [ :aGlyph | aGlyph text asString = '¶' ];
						value: [ :aGlyph | self resolvedTextForegroundOf: aGlyph ]
							equals: (aTheme label metadataTextForeground blocResolveColorForTheme: aTheme) ] ]
]

{ #category : #assertions }
GtThemeExamples >> assertLepiterEvaluatedRawIconsIn: aScripter [
	| aTheme aForeground |
	GtWorldByScripterExamples new openEvaluatedLepiterSnippetRawViewIn: aScripter.
	aTheme := aScripter element theme.
	aForeground := aTheme label metadataTextForeground
			blocResolveColorForTheme: aTheme.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the string and number icons in the Raw inspector';
				// GtInspector;
				// #'inspector--raw-value-icon';
				value: [ :someIcons | 
						(someIcons
							collect: [ :anIcon | 
								{anIcon text asString.
									self resolvedTextForegroundOf: (anIcon childNamed: #label)} ]) asSet ]
					equals: {{'¶'.
								aForeground}.
							{'Σ'.
								aForeground}} asSet ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterInspectorDatabaseIconForegroundIn: aScripter [
	| aTheme aForeground |
	aTheme := aScripter element theme.
	aForeground := aTheme label defaultTextForeground
			blocResolveColorForTheme: aTheme.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the database icon outline and glyph in the page inspector';
				// LePageDatabaseActionId;
				value: [ :aButton | 
						| anIcon anOutline aGlyph |
						anIcon := aButton icon.
						anOutline := anIcon children first.
						aGlyph := anIcon children second children first.
						{anOutline border paint color rawColor.
							self resolvedTextForegroundOf: aGlyph} ]
					equals: {aForeground.
							aForeground} ]
]

{ #category : #assertions }
GtThemeExamples >> assertLepiterInspectorSnippetsTableColorsIn: aScripter [
	| aTheme |
	aTheme := aScripter element theme.
	GtWorldByScripterExamples new selectLepiterInspectorSnippetsIn: aScripter.
	self
		assertLabels: #('Type' 'Content')
			foreground: (aTheme label metadataTextForeground
					blocResolveColorForTheme: aTheme)
			in: aScripter;
		assertLabels: #('LeTextSnippet' 'LePharoSnippet' 'A text snippet.' '42 printString')
			foreground: (aTheme label defaultTextForeground
					blocResolveColorForTheme: aTheme)
			in: aScripter.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the inspector playground resize handle';
				// LeInspectorPlaygroundResizerId;
				value: [ :aResizer | aResizer background paint color blocResolveColorForTheme: aResizer theme ]
					equals: (aTheme default contentBackground blocResolveColorForTheme: aTheme) ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the composite tool switcher shadow';
				onSpaceRoot;
				value: [ :aRoot | 
						| aTabGroup aShadow |
						aTabGroup := aRoot withAllChildrenBreadthFirst
								detect: [ :anElement | 
									(anElement isKindOf: BrTabGroup)
										and: [ (anElement childNamed: #header) effect isKindOf: BlGaussianShadowEffect ] ].
						aShadow := (aTabGroup childNamed: #header) effect.
						{aShadow color isKindOf: Color.
							aShadow color} ]
					equals: {true.
							aTheme default defaultShadowColor rawColor} ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterPageActionMenuItemColors: anItem [
	| aLabel aTheme aSurface aForeground |
	aLabel := ((anItem childNamed: #'menu--labeled') childNamed: #'menu--label')
			childNamed: #label.
	aTheme := anItem theme.
	aSurface := anItem.
	[ aSurface background isTransparent ]
		whileTrue: [ aSurface := aSurface parent ].
	aForeground := anItem isEnabled
			ifTrue: [ aTheme label defaultTextForeground ]
			ifFalse: [ aTheme button disabledTextColor ].
	self
		assert: (aSurface background paint color blocResolveColorForTheme: aSurface theme)
		equals: (aTheme default contentBackground blocResolveColorForTheme: aTheme).
	self
		assert: (self resolvedTextForegroundOf: aLabel)
		equals: (aForeground blocResolveColorForTheme: aTheme)
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterPageActionsMenuColorsIn: aScripter [
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the colors of the expanded page actions menu';
				onSpaceRoot;
				// BrMenuSteppedElement;
				do: [ :aMenu | 
					| aTheme itemRows groupLabels |
					aTheme := aMenu theme.
					self
						assert: (aMenu background paint color blocResolveColorForTheme: aTheme)
						equals: (aTheme default contentBackground blocResolveColorForTheme: aTheme).
					self
						assert: (aMenu border paint color blocResolveColorForTheme: aTheme)
						equals: (aTheme button defaultBorderColor blocResolveColorForTheme: aTheme).
					itemRows := OrderedCollection new.
					groupLabels := OrderedCollection new.
					aMenu
						allChildrenBreadthFirstDo: [ :anElement | 
							(anElement isKindOf: BrMenuLabeledItemElement)
								ifTrue: [ itemRows add: anElement ].
							((anElement isKindOf: BrLabel)
								and: [ anElement parent isKindOf: BrInfiniteListElement ])
								ifTrue: [ groupLabels add: (anElement childNamed: #label) ] ].
					self assert: groupLabels isNotEmpty.
					groupLabels
						do: [ :aLabel | 
							self
								assert: (self resolvedTextForegroundOf: aLabel)
								equals: (aTheme label metadataTextForeground blocResolveColorForTheme: aTheme) ].
					self assert: itemRows isNotEmpty.
					itemRows
						do: [ :anItem | self assertLepiterPageActionMenuItemColors: anItem ] ] ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterPageBackground: aBackgroundColor snippetForeground: aForegroundColor in: aScripter [
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Lepiter page background';
				// GtTreePagerPaneContentElement;
				value: [ :aPane | aPane background paint color blocResolveColorForTheme: aPane theme ]
					equals: aBackgroundColor ].
	{LeTextCoderSnippetElement.
		LePharoSnippetElement}
		do: [ :aSnippetClass | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the editor foreground of ' , aSnippetClass name;
						// aSnippetClass;
						// BrTextEditorParagraphElement;
						value: [ :aParagraph | aParagraph defaultTextColor blocResolveColorForTheme: aParagraph theme ]
							equals: aForegroundColor ] ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterPageTitleBackground: aColor focused: isFocused hovered: isHovered in: aScripter [
	| aStateLabel |
	aStateLabel := isFocused
			ifTrue: [ 'focused' ]
			ifFalse: [ isHovered ifTrue: [ 'hovered' ] ifFalse: [ 'at rest' ] ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the page title background ' , aStateLabel;
				// LePageEditableTitleElement;
				// BrEditor;
				value: [ :anEditor | 
						{anEditor states hasState: BlElementState focused.
							anEditor states hasState: BlElementState hovered.
							anEditor background paint color blocResolveColorForTheme: anEditor theme} ]
					equals: {isFocused.
							isHovered.
							aColor} ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterPageTitleBackground: aColor in: aScripter [
	GtWorldByScripterExamples new
		visitLepiterPageTitleStatesIn: aScripter
		afterEach: [ :isFocused :isHovered | 
			self
				assertLepiterPageTitleBackground: aColor
				focused: isFocused
				hovered: isHovered
				in: aScripter ]
]

{ #category : #assertions }
GtThemeExamples >> assertLepiterPharoSnippetExpanderColorsIn: aScripter [
	| aTheme aFadedColor |
	aTheme := aScripter element theme.
	aFadedColor := aTheme button fadedBackgroundColor
			blocResolveColorForTheme: aTheme.
	self assertPharoSnippetExpander: aFadedColor in: aScripter.
	aScripter
		mouseMoveOverStep: [ :aStep | 
			aStep
				label: 'Hover over the Pharo snippet';
				// LePharoSnippetElement ].
	self assertPharoSnippetExpander: aFadedColor in: aScripter.
	aScripter
		clickStep: [ :aStep | 
			aStep
				label: 'Focus the Pharo snippet editor';
				// LePharoSnippetElement;
				// BrEditor ].
	self
		assertPharoSnippetExpander: (aTheme default primaryBorderColor blocResolveColorForTheme: aTheme)
		in: aScripter
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterSnippetBackground: aBackgroundColor shadowColor: aShadowColor of: aSnippetClass in: aScripter [
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the background of ' , aSnippetClass name;
				// aSnippetClass;
				// #snippetContainer;
				value: [ :aContainer | aContainer background paint color blocResolveColorForTheme: aContainer theme ]
					equals: aBackgroundColor ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the shadow color of ' , aSnippetClass name;
				// aSnippetClass;
				// #snippetContainer;
				value: [ :aContainer | aContainer effect color blocResolveColorForTheme: aContainer theme ]
					equals: (aShadowColor blocResolveColorForTheme: aScripter element theme) ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertLepiterSnippetDecorationBackgroundsIn: aScripter [
	| aTheme aColor |
	aTheme := aScripter element theme.
	aColor := aTheme default contentBackground blocResolveColorForTheme: aTheme.
	GtWorldByScripterExamples new
		visitLepiterSnippetDecorationButtonStatesIn: aScripter
		afterEach: [ :aLabel :aButtonTarget :isHovered | 
			aScripter
				checkStep: [ :aStep | 
					aStep label: 'Check the colors of the ' , aLabel.
					aButtonTarget value: aStep.
					aStep
						value: [ :aButton | 
							| anIcon |
							anIcon := aButton childNamed: #icon.
							{aButton isVisible.
								aButton states hasState: BlElementState hovered.
								aButton background paint color blocResolveColorForTheme: aButton theme.
								anIcon geometry class.
								anIcon background paint color blocResolveColorForTheme: aButton theme} ]
						equals: {true.
								isHovered.
								aColor.
								BlSvgPath.
								(isHovered
									ifTrue: [ aTheme button hoveredTextColor ]
									ifFalse: [ aTheme button defaultTextForeground ])
									blocResolveColorForTheme: aTheme} ].
			aLabel = 'remove-snippet button'
				ifTrue: [ self assertCloseIconIn: aScripter target: aButtonTarget ] ]
]

{ #category : #assertions }
GtThemeExamples >> assertLepiterTreePagerConfigurationColorsIn: aScripter [
	| aTheme aForeground |
	aTheme := aScripter element theme.
	aForeground := aTheme label defaultTextForeground
			blocResolveColorForTheme: aTheme.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the pager scrollbar thumb color';
				// GtTreePagerScrollbarElement;
				// BlHorizontalScrollbarElement;
				/ #thumb;
				value: [ :aThumb | aThumb background paint color blocResolveColorForTheme: aThumb theme ]
					equals: (aTheme button fadedBackgroundColor blocResolveColorForTheme: aTheme) ].
	GtWorldByScripterExamples new openLepiterTreePagerConfigurationIn: aScripter.
	self
		assertLabels: #('Number of visible columns')
		foreground: aForeground
		in: aScripter.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the displayed number of columns';
				onSpaceRoot;
				// #'tree-pager--visible-columns-value';
				/ #label;
				value: [ :aLabel | self resolvedTextForegroundOf: aLabel ]
					equals: aForeground ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertPaneDropdownShadowsIn: aScripter triggerId: anId [
	GtWorldByScripterExamples new
		visitPaneDropdownStatesIn: aScripter
		triggerId: anId
		afterEach: [ :isExpanded | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the pane dropdown trigger shadow';
						onSpaceRoot;
						// anId;
						value: [ :aButton | aButton effect class ]
							equals: (isExpanded ifTrue: [ BlNullEffect ] ifFalse: [ BlGaussianShadowEffect ]) ].
			isExpanded
				ifTrue: [ aScripter
						checkStep: [ :aStep | 
							aStep
								label: 'Check the expanded pane dropdown handle has no shadow';
								onSpaceRoot;
								// BrMenuSteppedElement;
								/ BrButton;
								value: [ :aHandle | aHandle effect class ] equals: BlNullEffect ] ] ]
]

{ #category : #assertions }
GtThemeExamples >> assertPharoSnippetExpander: aColor in: aScripter [
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Pharo snippet expander color';
				// LePharoSnippetElement;
				/ #content;
				/ #snippetContainer;
				value: [ :aContainer | 
						| anExpander |
						anExpander := aContainer children first.
						anExpander background paint color
							blocResolveColorForTheme: anExpander theme ]
					equals: aColor ]
]

{ #category : #'asserting - theme' }
GtThemeExamples >> assertTreePagerPaneButtonColorsIn: aScripter [
	| aTheme aBackground aForeground |
	aTheme := aScripter element theme.
	aBackground := aTheme default contentBackground
			blocResolveColorForTheme: aTheme.
	aForeground := aTheme button defaultTextForeground
			blocResolveColorForTheme: aTheme.
	{#'tree-pager--maximize-pane-button'.
		#'tree-pager--dropdown-menu-button'}
		do: [ :anId | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the pane button colors for ' , anId;
						// anId;
						value: [ :aButton | 
								| iconColors |
								iconColors := OrderedCollection new.
								aButton
									allChildrenBreadthFirstDo: [ :anElement | 
										(anElement geometry isKindOf: BlSvgPath)
											ifTrue: [ iconColors
													add: (anElement background paint color blocResolveColorForTheme: anElement theme) ] ].
								{aButton isVisible and: [ aButton parent isVisible ].
									aButton background paint color blocResolveColorForTheme: aButton theme.
									iconColors asArray} ]
							equals: {true.
									aBackground.
									{aForeground}} ] ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the alignment of the pane dropdown icon';
				// #'tree-pager--dropdown-menu-button';
				value: [ :aButton | 
						| anIcon |
						anIcon := aButton childNamed: #icon.
						{anIcon size.
							anIcon bounds inSpace center - aButton bounds inSpace center} ]
					equals: {16 @ 16.
							0 @ 1} ]
]

{ #category : #assertions }
GtThemeExamples >> assertWorldTabColorsIn: aScripter [
	| aTheme aForeground aPageTitle |
	aTheme := aScripter element theme.
	aForeground := aTheme label defaultTextForeground
			blocResolveColorForTheme: aTheme.
	aPageTitle := aScripter model page title.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the World tab title';
				// GtWorldTabGroupId;
				/ #header;
				// BrTab;
				@ [ :aTab | aTab label asString = aPageTitle ];
				/ #label;
				value: [ :aLabel | self resolvedTextForegroundOf: aLabel ]
					equals: aForeground ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Lepiter World tab icon outline and glyph';
				// GtWorldTabGroupId;
				value: [ :aTabGroup | 
						| anIcon anOutline aGlyph |
						anIcon := aTabGroup tabs second widget childNamed: #icon.
						anOutline := anIcon children first.
						aGlyph := anIcon children second children first.
						{anOutline border paint color blocResolveColorForTheme: anOutline theme.
							self resolvedTextForegroundOf: aGlyph} ]
					equals: {aForeground.
							aForeground} ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the World Home icon';
				// GtWorldTabGroupId;
				/ #header;
				// BrTab;
				@ [ :aTab | aTab label asString = 'Home' ];
				// #icon;
				// BlTextElement;
				value: [ :aLabel | self resolvedTextForegroundOf: aLabel ]
					equals: aForeground ]
]

{ #category : #examples }
GtThemeExamples >> baselinePackageExpanderBackgroundWithTheme: aTheme [
	| aCoder aPane aScripter |
	aCoder := GtPharoMethodCoder
			forMethod: BaselineOfGToolkitObjectClipboard >> #baseline:.
	aPane := BrVerticalPane new
			matchParent;
			theme: aTheme;
			background: aTheme default contentBackground;
			addChild: aCoder asExpandedOnlyElement;
			yourself.
	aScripter := BlScripter new
			extent: 710 @ 590;
			element: aPane.
	aScripter space root
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter
		clickStep: [ :aStep | 
			aStep
				label: 'Expand the baseline package';
				id: GtSourceCoderEmbeddedExpanderToggleId ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'The package expander uses the editor theme content background';
				// GtPharoPackageCoderElement;
				value: [ :anExpander | anExpander background paint color blocResolveColorForTheme: anExpander theme ]
					equals: aTheme default contentBackground rawColor ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'The class title uses the theme label foreground';
				// GtPharoPackageCoderElement;
				// GtClassCardElement;
				// BlShrinkingTextElement;
				@ [ :aTitle | aTitle text asString = 'GtObjectClipboard' ];
				value: [ :aTitle | self resolvedTextForegroundOf: aTitle ]
					equals: aTheme label defaultTextForeground rawColor ].
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> baselinePackageOccurrenceHighlightWithTheme: aTheme [
	| aMethod aSource aPackageName aFirst aSecond aScripter |
	aMethod := BaselineOfGToolkit4Ruby >> #baseline:.
	aSource := aMethod sourceCode.
	aPackageName := 'SmaCC_Mysql'.
	aFirst := aSource findString: aPackageName.
	aSecond := aSource findString: aPackageName startingAt: aFirst + 1.
	aScripter := GtPharoDynamicHighlightStylerExamples new
			scripterForBlock: [ (GtPharoMethodCoder forMethod: aMethod) asCoderViewModel ].
	aScripter space windowExtent: 700 @ 195.
	aScripter element
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter space root
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Move the cursor into the package name';
				action: [ :aViewModel | aViewModel moveCursorTo: aFirst + 1 ];
				onModel ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Both package occurrences use the editor highlight';
				id: GtSourceCoderEditorId;
				value: [ :anEditor | 
						{aFirst.
							aSecond}
							collect: [ :aPosition | 
								| someHighlights |
								someHighlights := (anEditor text attributesAt: aPosition)
										select: [ :each | each isKindOf: GtPharoDynamicHighlightAttribute ].
								(someHighlights
									collect: [ :anAttribute | 
										| aStyle |
										aStyle := BlTextFontAndStyleBuilder new.
										anAttribute applyOnFontAndStyleBuilder: aStyle theme: anEditor theme.
										aStyle background ]) asSet ] ]
					equals: (Array
							new: 2
							withAll: (Set with: aTheme editor occurrenceHighlight rawColor)) ].
	^ aScripter
]

{ #category : #assertions }
GtThemeExamples >> constantColorRoles [
	^ #(#(default #(appBackground contentBackground backdropBackground backdropEmphasisBackground navigationBackground defaultShadowColor primaryShadowColor primaryBorderColor strongBorderColor newsBackgroundColor subtleBorderColor expandCollapseTriangleBackgroundColor shadowColor)) #(header #(defaultBackgroundColor textMarkupColor disabledTextColor defaultTextColor secondaryBackgroundColor)) #(button #(disabledBackgroundColor defaultBackground disabledTextColor pressedBorderColor defaultBorderColor defaultTextColor hoveredBorderColor pressedTextColor hoveredTextColor textHighlightColor fadedBackgroundColor focusedFadedBackgroundColor disabledBorderColor)) #(editor #(pharoDeclaredVariableForeground pharoUndeclaredVariableForeground pharoSelfVariableForeground pharoSuperVariableForeground pharoThisContextVariableForeground pharoPragmaForeground pharoReturnArrowForeground pharoStringLiteralForeground pharoSymbolLiteralForeground pharoNumberLiteralForeground pharoNilLiteralForeground pharoBooleanLiteralForeground pharoCharacterLiteralForeground pharoCommentForeground pharoErrorTokenForeground enabledBreakpointForeground enabledBreakpointBackground disabledBreakpointForeground disabledBreakpointBackground borderColor focusedBorderColor completionPreviewBackground occurrenceHighlight sourceReferenceHighlight)) #(item #(selectedColor deselectedColor hoveredColor defaultColor focusedBorderColor pressedColor)) #(status #(successBackgroundColor successBorderColor neutralBackgroundColor neutralBorderColor errorBorderColor errorBackgroundColor failureBorderColor paleErrorBackgroundColor failureBackgroundColor changesBackgroundColor)) #(link #(color errorColor)) #(markup #(foreground background codeFenceForeground)) #(columnedList #(headerBackgroundColor sortableHeaderHoveredBackgroundColor)) #(diffElement #(deletedLineBackgroundColor deletedTextBackgroundColor addedLineBackgroundColor addedTextBackgroundColor unchangedSideBackgroundColor connectorBackgroundColor borderColor editorBorderColor editorBackgroundColor selectedBorderColor labelForegroundColor)))
]

{ #category : #examples }
GtThemeExamples >> methodCoderCompletionColorsWithTheme: aTheme [
	| aScripter |
	aScripter := GtPharoMethodCoderByScripterExamples new
			emptyBodyMethodCoderUI_ModifySourceCode.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Apply the theme to the coder';
				block: [ :aCoder | 
					aCoder
						theme: aTheme;
						background: aTheme default contentBackground ] ].
	aScripter
		assertStep: [ :aStep | 
			aStep
				label: 'Completion popup follows the editor theme';
				onSpaceRoot;
				// GtCompletionPopupElement;
				value: [ :aPopup | aPopup theme ] equals: aTheme;
				value: [ :aPopup | aPopup background paint color blocResolveColorForTheme: aPopup theme ]
					equals: aTheme default contentBackground rawColor ].
	aScripter
		assertStep: [ :aStep | 
			aStep
				label: 'Advice highlights use the theme error background';
				id: GtSourceCoderEditorId;
				id: GtSourceCoderEditorInnerId;
				value: [ :anEditor | 
						| aText aHighlight aStyleBuilder |
						aText := anEditor editor text.
						aHighlight := (aText attributesAt: aText size)
								detect: [ :anAttribute | anAttribute isKindOf: BlTextHighlightAttribute ].
						aStyleBuilder := BlTextFontAndStyleBuilder new.
						aHighlight applyOnFontAndStyleBuilder: aStyleBuilder theme: anEditor theme.
						aStyleBuilder background ]
					equals: aTheme status paleErrorBackgroundColor rawColor ].
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> methodCoderDefineClassPreviewBackgroundWithTheme: aTheme [
	| aScripter |
	aScripter := GtPharoMethodCoderByScripterExamples new
			fixitCreateClass_03_click_define_class.
	aScripter element
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter space root
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter extent: 670 @ 415.
	aScripter pulse.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'The class definition preview uses the theme content background';
				// GtCreationFormWidget;
				value: [ :aForm | 
						{aForm theme.
							aForm background paint color blocResolveColorForTheme: aForm theme} ]
					equals: {aTheme.
							aTheme default contentBackground rawColor} ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'The undefined class uses the pale error background';
				id: GtSourceCoderEditorId;
				value: [ :anEditor | 
						| aText anUnderlay aStyle |
						aText := anEditor text.
						anUnderlay := (aText
								attributesAt: (aText asString findString: 'ClassThatDoesNotExist'))
								detect: [ :each | each isKindOf: BlTextUnderlayAttribute ].
						aStyle := BlTextFontAndStyleBuilder new.
						anUnderlay applyOnFontAndStyleBuilder: aStyle theme: anEditor theme.
						aStyle background ]
					equals: aTheme status paleErrorBackgroundColor rawColor ].
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> methodCoderDeprecationColorsWithTheme: aTheme [
	| aCoder anElement aScripter |
	aCoder := GtPharoMethodCoder new
			behavior: GtThemeExamples;
			sourceCodeSynchronously: (GtCoderExplicitStringSource new
					source: 'deprecatedShape
	^ BlCircle');
			yourself.
	anElement := aCoder asElement
			theme: aTheme;
			background: aTheme default contentBackground;
			yourself.
	aScripter := BlScripter new
			extent: 520 @ 100;
			element: anElement.
	aScripter space root
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'The deprecated class strike-through follows the editor foreground';
				id: GtSourceCoderEditorId;
				id: GtSourceCoderEditorInnerId;
				value: [ :anEditor | 
						| aText aPosition anAttribute aStyle |
						aText := anEditor editor text.
						aPosition := aText asString findString: 'BlCircle'.
						anAttribute := (aText attributesAt: aPosition)
								detect: [ :each | each isKindOf: BlTextDecorationAttribute ].
						aStyle := BlTextFontAndStyleBuilder new.
						anAttribute applyOnFontAndStyleBuilder: aStyle theme: anEditor theme.
						aStyle decoration color ]
					equals: [ :anEditor | anEditor theme editor pharoDeclaredVariableForeground rawColor ] ].
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> methodCoderDynamicHighlightColorsWithTheme: aTheme [
	| aSource aCoder aScripter |
	aSource := 'highlightOccurrences
	| items |
	items := #(1 2 3).
	^ items at: 4 ifAbsent: [ items first ]'.
	aCoder := GtPharoMethodCoder new
			behavior: GtThemeExamples;
			sourceCodeSynchronously: (GtCoderExplicitStringSource new source: aSource);
			yourself.
	aScripter := GtPharoDynamicHighlightStylerExamples new
			scripterForBlock: [ aCoder asCoderViewModel ].
	aScripter space windowExtent: 520 @ 145.
	aScripter element
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter space root
		theme: aTheme;
		background: aTheme default contentBackground.
	{'items at:' -> #('items :=' 'items at:' 'items first').
		'at: 4' -> #('at: 4' 'ifAbsent:')}
		do: [ :aCase | 
			aScripter
				doStep: [ :aStep | 
					aStep
						label: 'Move the cursor into ' , aCase key;
						action: [ :aViewModel | aViewModel moveCursorTo: (aSource findString: aCase key) + 1 ];
						onModel ].
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Occurrences use the editor highlight color';
						id: GtSourceCoderEditorId;
						value: [ :anEditor | 
								aCase value
									collect: [ :aFragment | 
										| aPosition anAttribute aStyle |
										aPosition := anEditor text asString findString: aFragment.
										anAttribute := (anEditor text attributesAt: aPosition)
												detect: [ :each | each isKindOf: GtPharoDynamicHighlightAttribute ].
										aStyle := BlTextFontAndStyleBuilder new.
										anAttribute applyOnFontAndStyleBuilder: aStyle theme: anEditor theme.
										aStyle background ] ]
							equals: (Array
									new: aCase value size
									withAll: aTheme editor occurrenceHighlight rawColor) ] ].
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> methodCoderExampleStatusColorsWithTheme: aTheme [
	| someCases aPane aScripter |
	someCases := {{#three.
				AssertionFailure.
				'assert:'.
				aTheme status failureBackgroundColor}.
			{#two.
				ZeroDivide.
				'/'.
				aTheme status errorBackgroundColor}}.
	aPane := BrVerticalPane new
			matchParent;
			cellSpacing: 8;
			theme: aTheme;
			background: aTheme default contentBackground;
			yourself.
	someCases
		do: [ :aCase | 
			| aClass aCoder |
			aClass := GtFiltersDummyObjectWithAllExampleStates.
			aCoder := GtPharoMethodCoder forMethod: aClass >> aCase first.
			aCoder example run.
			self assert: (aCoder example returnValue isKindOf: aCase second).
			aPane addChild: aCoder asElement as: aCase first ].
	aScripter := BlScripter new
			extent: 640 @ 300;
			element: aPane.
	aScripter space root
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Example failures and errors use their status backgrounds';
				value: [ :aRoot | 
						someCases
							collect: [ :aCase | 
								| aCoderElement anEditor aText anUnderlay aStyle |
								aCoderElement := aRoot childNamed: aCase first.
								anEditor := aCoderElement withAllChildrenBreadthFirst
										detect: [ :each | each id = GtSourceCoderEditorId asBlocElementId ].
								aText := anEditor text.
								anUnderlay := (aText
										attributesAt: (aText asString findString: aCase third))
										detect: [ :each | each isKindOf: BlTextUnderlayAttribute ].
								aStyle := BlTextFontAndStyleBuilder new.
								anUnderlay applyOnFontAndStyleBuilder: aStyle theme: anEditor theme.
								{(anUnderlay paint blocResolveForTheme: anEditor theme) == aCase fourth.
									aStyle background} ] ]
					equals: (someCases
							collect: [ :aCase | 
								{true.
									aCase fourth rawColor} ]) ].
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> methodCoderTimeLimitColorsWithTheme: aTheme [
	| aCoder anElement aScripter |
	aCoder := GtPharoMethodCoder
			forMethod: GtCoderExampleTimeLimitStylerExamples >> #methodWithTimeLimit.
	anElement := aCoder asElement
			theme: aTheme;
			background: aTheme default contentBackground;
			yourself.
	aScripter := BlScripter new
			extent: 520 @ 145;
			element: anElement.
	aScripter space root
		theme: aTheme;
		background: aTheme default contentBackground.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'The duration annotation uses the theme foreground';
				id: GtSourceCoderEditorId;
				// BlTextElement;
				@ [ :aLabel | aLabel text asString = ' ms (2 minutes)' ];
				value: [ :aLabel | self resolvedTextForegroundOf: aLabel ]
					equals: aTheme button disabledTextColor rawColor ].
	^ aScripter
]

{ #category : #'asserting - theme' }
GtThemeExamples >> resolvedTextForegroundOf: aGlyph [
	| aForeground |
	aForeground := (aGlyph text attributesAt: 1)
			detect: [ :anAttribute | anAttribute isKindOf: BlTextForegroundAttribute ]
			ifNone: [ nil ].
	^ aForeground
		ifNil: [ (aGlyph defaultTextForeground ifNil: [ Color black ])
				blocResolveColorForTheme: aGlyph theme ]
		ifNotNil: [ aForeground paint blocResolveColorForTheme: aGlyph theme ]
]

{ #category : #examples }
GtThemeExamples >> scripterSourceReferenceColorsWithTheme: aTheme [
	| aMethod aSource aStart aReference anElement aPane aScripter aSearchDecoration |
	aMethod := ProtoObject >> #isNil.
	aSource := aMethod sourceCode.
	aStart := aSource findString: 'false' startingAt: (aSource indexOf: $^).
	aReference := BlDevScripterReference
			method: aMethod asRingDefinition
			interval: (aStart to: aStart + 4).
	anElement := (aReference gtReferenceFor: GtPhlowView empty)
			asElementDo: [ :each | each ].
	aPane := BrVerticalPane new
			matchParent;
			theme: aTheme;
			background: aTheme default contentBackground;
			addChild: anElement;
			yourself.
	aScripter := BlScripter new
			extent: 520 @ 155;
			element: aPane.
	aScripter space root
		theme: aTheme;
		background: aTheme default contentBackground.
	aSearchDecoration := GtSourceReferenceHighlighter highlightAttribute decoration.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'The source reference uses the search underline';
				id: GtSourceCoderEditorId;
				value: [ :anEditor | 
						| someAttributes anUnderline aDecoration |
						someAttributes := anEditor text attributesAt: aStart.
						anUnderline := someAttributes
								detect: [ :each | each isKindOf: BlTextDecorationAttribute ]
								ifNone: [ nil ].
						aDecoration := anUnderline
								ifNotNil: [ | aStyle |
									aStyle := BlTextFontAndStyleBuilder new.
									anUnderline applyOnFontAndStyleBuilder: aStyle theme: anEditor theme.
									aStyle decoration ].
						{aDecoration
								ifNotNil: [ {aDecoration type.
										aDecoration thickness.
										aDecoration color} ].
							someAttributes
								anySatisfy: [ :each | each isKindOf: BlTextUnderlayAttribute ]} ]
					equals: {{aSearchDecoration type.
								aSearchDecoration thickness.
								aTheme editor sourceReferenceHighlight rawColor}.
							false} ].
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> worldCoderWithTheme: aTheme [
	| aScripter aWorldExamples aForeground |
	aScripter := self worldSpotterScripterWithTheme: aTheme.
	aWorldExamples := GtWorldByScripterExamples new.
	aWorldExamples
		actOnWorldSpotterCandidateSatisfying: [ :anItem | anItem = Character ]
		in: aScripter.
	aWorldExamples
		assertNewWorldTabIn: aScripter
		hasLabelAndStableIcon: 'Character'.
	aForeground := aTheme label defaultTextForeground
			blocResolveColorForTheme: aTheme.
	self
		assertLabels: #('Packages' 'Classes' 'Superclass:' 'Package:' 'Tag:')
			foreground: (aTheme label metadataTextForeground
					blocResolveColorForTheme: aTheme)
			in: aScripter;
		assertLabels: #('Methods up to' 'Category' 'Instance slots')
			foreground: aForeground
			in: aScripter.
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Coder superclass name';
				// GtPharoBehaviorDefinitionCoderElement;
				// BrTextElementWithCursors;
				@ [ :aLabel | aLabel text asString = 'Magnitude' ];
				value: [ :aLabel | self resolvedTextForegroundOf: aLabel ]
					equals: (aTheme editor defaultTextForeground blocResolveColorForTheme: aTheme) ].
	#('filter--name-1' 'filter--add')
		do: [ :anId | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the Coder filter background';
						// GtFilterItemsElement;
						// BlElement;
						@ [ :anElement | anElement id asString includesSubstring: anId ];
						value: [ :anElement | anElement background paint color blocResolveColorForTheme: anElement theme ]
							equals: (aTheme status neutralBackgroundColor blocResolveColorForTheme: aTheme) ] ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Coder definition expander';
				// GtPharoBehaviorDefinitionCoderElement;
				/ #sidebar;
				value: [ :aSidebar | aSidebar background paint color blocResolveColorForTheme: aSidebar theme ]
					equals: (aTheme button fadedBackgroundColor blocResolveColorForTheme: aTheme) ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the World Coder tab icon';
				// GtWorldTabGroupId;
				value: [ :aTabGroup | 
						| anIcon |
						anIcon := aTabGroup tabs second widget childNamed: #icon.
						{anIcon background paint color blocResolveColorForTheme: anIcon theme.
							anIcon border paint color blocResolveColorForTheme: anIcon theme} ]
					equals: {aForeground.
							aForeground} ].
	GtWorldByScripterExamples new hoverCoderFilterIn: aScripter.
	self
		assertCloseIconIn: aScripter
		target: [ :aStep | 
			aStep
				// GtFilterItemsElement;
				// (GtFilterNameId indexed: 2);
				// GtPagerClosePageButtonElementId ].
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> worldSpotterScripterWithTheme: aTheme [
	| aWorldExamples aScripter |
	aWorldExamples := GtWorldByScripterExamples new.
	aScripter := aWorldExamples worldElementInScripter.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Apply the World theme';
				block: [ :aWorld | aWorld theme: aTheme ] ].
	aWorldExamples openWorldSpotterIn: aScripter query: 'Character'.
	^ aScripter
]

{ #category : #examples }
GtThemeExamples >> worldSpotterWithTheme: aTheme [
	| aScripter aHeaderColor |
	aScripter := self worldSpotterScripterWithTheme: aTheme.
	aHeaderColor := aTheme header secondaryBackgroundColor
			blocResolveColorForTheme: aTheme.
	self
		assertLabels: #('Spotter')
		foreground: (aTheme button defaultTextForeground
				blocResolveColorForTheme: aTheme)
		in: aScripter.
	{GtStreamingSpotterBreadcrumb.
		BrMenuSteppedElement}
		do: [ :anElementClass | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the Spotter header or popover surface';
						onSpaceRoot;
						// anElementClass;
						value: [ :anElement | anElement background paint color blocResolveColorForTheme: anElement theme ]
							equals: aHeaderColor ] ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Spotter popover shadow and border';
				onSpaceRoot;
				// BrMenuSteppedElement;
				value: [ :aPopover | 
						{aPopover effect color blocResolveColorForTheme: aPopover theme.
							aPopover border paint color blocResolveColorForTheme: aPopover theme} ]
					equals: {aTheme default defaultShadowColor blocResolveColorForTheme: aTheme.
							aTheme button defaultBorderColor blocResolveColorForTheme: aTheme} ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the World chat icon outline';
				// GtLWorldChatRegistryDropdown;
				// #icon;
				value: [ :anIcon | anIcon border paint color blocResolveColorForTheme: anIcon theme ]
					equals: (aTheme label defaultTextForeground blocResolveColorForTheme: aTheme) ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Spotter editor caret';
				onSpaceRoot;
				// GtStreamingSpotterSearchField;
				// BrCursorElement;
				value: [ :aCaret | aCaret background paint color blocResolveColorForTheme: aCaret theme ]
					equals: (aTheme editor defaultTextForeground blocResolveColorForTheme: aTheme) ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Spotter results scrollbar thumb';
				onSpaceRoot;
				// GtStreamingSpotterPager;
				// #verticalScrollbar;
				// #thumb;
				value: [ :aThumb | aThumb background paint color blocResolveColorForTheme: aThumb theme ]
					equals: (aTheme button fadedBackgroundColor blocResolveColorForTheme: aTheme) ].
	^ aScripter
]
