Extension { #name : #BaselineOf }

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtAllReferencesFor: aView [
	<gtView>
	<gtClassView>
	^ aView explicit
		title: 'References';
		tooltip: 'Class and baseline references';
		priority: 40;
		stencil: [
			| aName baselineCandidates |
			aName := self name withoutPrefix: BaselineOf name.

			baselineCandidates :=
				(aName gtReferences | aName asSymbol gtReferences)
					& (#baseline: gtReferences | #baseline:with: gtReferences).

			self gtReferences
				| (baselineCandidates select: [ :method |
					| found |
					found := false.
					method ast nodesDo: [ :node |
						found ifFalse: [
							found := node isMessage
								and: [
									(#(#baseline: #baseline:with:) includes: node selector)
										and: [
											node arguments first isLiteralNode
												and: [ node arguments first value asString = aName ] ] ] ] ].
					found ]) ]
]

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtDependencyAnalyzerFor: aView [
	<gtClassView>
	
	| anAnalyzer |
	^ aView explicit
		title: 'Dependency analysis';
		priority: 41;
		stencil: [ 
			| anObjectHolder |
			anAnalyzer := GtDependencyAnalyzerEasy analyzeBaseline: self.
			anObjectHolder := GtInspectorObject new object: anAnalyzer; viewSelector: #gtDirectlyDefinedPackagesFor:context:.
			GtInspector new objectHolder: anObjectHolder ];
		actionButtonIcon: BrGlamorousVectorIcons refresh 
			tooltip: 'Update dependency analysis' 
			action: [ :aButton :aTab | 
				aButton disable.
				[ aTab viewContentElement phlow syncUpdate ] asAsyncPromise 
					then: [ :aResult | aButton enable ] 
					otherwise: [ :anError | aButton enable ] ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect dependency analyzer' 
			action: [ :aButton | anAnalyzer ifNotNil: [ 
				aButton phlow spawnObject: anAnalyzer ] ]
]

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtViewAllExamplesFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'All examples';
		priority: 33;
		tooltip: 'Examples defined in packages contained in the baseline or in dependencies.';
		object: [
			GtRlSystemExamplesExplorer forProject: (self gtRlProjectWithRepository: '') ];
		view: #gtViewAllExamplesFor:context:
]

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtViewLocalExamplesFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'Local examples';
		priority: 30;
		tooltip: 'Examples defined in packages directly contained within the baseline.';
		object: [
			GtRlProjectExamplesExplorer forProject: (self gtRlProjectWithRepository: '') ];
		view: #gtViewExamplesFor:
]
