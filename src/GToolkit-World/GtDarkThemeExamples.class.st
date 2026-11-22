Class {
	#name : #GtDarkThemeExamples,
	#superclass : #GtThemeExamples,
	#category : #'GToolkit-World-Examples'
}

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
				block: [ :anElement | anElement theme: aTheme ] ].
	self
		assertLepiterPageBackground: (Color fromHexString: '#262626')
		snippetForeground: (Color fromHexString: '#EAEAEA')
		in: aScripter.
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
