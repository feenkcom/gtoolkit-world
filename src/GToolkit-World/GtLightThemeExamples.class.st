Class {
	#name : #GtLightThemeExamples,
	#superclass : #GtThemeExamples,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - lepiter' }
GtLightThemeExamples >> hoverOverLepiterTextAndPharoSnippets [
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
GtLightThemeExamples >> lepiterBindingsButtonIconForeground [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterBindingsButtonIconForegroundIn: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtLightThemeExamples >> lepiterCompositeToolSwitcherColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterCompositeToolSwitcherColorsIn: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtLightThemeExamples >> lepiterPageTitleBackground [
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
GtLightThemeExamples >> lepiterPageWithExpandedActionsMenu [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	GtWorldByScripterExamples new openLepiterPageActionsMenuIn: aScripter.
	self assertLepiterPageActionsMenuColorsIn: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtLightThemeExamples >> lepiterPageWithTextAndPharoSnippets [
	<gtExample>
	<return: #BlScripter>
	| aWorldExamples aScripter aTheme |
	aWorldExamples := GtWorldByScripterExamples new.
	aScripter := aWorldExamples addLepiterPageWithTextAndPharoSnippets.
	aTheme := BrGlamorousLightTheme new.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Apply the light theme';
				block: [ :anElement | anElement theme: aTheme ] ].
	self
		assertLepiterPageBackground: Color white
		snippetForeground: Color black
		in: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtLightThemeExamples >> lepiterPaneToolbarButtonColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	GtWorldByScripterExamples new hoverOverLepiterPaneIn: aScripter.
	self assertTreePagerPaneButtonColorsIn: aScripter.
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtLightThemeExamples >> lepiterSnippetDecorationButtonBackgrounds [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterSnippetDecorationBackgroundsIn: aScripter.
	^ aScripter
]
