Class {
	#name : #GtMethodsWithUndeclaredVariablesConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #ignored }
GtMethodsWithUndeclaredVariablesConstraint >> calypsoMethods [
	<gtIgnoredMethods>
	^ {ClyClassWithUndeclares >> #method2WithUndeclares.
		ClyClassWithUndeclares >> #method1WithUndeclares}
]

{ #category : #accessing }
GtMethodsWithUndeclaredVariablesConstraint >> description [
	^ 'Methods should reference defined variables'
]

{ #category : #ui }
GtMethodsWithUndeclaredVariablesConstraint >> gtIssuesPerPackageFor: aView [
	<gtView>
	^ aView tree
		title: 'Issues per package';
		priority: 5;
		items: [ (self issues groupedBy: #package) associations
				sort: [ :a :b | a key name < b key name ] ];
		children: [ :anObject | (anObject isKindOf: Association) ifTrue: [ anObject value ] ifFalse: [ #() ] ];
		itemText: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ anObject key name asRopedText
						append: ((' {1} issues' format: {anObject value size}) asRopedText
								foreground: BrGlamorousColors disabledButtonTextColor) ]
				ifFalse: [ anObject ] ];
		send: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ anObject value size = 1
						ifTrue: [ anObject value first ]
						ifFalse: [ anObject value ] ]
				ifFalse: [ anObject ] ];
		actionUpdateButton
]

{ #category : #accessing }
GtMethodsWithUndeclaredVariablesConstraint >> ignoredMethods [
	| allPragmas |
	allPragmas := Pragma allNamed: #gtIgnoredMethods in: self class.
	^ allPragmas flatCollect: [ :aPragma | self perform: aPragma methodSelector ]
]

{ #category : #accessing }
GtMethodsWithUndeclaredVariablesConstraint >> ignoredVariableNames [
	| allPragmas |
	allPragmas := Pragma allNamed: #gtIgnoredVariables in: self class.
	^ allPragmas flatCollect: [ :aPragma | self perform: aPragma methodSelector ]
]

{ #category : #accessing }
GtMethodsWithUndeclaredVariablesConstraint >> issues [
	| allIgnoredMethods allIgnoredVariableNames |
	allIgnoredMethods := self ignoredMethods.
	allIgnoredVariableNames := self ignoredVariableNames.

	^ (Array
		streamContents: [ :aStream | 
			Smalltalk
				allClassesAndTraitsDo: [ :aClass | 
					aClass methods
						do: [ :aMethod | 
							(allIgnoredMethods includes: aMethod)
								ifFalse: [ (aMethod
										hasLiteralSuchThat: [ :each | 
											(each isKindOf: UndeclaredVariable)
												and: [ (allIgnoredVariableNames includes: each name) not ] ])
										ifTrue: [ aStream nextPut: aMethod ] ] ] ] ]) asSet
		asOrderedCollection sort: [ :a :b | a methodClass name < b methodClass name ]
]

{ #category : #accessing }
GtMethodsWithUndeclaredVariablesConstraint >> name [
	^ 'Methods with undeclared variables.'
]

{ #category : #accessing }
GtMethodsWithUndeclaredVariablesConstraint >> status [ 
	^ GtNeutralConstraintStatus new
]
