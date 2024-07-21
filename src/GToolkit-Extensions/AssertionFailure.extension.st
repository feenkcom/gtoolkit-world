Extension { #name : #AssertionFailure }

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtComparableTypesStateDiffFor: aView [
	<gtView>
	<gtExceptionView>
	| assertionContext |
	
	self gtHasStack ifFalse: [ ^ aView empty ].
	assertionContext := self gtLocateAssertEqualsContextWithComparableTypes.
	assertionContext ifNil: [
		^ aView empty ].

	^ aView explicit
		title: 'State Comparison';
		priority: 5;
		stencil: [ 
			GtDebuggerDiffObjectStateComparisonStencil new
				fromLabelText: 'Actual:';
				toLabelText: 'Expected:';
				fromValue: (assertionContext readVariableNamed: #actual);
				toValue: (assertionContext readVariableNamed: #expected) ]
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtComparableTypesTextualDiffFor: aView [
	<gtView>
	<gtExceptionView>
	<gtEmbeddedDebuggerView>
	| assertionContext |
	
	self gtHasStack ifFalse: [ ^ aView empty ].
	assertionContext := self gtLocateAssertEqualsContextWithComparableTypes.
	assertionContext ifNil: [
		^ aView empty ].

	^ aView forward
		title: 'Textual Diff';
		priority: 0;
		object: [ assertionContext ];
		view: #gtComparableTypesTextualDiffFor:
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtExceptionDebuggerSpecification [
	^ super gtExceptionDebuggerSpecification
		title: 'Assertion Failure';
		enableWhen: [ 
			self gtHasComparableTypes or: [ 
				self gtScripter isNotNil ] ] 
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtHasComparableTypes [
	| actualExpectedAssertionContext |
	self gtHasStack ifFalse: [ ^ false ].
	
	actualExpectedAssertionContext := self signalerContext findContextSuchThat: [ :ctx | 
		(ctx hasTemporaryVariableNamed: #actual) and: [ 
			ctx hasTemporaryVariableNamed: #expected ] ].
	^ actualExpectedAssertionContext notNil
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
	"anActual isString ifFalse: [ ^ nil ].
	anExpected isString ifFalse: [ ^ nil ]."
	
	^ assertionContext
]

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtScripterPreviewFor: aView [
	<gtView>
	<gtExceptionView>
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
	<gtExceptionView>
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
