Extension { #name : #BaselineOf }

{ #category : #'*GToolkit-World' }
BaselineOf class >> gtDependenciesGraphFor: aView [
	<gtView>
	<gtClassView>
	^ aView mondrian
		title: 'Dependencies';
		priority: 10;
		painting: [ :mondrian | 
			| builder rootProject |
			builder := GtRlDependenciesModelBuilder new.
			rootProject := builder
					buildProjectFromBaselineClass: self
					withRepositoryDescription: 'unknown'.
			rootProject paintProjectDependenciesWith: mondrian ]
]
