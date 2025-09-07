Extension { #name : #BaselineOfGToolkit }

{ #category : #'*GToolkit-World' }
BaselineOfGToolkit class >> gtDependenciesGraphFor: aView [
	^ aView mondrian
		title: 'GT dependencies';
		priority: 10;
		painting: [ :mondrian | 
			| rootProject projectPrefixes |
			rootProject := GtRlDependenciesModelBuilder new
					buildProjectFromBaselineClass: BaselineOfGToolkit
					withRepositoryDescription: 'github://feenkcom/gtoolkit:main/src'.
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
					(aProject name copyReplaceAll: 'GToolkit' with: 'GT ') asRopedText
						foreground: ((projectPrefixes anySatisfy: [ :prefix | aProject name beginsWith: prefix ])
								ifTrue: [ BrGlamorousColors linkColor ]
								ifFalse: [ Color gray ]) ]
				with: mondrian ]
]

{ #category : #'*GToolkit-World' }
BaselineOfGToolkit class >> withAllContainedProjects [
	<gtExample>
	^ (GtRlDependenciesModelBuilder new
		buildProjectFromBaselineClass: BaselineOfGToolkit
		withRepositoryDescription: 'github://feenkcom/gtoolkit:main/src') withAllChildProjects	"(self project version withDeepCollect: [ :each | each projects collect: #version ] as: Set) sorted: [ :a :b | a name < b name ]"
]
