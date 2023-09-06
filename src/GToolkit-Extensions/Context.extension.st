Extension { #name : #Context }

{ #category : #'*GToolkit-Extensions' }
Context >> gtIsAssertionContextWithComparableTypes [
	| anActual anExpected |
	(self hasTemporaryVariableNamed: #actual) ifFalse: [ ^ false ].
	(self hasTemporaryVariableNamed: #expected) ifFalse: [ ^ false ].

	anActual := self readVariableNamed: #actual.
	anExpected := self readVariableNamed: #expected.
	anActual isString ifFalse: [ ^ false ].
	anExpected isString ifFalse: [ ^ false ].
	
	^ true
]

{ #category : #'*GToolkit-Extensions' }
Context >> gtTwoPanesStringDiffFor: aView [
	<gtView>
	<gtContextDebuggingView>
	self gtIsAssertionContextWithComparableTypes ifFalse: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Diff';
		priority: 8;
		stencil: [ GtDiffElementWithLabelStencil new
				fromLabelText: 'Actual:';
				toLabelText: 'Expected:';
				change: (GtDiffBuilder
						computeDifferencesFrom: (self 
							readVariableNamed: #actual) asString
						to: (self readVariableNamed: #expected) asString
						using: GtCharacterGroupDiffSplitter words) ]
]
