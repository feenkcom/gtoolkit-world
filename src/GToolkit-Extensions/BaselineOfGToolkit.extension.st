Extension { #name : #BaselineOfGToolkit }

{ #category : #'*GToolkit-Extensions' }
BaselineOfGToolkit class >> itself [
	<gtExample>
	^ self
]

{ #category : #'*GToolkit-Extensions' }
BaselineOfGToolkit class >> withAllContainedProjects [
	<gtExample>
	^ (self project version withDeepCollect: [ :each | each projects collect: #version ] as: Set) sorted: [ :a :b | a name < b name ]
]
