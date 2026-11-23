"
I provide shared theme assertions for World scenarios.
"
Class {
	#name : #GtThemeExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

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
