Extension { #name : #BaselineOfGToolkit }

{ #category : #'*GToolkit-World' }
BaselineOfGToolkit class >> gtDependenciesGraphFor: aView [
	^ aView mondrian
		title: 'GT dependencies';
		priority: 10;
		painting: [ :mondrian | 
			| repo builder rootProject projectPrefixes |
			repo := 'github://feenkcom/gtoolkit:main/src'.
			builder := GtRlDependenciesModelBuilder new.
			rootProject := builder
					buildProjectFromBaselineClass: BaselineOfGToolkit
					withRepositoryDescription: repo.
			projectPrefixes := {'GToolkit'.
					'Gt'.
					'Xdoc'.
					'Bloc'.
					'Brick'.
					'Sparta'.
					'Lepiter'.
					'Glutin'}.
			rootProject
				paintProjectDependenciesSelectingRelationsThat: [ :a :b | projectPrefixes anySatisfy: [ :prefix | a name beginsWith: prefix ] ]
				labelledAs: [ :aProject | 
					aProject name asRopedText
						foreground: ((projectPrefixes anySatisfy: [ :prefix | aProject name beginsWith: prefix ])
								ifTrue: [ BrGlamorousColors linkColor ]
								ifFalse: [ Color gray ]) ]
				with: mondrian ]
]
