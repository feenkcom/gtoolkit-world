Extension { #name : #AIGraphAlgorithm }

{ #category : #'*GToolkit-Extensions' }
AIGraphAlgorithm >> gtEdgesFor: aView [
	<gtView>
	edges isEmpty ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Edges';
		items: [ edges ];
		column: 'Edge' text: [ :each | each gtDisplayString ]
]

{ #category : #'*GToolkit-Extensions' }
AIGraphAlgorithm >> gtNodesFor: aView [
	<gtView>
	nodes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Nodes';
		items: [ nodes ];
		column: 'Node' text: [ :each | each gtDisplayString ];
		column: 'Adjacent nodes' text: [ :each | each adjacentNodes size ]
]
