Extension { #name : #AIGraphNode }

{ #category : #'*GToolkit-Extensions' }
AIGraphNode >> gtAdjacentNodesFor: aView [
	<gtView>
	adjacentNodes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Adjacent nodes';
		items: [ adjacentNodes asOrderedCollection ];
		column: 'Node' text: [ :each | each gtDisplayString ]
]
