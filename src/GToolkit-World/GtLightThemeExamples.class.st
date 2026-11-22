Class {
	#name : #GtLightThemeExamples,
	#superclass : #Object,
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
			aWorldExamples
				assertLepiterSnippetBackground: aBackgroundColor
				shadowColor: aShadowColor
				of: aSnippetClass
				in: aScripter ].
	^ aScripter
]

{ #category : #'examples - lepiter' }
GtLightThemeExamples >> lepiterPageTitleBackground [
	<gtExample>
	<return: #BlScripter>
	| aScripter aTheme |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	aTheme := aScripter element theme.
	GtWorldByScripterExamples new
		assertLepiterPageTitleBackground: (aTheme default contentBackground blocResolveColorForTheme: aTheme)
		in: aScripter.
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
	aWorldExamples
		assertLepiterPageBackground: Color white
		snippetForeground: Color black
		in: aScripter.
	^ aScripter
]
