Class {
	#name : #GtDarkThemeExamples,
	#superclass : #GtThemeExamples,
	#category : #'GToolkit-World-Examples'
}

{ #category : #examples }
GtDarkThemeExamples >> customizedThemeableColorsAfterThemeModified [
	<gtExample>
	<return: #BrGlamorousDarkTheme>
	| aTheme aColor |
	aTheme := BrGlamorousDarkTheme new.
	aColor := BrAntColors cyan3.
	aTheme status neutralBackgroundColor: aColor.
	aTheme link color: aColor.
	aTheme item hoveredColor: aColor.
	aTheme default primaryShadowColor: aColor.
	aTheme themeModified.
	{aTheme status neutralBackgroundColor.
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
		assertLepiterPageBackground: (Color fromHexString: '#262626')
		snippetForeground: (Color fromHexString: '#EAEAEA')
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

{ #category : #examples }
GtDarkThemeExamples >> methodCoderCompletionColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderCompletionColorsWithTheme: BrGlamorousDarkTheme new
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
