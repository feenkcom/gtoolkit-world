"
I provide shared theme assertions for World scenarios.
"
Class {
	#name : #GtThemeExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

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
				value: [ :aGlyph | self resolvedForegroundOfLepiterGlyph: aGlyph ]
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
							self resolvedForegroundOfLepiterGlyph: aGlyph} ]
					equals: {aForeground.
							aForeground} ]
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
				value: [ :aContainer | aContainer effect color ] equals: aShadowColor ]
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

{ #category : #'asserting - theme' }
GtThemeExamples >> resolvedForegroundOfLepiterGlyph: aGlyph [
	| aForeground |
	aForeground := (aGlyph text attributesAt: 1)
			detect: [ :anAttribute | anAttribute isKindOf: BlTextForegroundAttribute ]
			ifNone: [ nil ].
	^ aForeground
		ifNil: [ Color black ]
		ifNotNil: [ aForeground paint blocResolveColorForTheme: aGlyph theme ]
]
