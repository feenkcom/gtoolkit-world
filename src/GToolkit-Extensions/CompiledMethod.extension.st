Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Extensions' }
CompiledMethod >> isGtSlide [
	^ self hasPragmaNamed: #gtSlide
]

{ #category : #'*GToolkit-Extensions' }
CompiledMethod >> paintWithinSelfMessagesWith: m [
	| methods callingMethods calledMethods |
	callingMethods := self
			deepCollect: [ :method | 
				self methodClass methods
					select: [ :each | each selfMessages anySatisfy: [ :message | message = method selector ] ] ].
	calledMethods := self
			deepCollect: [ :each | each selfMessages collect: [ :method | self methodClass lookupSelector: method ] ].
	methods := {self} , callingMethods , calledMethods.
	m nodes
		stencil: [ :method | 
			BlElement new
				geometry: BlCircleGeometry new;
				size: 10 @ 10;
				border: (BlBorder paint: (method compiledMethod = self compiledMethod
						ifTrue: [ BrGlamorousColors primaryBorderColor  ]
						ifFalse: [ Color lightGray ]) width: 2);
				background: (method compiledMethod = self compiledMethod
						ifTrue: [ BrGlamorousColors primaryBorderColor muchLighter  ]
						ifFalse: [ Color veryVeryLightGray ]);
				addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: method gtDisplayString) ];
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
