Extension { #name : #AssertionFailure }

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtDebuggingViewConfiguration [
	^ super gtDebuggingViewConfiguration
		enableDebuggingViewExtension: [ self gtIsStringComparison ] 
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
AssertionFailure >> gtTwoPanesStringDiffFor: aView [
	<gtView>
	<gtExceptionDebuggingView>
	| assertionContext anActual anExpected |
	self gtHasStack ifFalse: [ ^ aView empty ].
	
	assertionContext := self signalerContext findContextSuchThat: [ :ctx | 
		   (ctx hasTemporaryVariableNamed: #actual) and: [ 
			   ctx hasTemporaryVariableNamed: #expected ] ].
	assertionContext ifNil: [ ^ aView empty ].
	
	anActual := assertionContext readVariableNamed: #actual.
	anExpected := assertionContext readVariableNamed: #expected.
	anActual isString ifFalse: [ ^ aView empty ].
	anExpected isString ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Diff';
		priority: 0;
		stencil: [
			GtDiffElementWithLabelStencil new
				fromLabelText: 'Actual:';
				toLabelText: 'Expected:';
				change: (GtDiffBuilder
						computeDifferencesFrom: (anActual asString)
						to: (anExpected asString)
						using: GtCharacterGroupDiffSplitter words) ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect the comparator' 
			action: [ :aButton |
				aButton phlow 
					spawnObject: ((GtDiffBuilder
						computeDifferencesFrom: (anActual asString)
						to: (anExpected asString)
						using: GtCharacterGroupDiffSplitter words)) ]
]
