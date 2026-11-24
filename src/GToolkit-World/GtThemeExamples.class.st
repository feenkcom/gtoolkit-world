"
I provide shared theme assertions for World scenarios.
"
Class {
	#name : #GtThemeExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

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
					equals: (aTheme default contentBackground blocResolveColorForTheme: aTheme) ]
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
				label: 'Check the background and foreground of the expanded page actions menu';
				onSpaceRoot;
				// BrMenuSteppedElement;
				do: [ :aMenu | 
					| aTheme itemRows groupLabels |
					aTheme := aMenu theme.
					self
						assert: (aMenu background paint color blocResolveColorForTheme: aTheme)
						equals: (aTheme default contentBackground blocResolveColorForTheme: aTheme).
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
					aStep label: 'Check the background of the ' , aLabel.
					aButtonTarget value: aStep.
					aStep
						value: [ :aButton | 
							{aButton isVisible.
								aButton states hasState: BlElementState hovered.
								aButton background paint color blocResolveColorForTheme: aButton theme} ]
						equals: {true.
								isHovered.
								aColor} ] ]
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

{ #category : #assertions }
GtThemeExamples >> constantColorRoles [
	^ #(#(default #(defaultShadowColor primaryShadowColor primaryBorderColor darkBorderColor newsBackgroundColor lightBorderColor expandCollapseTriangleBackgroundColor shadowColor)) #(header #(defaultBackgroundColor textMarkupColor disabledTextColor defaultTextColor secondaryBackgroundColor)) #(button #(disabledBackgroundColor defaultBackground disabledTextColor pressedBorderColor defaultBorderColor defaultTextColor hoveredBorderColor pressedTextColor hoveredTextColor textHighlightColor fadedBackgroundColor focusedFadedBackgroundColor disabledBorderColor)) #(editor #(pharoDeclaredVariableForeground pharoUndeclaredVariableForeground pharoSelfVariableForeground pharoSuperVariableForeground pharoThisContextVariableForeground pharoPragmaForeground pharoReturnArrowForeground pharoStringLiteralForeground pharoSymbolLiteralForeground pharoNumberLiteralForeground pharoNilLiteralForeground pharoBooleanLiteralForeground pharoCharacterLiteralForeground pharoCommentForeground pharoErrorTokenForeground borderColor focusedBorderColor)) #(item #(selectedColor deselectedColor hoveredColor defaultColor focusedBorderColor pressedColor)) #(status #(successBackgroundColor successBorderColor neutralBackgroundColor errorBorderColor errorBackgroundColor failureBorderColor paleErrorBackgroundColor failureBackgroundColor changesBackgroundColor)) #(link #(color errorColor)) #(columnedList #(headerBackgroundColor sortableHeaderHoveredBackgroundColor)) #(diffElement #(deletedLineBackgroundColor deletedTextBackgroundColor addedLineBackgroundColor addedTextBackgroundColor unchangedSideBackgroundColor connectorBackgroundColor borderColor editorBorderColor editorBackgroundColor selectedBorderColor labelForegroundColor)))
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
							aTheme button fadedBackgroundColor blocResolveColorForTheme: aTheme} ].
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
