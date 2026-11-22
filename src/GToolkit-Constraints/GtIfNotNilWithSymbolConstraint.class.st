"
I report feenk methods that pass a literal Symbol to the non-nil branch of ifNotNil: or a nil-check variant. GemStone requires a block argument, and blocks support clean debugger step-through. I inspect keyword positions in the AST so symbols passed only to ifNil: are not reported.
"
Class {
	#name : #GtIfNotNilWithSymbolConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #correction }
GtIfNotNilWithSymbolConstraint >> blockSourceForSelector: aSelector using: aVariableName [
	^ '[ :' , aVariableName , ' | ' , aVariableName , ' ' , aSelector , ' ]'
]

{ #category : #correction }
GtIfNotNilWithSymbolConstraint >> correctIssues [
	"Rewrite all current issues in the live image. Answer the methods selected before correction."

	| methods |
	methods := self issues.
	methods
		do: [ :method | 
			method ast
				nodesDo: [ :node | 
					(node isMessage and: [ self messageUsesSymbolForIfNotNil: node ])
						ifTrue: [ | argument |
							argument := node arguments
									at: (node selector = #ifNil:ifNotNil: ifTrue: [ 2 ] ifFalse: [ 1 ]).
							argument value isUnary
								ifFalse: [ self
										error: 'Cannot convert non-unary selector ' , argument value printString , ' in '
												, method printString ] ] ] ].
	methods
		do: [ :method | 
			| variableName suffix definedVariables rewriter tree changed |
			definedVariables := method ast allDefinedVariables.
			variableName := 'v'.
			suffix := 0.
			[ definedVariables includes: variableName ]
				whileTrue: [ suffix := suffix + 1.
					variableName := 'v' , suffix asString ].
			rewriter := self correctionRewriterUsing: variableName.
			tree := RBParser parseMethod: method sourceCode.
			changed := false.
			[ rewriter executeTree: tree ]
				whileTrue: [ tree := rewriter tree.
					changed := true ].
			changed
				ifTrue: [ method methodClass compile: tree formattedCode classified: method protocol ] ].
	^ methods
]

{ #category : #correction }
GtIfNotNilWithSymbolConstraint >> correctionRewriterUsing: aVariableName [
	| rewriter |
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '`@receiver ifNil: `@nilBlock ifNotNil: `#selector'
			withValueFrom: [ :node | 
				RBParser
					parseExpression: '(' , node receiver formattedCode , ') ifNil: ('
							, node arguments first formattedCode , ') ifNotNil: '
							, (self blockSourceForSelector: node arguments second value using: aVariableName) ]
			when: [ :node | self messageUsesSymbolForIfNotNil: node ];
		replace: '`@receiver ifNotNil: `#selector ifNil: `@nilBlock'
			withValueFrom: [ :node | 
				RBParser
					parseExpression: '(' , node receiver formattedCode , ') ifNotNil: '
							, (self blockSourceForSelector: node arguments first value using: aVariableName)
							, ' ifNil: (' , node arguments second formattedCode , ')' ]
			when: [ :node | self messageUsesSymbolForIfNotNil: node ];
		replace: '`@receiver ifNotNil: `#selector'
			withValueFrom: [ :node | 
				RBParser
					parseExpression: '(' , node receiver formattedCode , ') ifNotNil: '
							, (self blockSourceForSelector: node arguments first value using: aVariableName) ]
			when: [ :node | self messageUsesSymbolForIfNotNil: node ].
	^ rewriter
]

{ #category : #accessing }
GtIfNotNilWithSymbolConstraint >> description [
	^ 'Pass a block to ifNotNil: and its variants. GemStone requires a block, and a block supports clean debugger step-through. Run GtIfNotNilWithSymbolConstraint new correctIssues to rewrite all reported methods in the live image.'
]

{ #category : #testing }
GtIfNotNilWithSymbolConstraint >> isIfNotNilSelector: aSelector [
	^ #(ifNotNil: ifNil:ifNotNil: ifNotNil:ifNil:) includes: aSelector
]

{ #category : #accessing }
GtIfNotNilWithSymbolConstraint >> issues [
	| found |
	found := Set new.
	Smalltalk
		allClassesAndTraitsDo: [ :aClass | 
			{aClass. aClass class} do: [ :behavior | 
					behavior methods do: [ :aMethod | 
						((aMethod messages anySatisfy: [ :selector | self isIfNotNilSelector: selector ])
								and: [ aMethod hasFeenkRepositoryAvailable
										and: [ self methodUsesSymbolForIfNotNil: aMethod ] ])
								ifTrue: [ found add: aMethod ] ] ] ].
	^ found asOrderedCollection sort: [ :a :b | a printString < b printString ]
]

{ #category : #testing }
GtIfNotNilWithSymbolConstraint >> messageUsesSymbolForIfNotNil: aMessageNode [
	| argumentIndex argument |
	(self isIfNotNilSelector: aMessageNode selector) ifFalse: [ ^ false ].
	argumentIndex := aMessageNode selector = #ifNil:ifNotNil:
			ifTrue: [ 2 ]
			ifFalse: [ 1 ].
	argument := aMessageNode arguments at: argumentIndex.
	^ argument isLiteralNode and: [ argument value isSymbol ]
]

{ #category : #testing }
GtIfNotNilWithSymbolConstraint >> methodUsesSymbolForIfNotNil: aMethod [
	aMethod ast
		nodesDo: [ :node | 
			(node isMessage and: [ self messageUsesSymbolForIfNotNil: node ])
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
GtIfNotNilWithSymbolConstraint >> name [
	^ 'Symbols passed to ifNotNil: in feenk methods'
]
