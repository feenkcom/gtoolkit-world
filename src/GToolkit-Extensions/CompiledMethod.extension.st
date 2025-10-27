Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Extensions' }
CompiledMethod >> isGtSlide [
	^ self hasPragmaNamed: #gtSlide
]

{ #category : #'*GToolkit-Extensions' }
CompiledMethod >> paintWithinSelfMessagesWith: m [
	| methods |
	methods := {self}
			, (self methodClass methods
					select: [ :each | each selfMessages anySatisfy: [ :method | method = self selector ] ])
			, (self
					deepCollect: [ :each | each selfMessages collect: [ :method | self methodClass lookupSelector: method ] ]).
	m nodes
		stencil: [ :method | 
			BlElement new
				geometry: BlCircleGeometry new;
				size: 10 @ 10;
				background: (method = self ifTrue: [ Color red ] ifFalse: [ Color black ]) ];
		with: methods.
	m edges
		stencil: [ :method | 
			BlParabollaArcElement new
				curvatureFraction: 0.1;
				zIndex: -1;
				border: Color veryVeryLightGray;
				toHead: (BlArrowheadSimpleArrow new border: Color veryVeryLightGray) ];
		connectToAll: [ :each | each selfMessages collect: [ :method | self methodClass lookupSelector: method ] ].
	m layout horizontalDominanceTree
		levelDistance: 50;
		treesDistance: 10;
		nodeDistance: 1
]
