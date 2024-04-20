Extension { #name : #Context }

{ #category : #'*GToolkit-Extensions' }
Context >> gtIsAssertionContextWithComparableTypes [
	| anActual anExpected |
	(self hasTemporaryVariableNamed: #actual) ifFalse: [ ^ false ].
	(self hasTemporaryVariableNamed: #expected) ifFalse: [ ^ false ].

	anActual := self readVariableNamed: #actual.
	anExpected := self readVariableNamed: #expected.
	"anActual isString ifFalse: [ ^ false ].
	anExpected isString ifFalse: [ ^ false ]."
	
	^ true
]

{ #category : #'*GToolkit-Extensions' }
Context >> gtTwoPanesStringDiffFor: aView [
	<gtView>
	<gtContextDebuggingView>
	
	self gtIsAssertionContextWithComparableTypes ifFalse: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Textual Diff';
		priority: 8;
		stencil: [ GtDiffElementWithLabelStencil new
				fromLabelText: 'Actual:';
				toLabelText: 'Expected:';
				change: (GtDiffBuilder
						computeDifferencesFrom: (self 
							readVariableNamed: #actual) gtDebuggerPrintForComparison
						to: (self readVariableNamed: #expected) gtDebuggerPrintForComparison
						using: GtCharacterGroupDiffSplitter words) ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Actual'
			tooltip: 'Inspect actual object'
			action: [ :aButton | 
				aButton phlow 
					spawnObject: (self readVariableNamed: #actual) ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Expected'
			tooltip: 'Inspect expected object'
			action: [ :aButton | 
				aButton phlow 
					spawnObject: (self readVariableNamed: #expected) ]
			
]
