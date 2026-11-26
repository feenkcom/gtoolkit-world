Class {
	#name : #GtLightThemeExamples,
	#superclass : #GtThemeExamples,
	#category : #'GToolkit-World-Examples'
}

{ #category : #examples }
GtLightThemeExamples >> baselinePackageExpanderBackground [
	<gtExample>
	<return: #BlScripter>
	^ self baselinePackageExpanderBackgroundWithTheme: BrGlamorousLightTheme new
]

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

{ #category : #examples }
GtLightThemeExamples >> lepiterEvaluatedMetaColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterEvaluatedMetaColorsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtLightThemeExamples >> lepiterEvaluatedRawIconColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterEvaluatedRawIconsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtLightThemeExamples >> lepiterInspectorSnippetsTableColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterInspectorSnippetsTableColorsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtLightThemeExamples >> lepiterPageBindingsTableColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterBindingsTableColorsIn: aScripter.
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
				block: [ :anElement | 
					anElement
						theme: aTheme;
						background: aTheme default appBackground ] ].
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

{ #category : #examples }
GtLightThemeExamples >> lepiterPharoSnippetExpanderColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterPharoSnippetExpanderColorsIn: aScripter.
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

{ #category : #examples }
GtLightThemeExamples >> lepiterTreePagerConfigurationColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertLepiterTreePagerConfigurationColorsIn: aScripter.
	^ aScripter
]

{ #category : #examples }
GtLightThemeExamples >> methodCoderCompletionColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderCompletionColorsWithTheme: BrGlamorousLightTheme new
]

{ #category : #examples }
GtLightThemeExamples >> methodCoderDeprecationColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderDeprecationColorsWithTheme: BrGlamorousLightTheme new
]

{ #category : #examples }
GtLightThemeExamples >> methodCoderDynamicHighlightColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderDynamicHighlightColorsWithTheme: BrGlamorousLightTheme new
]

{ #category : #examples }
GtLightThemeExamples >> methodCoderExampleStatusColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderExampleStatusColorsWithTheme: BrGlamorousLightTheme new
]

{ #category : #examples }
GtLightThemeExamples >> methodCoderTimeLimitColors [
	<gtExample>
	<return: #BlScripter>
	^ self methodCoderTimeLimitColorsWithTheme: BrGlamorousLightTheme new
]

{ #category : #examples }
GtLightThemeExamples >> scripterSourceReferenceColors [
	<gtExample>
	<return: #BlScripter>
	^ self scripterSourceReferenceColorsWithTheme: BrGlamorousLightTheme new
]

{ #category : #examples }
GtLightThemeExamples >> worldCoderColors [
	<gtExample>
	<return: #BlScripter>
	^ self worldCoderWithTheme: BrGlamorousLightTheme new
]

{ #category : #examples }
GtLightThemeExamples >> worldSpotterColors [
	<gtExample>
	<return: #BlScripter>
	^ self worldSpotterWithTheme: BrGlamorousLightTheme new
]

{ #category : #examples }
GtLightThemeExamples >> worldTabColors [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self lepiterPageWithTextAndPharoSnippets.
	self assertWorldTabColorsIn: aScripter.
	^ aScripter
]
