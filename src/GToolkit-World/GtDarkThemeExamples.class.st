Class {
	#name : #GtDarkThemeExamples,
	#superclass : #GtThemeExamples,
	#category : #'GToolkit-World-Examples'
}

{ #category : #examples }
GtDarkThemeExamples >> baselinePackageExpanderBackground [
	<gtExample>
	<return: #BlScripter>
	^ self baselinePackageExpanderBackgroundWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> baselinePackageOccurrenceHighlight [
	<gtExample>
	<return: #BlScripter>
	^ self baselinePackageOccurrenceHighlightWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> classDefinitionHistoryDiffColors [
	<gtExample>
	<return: #BlScripter>
	| aTheme aHistory aPreviousHistory aDiff aScripter anExpectedColor anExample |
	aTheme := BrGlamorousDarkTheme new.
	aPreviousHistory := GtLVariableChangeHistoryExamples new classDefinitionHistory.
	aHistory := GtLClassDefinitionChangeHistory new
			targetClassName: aPreviousHistory targetClassName;
			addChange: aPreviousHistory latestChange;
			yourself.
	aDiff := (aHistory gtDiffFor: GtPhlowView empty)
			asElementDo: [ :anElement | anElement ].
	self assert: aDiff leftStyler class equals: GtPharoStyler.
	self assert: aDiff rightStyler class equals: GtPharoStyler.
	self assert: aDiff leftStyler ~~ aDiff rightStyler.
	aScripter := BlScripter new
			element: (BrVerticalPane new
					theme: aTheme;
					background: aTheme default contentBackground;
					addChild: aDiff;
					yourself).
	anExpectedColor := aTheme editor pharoStringLiteralForeground rawColor.
	{GtDiffOldTextId.
		GtDiffNewTextId}
		do: [ :anId | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the class-definition string foreground';
						// anId;
						value: [ :anEditor | 
								| aText anIndex aForeground |
								aText := anEditor text.
								anIndex := aText asString findString: 'first'.
								aForeground := (aText attributesAt: anIndex)
										detect: [ :each | each isKindOf: BlTextForegroundAttribute ].
								aForeground paint blocResolveColorForTheme: anEditor theme ]
							equals: anExpectedColor ] ].
	anExample := GtDiffElementThemeExamples new.
	anExample
		assertFragment: '""'
			in: GtDiffOldTextId
			resolvedColor: aTheme diffElement deletedTextBackgroundColor rawColor
			scripter: aScripter;
		assertFragment: 'A commented class'
			in: GtDiffNewTextId
			resolvedColor: aTheme diffElement addedTextBackgroundColor rawColor
			scripter: aScripter.
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> customizedThemeableColorsAfterThemeModified [
	<gtExample>
	<return: #BrGlamorousDarkTheme>
	| aTheme aColor |
	aTheme := BrGlamorousDarkTheme new.
	aColor := BrAntColors cyan3.
	aTheme status neutralBackgroundColor: aColor.
	aTheme status neutralBorderColor: aColor.
	aTheme link color: aColor.
	aTheme item hoveredColor: aColor.
	aTheme default primaryShadowColor: aColor.
	aTheme themeModified.
	{aTheme status neutralBackgroundColor.
		aTheme status neutralBorderColor.
		aTheme link color.
		aTheme item hoveredColor.
		aTheme default primaryShadowColor}
		do: [ :aPaint | 
			self assert: (aPaint isKindOf: BlThemeableColor).
			self assert: aPaint rawColor equals: aColor ].
	^ aTheme
]

{ #category : #examples }
GtDarkThemeExamples >> derivedThemeableColors [
	<gtExample>
	<return: #BlThemeableColor>
	| aDarkTheme aLightTheme aPaint aResolvedPaint |
	aDarkTheme := BrGlamorousDarkTheme new.
	aLightTheme := BrGlamorousLightTheme new.
	aPaint := aLightTheme status neutralBackgroundColor darker alpha: 0.5.
	aResolvedPaint := aPaint blocResolveForTheme: aDarkTheme.
	self
		assert: aResolvedPaint rawColor
		equals: ((aDarkTheme status constantAt: #neutralBackgroundColor) darker alpha: 0.5).
	self
		assert: (aResolvedPaint blocResolveColorForTheme: aLightTheme)
		equals: ((aLightTheme status constantAt: #neutralBackgroundColor) darker alpha: 0.5).
	^ aResolvedPaint
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> focusLepiterTextSnippetWithCustomPrimaryShadowColor [
	<gtExample>
	<return: #BlScripter>
	| aScripter aTheme aShadowColor |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	aTheme := aScripter element theme.
	aShadowColor := Color magenta.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Set the primary shadow color';
				block: [ :anElement | 
					anElement theme default primaryShadowColor: aShadowColor.
					anElement theme themeModified ] ].
	aScripter
		clickStep: [ :aStep | 
			aStep
				label: 'Focus the text snippet';
				// LeTextCoderSnippetElement ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check that the text snippet is focused';
				// LeTextCoderSnippetElement;
				value: [ :aSnippet | aSnippet states hasState: BlElementState focused ]
					equals: true ].
	self
		assertLepiterSnippetBackground: (aTheme default contentBackground
				blocResolveColorForTheme: aTheme)
		shadowColor: aShadowColor
		of: LeTextCoderSnippetElement
		in: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> hoverOverLepiterTextAndPharoSnippets [
	<gtExample>
	<return: #BlScripter>
	| aWorldExamples aScripter aTheme aBackgroundColor aShadowColor |
	aWorldExamples := GtWorldByScripterExamples new.
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	aTheme := aScripter element theme.
	aBackgroundColor := aTheme default contentBackground
			blocResolveColorForTheme: aTheme.
	aShadowColor := aTheme default defaultShadowColor.
	aWorldExamples
		hoverOverLepiterSnippetsIn: aScripter
		afterEach: [ :aSnippetClass | 
			self
				assertLepiterSnippetBackground: aBackgroundColor
				shadowColor: aShadowColor
				of: aSnippetClass
				in: aScripter ].
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> iceNodeMethodDiffColors [
	<gtExample>
	<return: #BlScripter>
	| aTheme aBefore anAfter aNode aDiff aScripter |
	aTheme := BrGlamorousDarkTheme new.
	aBefore := IceMethodDefinition
			className: self class name
			classIsMeta: false
			protocol: 'examples'
			name: #sampleMethod
			sourceCode: 'sampleMethod
	^ 1'.
	anAfter := aBefore copy
			sourceCode: 'sampleMethod
	^ 2'.
	aNode := IceNode value: (IceModification left: anAfter right: aBefore).
	aDiff := (aNode gtViewTwoPanesDiffFor: GtPhlowView empty)
			asElementDo: [ :anElement | anElement ].
	aScripter := BlScripter new
			element: (BrVerticalPane new
					theme: aTheme;
					background: aTheme default contentBackground;
					addChild: aDiff;
					yourself).
	{GtDiffOldTextId -> '1'.
		GtDiffNewTextId -> '2'}
		do: [ :aSide | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the method selector and literal styling';
						// aSide key;
						value: [ :anEditor | 
								| aText aForeground |
								aText := anEditor text.
								aForeground := (aText
										attributesAt: (aText asString findString: aSide value))
										detect: [ :each | each isKindOf: BlTextForegroundAttribute ].
								{(aText attributesAt: (aText asString findString: 'sampleMethod'))
										anySatisfy: [ :each | each isKindOf: BlFontWeightAttribute ].
									aForeground paint blocResolveColorForTheme: anEditor theme} ]
							equals: {true.
									aTheme editor pharoNumberLiteralForeground rawColor} ] ].
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterBindingsButtonIconForeground [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterBindingsButtonIconForegroundIn: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterCompositeToolSwitcherColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterCompositeToolSwitcherColorsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> lepiterEvaluatedMetaColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterEvaluatedMetaColorsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> lepiterEvaluatedRawIconColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterEvaluatedRawIconsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> lepiterInspectorSnippetsTableColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterInspectorSnippetsTableColorsIn: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterMaximizedPaneDropdownShadows [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPaneToolbarButtonColors.
	aScripter
		clickStep: [ :aStep | 
			aStep
				label: 'Maximize the Lepiter pane';
				// #'tree-pager--maximize-pane-button' ].
	self
		assertPaneDropdownShadowsIn: aScripter
		triggerId: #'tree-pager--maximized-dropdown-menu-button'.
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> lepiterPageBindingsTableColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterBindingsTableColorsIn: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterPageTitleBackground [
	<gtExample>
	<return: #BlScripter>
	| aScripter aTheme |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	aTheme := aScripter element theme.
	self
		assertLepiterPageTitleBackground: (aTheme default contentBackground blocResolveColorForTheme: aTheme)
		in: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterPageWithExpandedActionsMenu [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	GtWorldByScripterExamples new openLepiterPageActionsMenuIn: aScripter.
	self assertLepiterPageActionsMenuColorsIn: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterPageWithTextAndPharoSnippets [
	<gtExample>
	<return: #BlScripter>
	| aWorldExamples aScripter aTheme |
	aWorldExamples := GtWorldByScripterExamples new.
	aScripter := aWorldExamples addLepiterPageWithTextAndPharoSnippets.
	aTheme := BrGlamorousDarkTheme new.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Apply the dark theme';
				block: [ :anElement | 
					anElement
						theme: aTheme;
						background: aTheme default appBackground ] ].
	self
		assertLepiterPageBackground: (aTheme default contentBackground
				blocResolveColorForTheme: aTheme)
		snippetForeground: aTheme editor defaultTextForeground rawColor
		in: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterPaneDropdownShadows [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPaneToolbarButtonColors.
	self
		assertPaneDropdownShadowsIn: aScripter
		triggerId: #'tree-pager--dropdown-menu-button'.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterPaneToolbarButtonColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	GtWorldByScripterExamples new hoverOverLepiterPaneIn: aScripter.
	self assertTreePagerPaneButtonColorsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> lepiterPharoSnippetExpanderColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterPharoSnippetExpanderColorsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> lepiterPharoSyntaxForegroundContrast [
	<gtExample>
	<return: #BlScripter>
	| aScripter aTheme anEditorTheme aBackground |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	aTheme := aScripter element theme.
	anEditorTheme := aTheme editor.
	aBackground := aTheme default contentBackground
			blocResolveColorForTheme: aTheme.
	#(pharoDeclaredVariableForeground pharoUndeclaredVariableForeground pharoSelfVariableForeground pharoSuperVariableForeground pharoThisContextVariableForeground pharoPragmaForeground pharoReturnArrowForeground pharoStringLiteralForeground pharoSymbolLiteralForeground pharoNumberLiteralForeground pharoNilLiteralForeground pharoBooleanLiteralForeground pharoCharacterLiteralForeground pharoCommentForeground pharoErrorTokenForeground)
		do: [ :aSelector | 
			| aColor |
			aColor := (anEditorTheme perform: aSelector) blocResolveColorForTheme: aTheme.
			self
				assert: (aColor isContrastCompliantForWCAG2AA: aBackground)
				description: aSelector ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the number literal in the Pharo snippet';
				// LePharoSnippetElement;
				// BrTextElementWithCursors;
				@ [ :anElement | anElement text asString beginsWith: '42' ];
				value: [ :anElement | self resolvedTextForegroundOf: anElement ]
					equals: (anEditorTheme pharoNumberLiteralForeground blocResolveColorForTheme: aTheme) ].
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtDarkThemeExamples >> lepiterSnippetDecorationButtonBackgrounds [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterSnippetDecorationBackgroundsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> lepiterTreePagerConfigurationColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterTreePagerConfigurationColorsIn: aScripter.
	^ aScripter
]

{ #category : #magritte }
GtDarkThemeExamples >> magritteActionColors [
	<gtExample>
	<return: #BlScripter>
	^ self magritteActionColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #magritte }
GtDarkThemeExamples >> magritteReadOnlyEditorColors [
	<gtExample>
	<return: #BlScripter>
	^ self magritteReadOnlyEditorColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #magritte }
GtDarkThemeExamples >> magritteValidationColors [
	<gtExample>
	<return: #BlScripter>
	^ self magritteValidationColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderClassExpanderBackground [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderClassExpanderBackgroundWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderCompletionColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderCompletionColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderDefineClassPreviewBackground [
	<gtExample>
	<return: #BlScripter>
	^ self
		methodCoderDefineClassPreviewBackgroundWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderDeprecationColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderDeprecationColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderDynamicHighlightColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderDynamicHighlightColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderEvaluationMarkerColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderEvaluationMarkerColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderExampleStatusColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderExampleStatusColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderFoldableTextHighlight [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderFoldableTextHighlightWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderParenthesesHighlight [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderParenthesesHighlightWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderPrintResultColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderPrintResultColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderPrintResultMenuButtonColors [
	<gtExample>
	<return: #BlScripter>
	^ self
		methodCoderPrintResultMenuButtonColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderPrintResultTooltipColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderPrintResultTooltipColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderSyntaxErrorColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderSyntaxErrorColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodCoderTimeLimitColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderTimeLimitColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> methodHistoryDiffColors [
	<gtExample>
	<return: #BlScripter>
	| aTheme aResult aHistory aDiff aScripter |
	aTheme := BrGlamorousDarkTheme new.
	aResult := GtLMethodCompilationResultExamples new
			methodCompilationResultCreation.
	aHistory := GtLMethodChangeHistory new
			methodReference: aResult targetMethodReference;
			addChange: (GtLSummarizerCodeChange new
					changeResult: aResult;
					yourself);
			yourself.
	aDiff := (aHistory gtDiffFor: GtPhlowView empty)
			asElementDo: [ :anElement | anElement ].
	aScripter := BlScripter new
			element: (BrVerticalPane new
					theme: aTheme;
					background: aTheme default contentBackground;
					addChild: aDiff;
					yourself).
	{GtDiffOldTextId -> '1'.
		GtDiffNewTextId -> '2'}
		do: [ :aSide | 
			aScripter
				checkStep: [ :aStep | 
					aStep
						label: 'Check the method selector and literal styling';
						// aSide key;
						value: [ :anEditor | 
								| aText aForeground |
								aText := anEditor text.
								aForeground := (aText
										attributesAt: (aText asString findString: aSide value))
										detect: [ :each | each isKindOf: BlTextForegroundAttribute ].
								{(aText attributesAt: (aText asString findString: 'sampleMethod'))
										anySatisfy: [ :each | each isKindOf: BlFontWeightAttribute ].
									aForeground paint blocResolveColorForTheme: anEditor theme} ]
							equals: {true.
									aTheme editor pharoNumberLiteralForeground rawColor} ] ].
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> notificationBadgeAndCardColors [
	<gtExample>
	<return: #BlScripter>
	^ self
		notificationBadgeAndCardColorsWithTheme: BrGlamorousDarkTheme new
		switchingTo: BrGlamorousLightTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> scripterSourceReferenceColors [
	<gtExample>
	<return: #BlScripter>
	^ self scripterSourceReferenceColorsWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> themeableColorRoles [
	<gtExample>
	<return: #BrGlamorousDarkTheme>
	| aDarkTheme aLightTheme aNearWhiteTheme |
	aDarkTheme := BrGlamorousDarkTheme new.
	aLightTheme := BrGlamorousLightTheme new.
	aNearWhiteTheme := BrGlamorousNearWhiteTheme new.
	self constantColorRoles
		do: [ :aGroup | 
			| aThemeSelector someRoles |
			aThemeSelector := aGroup first.
			someRoles := aGroup second.
			{aDarkTheme.
				aLightTheme.
				aNearWhiteTheme}
				do: [ :aTheme | 
					| aSubTheme |
					aSubTheme := aTheme perform: aThemeSelector.
					someRoles
						do: [ :aRole | 
							| aPaint aColor aTargetTheme aTarget |
							aPaint := aSubTheme perform: aRole.
							aColor := aSubTheme constantAt: aRole.
							self assert: (aColor isKindOf: Color) description: aRole.
							self assert: (aPaint isKindOf: BlThemeableColor) description: aRole.
							self assert: aPaint rawColor equals: aColor.
							aTargetTheme := aTheme == aDarkTheme
									ifTrue: [ aLightTheme ]
									ifFalse: [ aDarkTheme ].
							aTarget := aTargetTheme perform: aThemeSelector.
							self
								assert: (aPaint blocResolveColorForTheme: aTargetTheme)
								equals: (aTarget constantAt: aRole) ] ] ].
	^ aDarkTheme
]

{ #category : #examples }
GtDarkThemeExamples >> themeableDistinctColorPalettes [
	<gtExample>
	<return: #BrGlamorousDarkTheme>
	| aTheme aLightTheme |
	aTheme := BrGlamorousDarkTheme new.
	aLightTheme := BrGlamorousLightTheme new.
	#(distinctTenStrongColors distinctTenLightColors)
		do: [ :aSelector | 
			| aPaints aColors someLightColors |
			aPaints := aTheme default perform: aSelector.
			aColors := aTheme default constantAt: aSelector.
			someLightColors := aLightTheme default constantAt: aSelector.
			self
				assert: (aPaints allSatisfy: [ :aPaint | aPaint isKindOf: BlThemeableColor ]).
			self assert: (aPaints collect: #rawColor) equals: aColors.
			self
				assert: (aPaints collect: [ :aPaint | aPaint blocResolveColorForTheme: aLightTheme ])
				equals: someLightColors ].
	^ aTheme
]

{ #category : #examples }
GtDarkThemeExamples >> worldCoderColors [
	<gtExample>
	<return: #BlScripter>
	^ self worldCoderWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> worldInspectorTabIconColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter aTheme aForeground |
	aScripter := GtWorldByScripterExamples new worldTabFromInspectorOpenOn.
	aTheme := BrGlamorousDarkTheme new.
	aForeground := aTheme label defaultTextForeground
			blocResolveColorForTheme: aTheme.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Apply the dark theme to the world';
				block: [ :aWorld | aWorld theme: aTheme ] ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the Inspector tab icon fill';
				// GtWorldTabGroupId;
				value: [ :aGroup | 
						| anIcon |
						anIcon := aGroup tabs second widget childNamed: #icon.
						anIcon background paint color blocResolveColorForTheme: anIcon theme ]
					equals: aForeground ].
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Replace the Inspector tab icon';
				// GtWorldTabGroupId;
				block: [ :aGroup | aGroup tabs second widget icon: BrGlamorousVectorIcons emphasizedInspect ] ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the replacement icon fill and stroke';
				// GtWorldTabGroupId;
				value: [ :aGroup | 
						| anIcon |
						anIcon := aGroup tabs second widget childNamed: #icon.
						{anIcon background paint color blocResolveColorForTheme: anIcon theme.
							anIcon border paint color blocResolveColorForTheme: anIcon theme} ]
					equals: {aForeground.
							aForeground} ].
	^ aScripter
]

{ #category : #examples }
GtDarkThemeExamples >> worldMenuIconColors [
	<gtExample>
	<return: #BlScripter>
	^ self
		worldMenuIconColorsWithTheme: BrGlamorousDarkTheme new
		switchingTo: BrGlamorousLightTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> worldSpotterColors [
	<gtExample>
	<return: #BlScripter>
	^ self worldSpotterWithTheme: BrGlamorousDarkTheme new
]

{ #category : #examples }
GtDarkThemeExamples >> worldTabColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertWorldTabColorsIn: aScripter.
	^ aScripter
]
