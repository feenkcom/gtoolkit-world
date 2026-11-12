"
World examples using BrGlamorousNearWhiteTheme, reusing the standard World scenarios.
"
Class {
	#name : #GtWorldWithWhiteThemeByScripterExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - appearance' }
GtWorldWithWhiteThemeByScripterExamples >> addLepiterPageHavingWardleyMapSnippetWithNearWhiteCanvas [
	<gtExample>
	<return: #BlScripter>
	^ self
		applyNearWhiteCanvasTo: GtWorldByScripterExamples new addLepiterPageHavingWardleyMapSnippet
]

{ #category : #'private - appearance' }
GtWorldWithWhiteThemeByScripterExamples >> applyNearWhiteCanvasTo: aScripter [
	| aTheme |
	aTheme := self nearWhiteCanvasTheme.
	aScripter
		substep: 'Apply near-white canvas with white panes'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Apply near-white theme';
						block: [ :anElement | anElement theme: aTheme ] ] ].
	^ aScripter
]

{ #category : #'examples - appearance' }
GtWorldWithWhiteThemeByScripterExamples >> nearWhiteCanvasTheme [
	<gtExample>
	<return: #BrGlamorousNearWhiteTheme>
	| aTheme |
	aTheme := BrGlamorousNearWhiteTheme new.
	self
		assert: aTheme default backdropBackground rawColor
		equals: (Color fromHexString: '#FAFAFA').
	self assert: aTheme default appBackground rawColor equals: Color white.
	self assert: aTheme default contentBackground rawColor equals: Color white.
	self assert: aTheme class canBeDefault not.
	^ aTheme
]

{ #category : #'examples - appearance' }
GtWorldWithWhiteThemeByScripterExamples >> selectClassInSecondPaneWithNearWhiteCanvas [
	<gtExample>
	<return: #BlScripter>
	^ self
		applyNearWhiteCanvasTo: GtWorldByScripterExamples new selectClassInSecondPane
]

{ #category : #'examples - appearance' }
GtWorldWithWhiteThemeByScripterExamples >> worldElementInScripter [
	<gtExample>
	<return: #BlScripter>
	^ self
		applyNearWhiteCanvasTo: GtWorldByScripterExamples new worldElementInScripter
]
