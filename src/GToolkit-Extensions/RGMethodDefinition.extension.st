Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtBasicSourceFor: aView [
	^ aView explicit
		title: 'Source';
		priority: 0;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self compiledMethod) ];
		stencil: [ 
			 ((((GtPharoMethodCoder forMethod: self) 
				subscribeToSystem) asCoderViewModel expanded: true)
				asElement) ].
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtImplementorsFor: aView [
	<gtView>
	^ aView forward
		title: 'Implementors';
		priority: 23;
		object: [ 
			| searchContext |
			searchContext := nil.
			self isDefined ifTrue: [
				searchContext := GtSearchMethodCoderFilterContext new 
					behavior: self methodClass;
					selectorInPosition: self selector ].
			self selector gtImplementors
				requesterContext: searchContext ];
		view: #gtItemsFor: 
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtSendersFor: aView [
	<gtView>
	^ aView forward
		title: 'Senders';
		priority: 22;
		object: [ 
			| searchContext |
			searchContext := nil.
			self isDefined ifTrue: [
				searchContext := GtSearchMethodCoderFilterContext new 
					behavior: self methodClass;
					nodeInPosition: self method ast;
					selectorInPosition: self selector ].
			self selector gtSenders
				requesterContext: searchContext ];
		view: #gtItemsFor: 
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtWithinSelfMessagesFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Within self messages';
		priority: 30;
		painting: [ :m | self paintWithinSelfMessagesWith: m ]
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> isClassSide [
	"For compatibility with CompiledMethod"
	^self isMetaSide
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> isGtSlide [
	^ self method isGtSlide
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> paintWithinSelfMessagesWith: m [
	| methods callingMethods calledMethods |
	callingMethods := self method
			deepCollect: [ :method | 
				self methodClass methods
					select: [ :each | each selfMessages anySatisfy: [ :message | message = method selector ] ] ].
	calledMethods := self method
			deepCollect: [ :each | each selfMessages collect: [ :method | self methodClass lookupSelector: method ] ].
	methods := {self} , ((callingMethods , calledMethods) collect: #methodReference).
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
				addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: method gtDisplayString)
 ];
		with: methods.
	m edges
		stencil: [ :method | 
			BlParabollaArcElement new
				curvatureFraction: 0.1;
				zIndex: -1;
				border: Color veryVeryLightGray;
				toHead: (BlArrowheadSimpleArrow new border: Color veryVeryLightGray) ];
		connectToAll: [ :each | 
			(each compiledMethod selfMessages
				collect: [ :method | self methodClass lookupSelector: method ])
				collect: #methodReference ].
	m layout horizontalDominanceTree
		levelDistance: 30;
		treesDistance: 10;
		nodeDistance: 1
]
