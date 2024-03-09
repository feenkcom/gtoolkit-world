Extension { #name : #AssertionFailure }

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtDebuggingExtensionConfiguration [
	^ super gtDebuggingExtensionConfiguration
		enableDebuggingViewExtension: [ self gtIsStringComparison or: [ self gtScripter isNotNil ] ] 
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtIsStringComparison [
	| assertionContext actualValue expectedValue |
	self gtHasStack ifFalse: [ ^ false ].
	
	assertionContext := self signalerContext findContextSuchThat: [ :ctx | 
		   (ctx hasTemporaryVariableNamed: #actual) and: [ 
			   ctx hasTemporaryVariableNamed: #expected ] ].
	assertionContext ifNil: [ ^ false ].
	
	actualValue := assertionContext readVariableNamed: #actual.
	expectedValue := assertionContext readVariableNamed: #expected.
	^ actualValue isString and: [expectedValue isString].
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtLocateAssertEqualsContextWithComparableTypes [
	| assertionContext anActual anExpected |
	assertionContext := self signalerContext findContextSuchThat: [ :ctx | 
		   (ctx hasTemporaryVariableNamed: #actual) and: [ 
			   ctx hasTemporaryVariableNamed: #expected ] ].
	assertionContext ifNil: [ ^ nil ].
	
	anActual := assertionContext readVariableNamed: #actual.
	anExpected := assertionContext readVariableNamed: #expected.
	anActual isString ifFalse: [ ^ nil ].
	anExpected isString ifFalse: [ ^ nil ].
	
	^ assertionContext
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtScripterPreviewFor: aView [
	<gtView>
	<gtExceptionDebuggingView>
	| aScripter |
	
	self gtHasStack ifFalse: [ ^ aView empty ].
	aScripter := self gtScripter.
	aScripter ifNil: [
		^ aView empty ].

	^ aView forward
		title: 'Scripter preview';
		priority: 0;
		object: [ aScripter ];
		view: #gtSpaceFor:;
		actionButtonIcon: BrGlamorousIcons inspect 
			label: 'Scripter'
			tooltip: 'Inspect Scripter'
			action: [ :anElement | anElement phlow spawnObject: aScripter ]
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtScripterStepsFor: aView [
	<gtView>
	<gtExceptionDebuggingView>
	| aScripter |
	self gtHasStack ifFalse: [ ^ aView empty ].
	aScripter := self gtScripter.
	aScripter ifNil: [ ^ aView empty ].

	^ (aScripter gtStepsMondrianTreeFor: aView)
		title: 'Scripter steps';
		priority: -1;
		actionButtonIcon: BrGlamorousIcons inspect
			label: 'Scripter'
			tooltip: 'Inspect Scripter'
			action: [ :anElement | anElement phlow spawnObject: aScripter ]
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtTwoPanesStringDiffFor: aView [
	<gtView>
	<gtExceptionDebuggingView>
	| assertionContext |
	
	self gtHasStack ifFalse: [ ^ aView empty ].
	assertionContext := self gtLocateAssertEqualsContextWithComparableTypes.
	assertionContext ifNil: [
		^ aView empty ].

	^ aView forward
		title: 'Diff';
		priority: 0;
		object: [ assertionContext ];
		view: #gtTwoPanesStringDiffFor:
]
