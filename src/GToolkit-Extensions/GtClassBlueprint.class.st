Class {
	#name : #GtClassBlueprint,
	#superclass : #BrStencil,
	#instVars : [
		'types',
		'methodsToElements',
		'attributesToElements',
		'classesToElements'
	],
	#category : #'GToolkit-Extensions-Visualization'
}

{ #category : #rendering }
GtClassBlueprint >> colorForMethod: aMethod [
	
	"aMethod isPureAccessor ifTrue: [ ^ Color orange alpha: 0.5].
	
	aMethod isSetter ifTrue: [ ^ Color red alpha: 0.5].

	aMethod isGetter ifTrue: [ ^ Color orange alpha: 0.5].

	aMethod isAbstract ifTrue: [ ^ Color cyan alpha: 0.5].

	aMethod isOverriding ifTrue: [ ^ Color brown alpha: 0.5].

	aMethod isConstant ifTrue: [ ^ Color magenta alpha: 0.5 ]."
	
	^ Color veryVeryLightGray
]

{ #category : #rendering }
GtClassBlueprint >> create [
	| container |
	container := BlElement new
			padding: (BlInsets all: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			layout: (GtGradVerticalTreeLayout new
					nodeDistance: 20;
					levelDistance: 50).
	classesToElements := IdentityDictionary new.
	types
		do: [ :class | 
			| classElement |
			classElement := self createType: class.
			classesToElements at: class put: classElement.
			container addChild: classElement ].
	classesToElements
		associationsDo: [ :assoc | 
			assoc key subclasses
				do: [ :subclass | 
					classesToElements
						at: subclass
						ifPresent: [ :subclassElement | 
							assoc value graph connectTo: subclassElement.
							container
								addChild: (BlLineElement new
										constraintsDo: [ :c | c ignoreByLayout ];
										border: (BlBorder paint: (Color gray alpha: 0.3) width: 2);
										zIndex: -2;
										fromAnchor: (BlElementBottomCenterAnchor
												referenceElement: assoc value
												relatedTo: subclassElement);
										toAnchor: (BlElementTopCenterAnchor
												referenceElement: subclassElement
												relatedTo: assoc value);
										fromHead: (BlArrowheadSimpleArrow new
												border: (BlBorder builder
														paint: (Color gray alpha: 0.3);
														width: 5;
														build))) ] ] ].
	methodsToElements
		associationsDo: [ :assoc | 
			(assoc key gtSelfMethods, assoc key gtSuperMethods)
				do: [ :anInvokedMethod | 
					methodsToElements
						at: anInvokedMethod
						ifPresent: [ :invokedMethodElement | 
							| lineElement |
							lineElement := BlParabollaArcElement new
									border: (Color lightGray alpha: 0.3);
									zIndex: -1;
									curvatureFraction: 0.05;
									fromAnchor: (BlElementCenterRightAnchor
											referenceElement: assoc value
											relatedTo: invokedMethodElement);
									toAnchor: (BlElementCenterLeftAnchor
											referenceElement: invokedMethodElement
											relatedTo: assoc value)";
									toHead: (BlArrowheadSimpleArrow new border: (Color gray darker alpha: 0.3))".
							lineElement constraints ignoreByLayout.
							container addChild: lineElement ] ].
			assoc key gtAccessedSlots
				do: [ :anAccessedAttribute | 
					attributesToElements
						at: anAccessedAttribute
						ifPresent: [ :accessedAttributeElement | 
							| lineElement |
							lineElement := BlParabollaArcElement new
									border: (Color blue alpha: 0.1);
									zIndex: -1;
									curvatureFraction: 0.05;
									fromAnchor: (BlElementCenterRightAnchor
											referenceElement: assoc value
											relatedTo: accessedAttributeElement);
									toAnchor: (BlElementCenterLeftAnchor
											referenceElement: accessedAttributeElement
											relatedTo: assoc value)";
									toHead: (BlArrowheadSimpleArrow new border: (Color blue alpha: 0.2))".
							lineElement constraints ignoreByLayout.
							container addChild: lineElement ] ] ].
	^ container
]

{ #category : #rendering }
GtClassBlueprint >> createLayerForAttributes: aCollection [
	| attributesContainer layerLabel |
	attributesContainer := BlElement new
			padding: (BlInsets
					top: 5
					left: 5
					bottom: 5
					right: 5);
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c linear horizontal alignCenter ];
			layout: (BlLinearLayout vertical cellSpacing: 5).
	layerLabel := BlTextElement new
			text: ('Attributes' asRopedText
					glamorousRegularFont;
					fontSize: 8;
					foreground: Color gray);
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c linear horizontal alignCenter ].
	aCollection
		do: [ :aSlot | 
			| slotElement slotNodeSize |
			slotNodeSize := 10 @ 10.
			slotElement := BlElement new
					size: slotNodeSize;
					border: (BlBorder paint: Color blue);
					background: Color white;
					when: BlClickEvent
						do: [ :e | 
							e target phlow spawnObject: aSlot.
							e consumed: true ].
			slotElement graph model: aSlot.
			attributesToElements at: aSlot put: slotElement.
			attributesContainer addChild: slotElement ].
	^ BlElement new
		padding: (BlInsets
				top: 10
				left: 20
				bottom: 10
				right: 20);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		layout: BlLinearLayout vertical;
		addChild: layerLabel;
		addChild: attributesContainer;
		when: BlClickEvent
			do: [ :e | 
				e target phlow spawnObject: aCollection.
				e consumed: true ]
]

{ #category : #rendering }
GtClassBlueprint >> createLayerForMethods: aCollection named: aString [
	| methodsContainer layerLabel layerMethodsToElements minMethodNodeSize |
	minMethodNodeSize := 7 @ 7.
	layerMethodsToElements := IdentityDictionary new.
	methodsContainer := BlElement new
			clipChildren: false;
			padding: (BlInsets
					top: 5
					left: 5
					bottom: 5
					right: 5);
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c linear horizontal alignCenter ];
			layout: (BlOnceLayout
					on: (GtGradHorizontalTreeLayout new
							treesDistance: 10;
							levelDistance: 10;
							nodeDistance: 5)).
	layerLabel := BlTextElement new
			text: (aString asRopedText
					glamorousRegularFont;
					fontSize: 6;
					foreground: Color lightGray);
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c linear horizontal alignCenter ].
	aCollection
		do: [ :aMethod | 
			| methodElement |
			methodElement := BlElement new
					size: ((aMethod messages size / 5) @ (aMethod linesOfCode / 5) max: minMethodNodeSize);
					border: Color black;
					background: (self colorForMethod: aMethod);
					addEventHandler: BlPullHandler new;
					when: BlClickEvent
						do: [ :e | 
							e target phlow spawnObject: aMethod.
							e consumed: true ].
			methodElement graph model: aMethod.
			methodElement graph beNode.
			layerMethodsToElements at: aMethod put: methodElement.
			methodsToElements at: aMethod put: methodElement.
			methodsContainer addChild: methodElement ].
	aCollection
		do: [ :aMethod | 
			| methodElement |
			methodElement := layerMethodsToElements at: aMethod.
			aMethod gtSelfMethods
				do: [ :anInvokedMethod | 
					layerMethodsToElements
						at: anInvokedMethod
						ifPresent: [ :anInvokedMethodElement | methodElement graph connectTo: anInvokedMethodElement ] ] ].
	^ BlElement new
		clipChildren: false;
		padding: (BlInsets
				top: 0
				left: 5
				bottom: 0
				right: 5);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		layout: BlLinearLayout vertical;
		addChild: layerLabel;
		addChild: methodsContainer;
		when: BlClickEvent
			do: [ :e | 
				e target phlow spawnObject: aCollection.
				e consumed: true ]
]

{ #category : #rendering }
GtClassBlueprint >> createLayerForSlots: aCollection [
	| attributesContainer layerLabel slotNodeSize |
	slotNodeSize := 7 @ 7.
	attributesContainer := BlElement new
			padding: (BlInsets top: 0 left: 5 bottom: 0 right: 5);
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c linear horizontal alignCenter ];
			layout: (BlLinearLayout vertical cellSpacing: 5).
	layerLabel := BlTextElement new
			text: ('Attributes' asRopedText
					glamorousRegularFont;
					fontSize: 6;
					foreground: Color lightGray);
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c linear horizontal alignCenter ].
	aCollection
		do: [ :aSlot | 
			| slotElement |
			slotElement := BlElement new
					size: slotNodeSize;
					border: (BlBorder paint: Color blue);
					background: Color blue muchLighter;
					when: BlClickEvent
						do: [ :e | 
							e target phlow spawnObject: aSlot.
							e consumed: true ].
			slotElement graph model: aSlot.
			attributesToElements at: aSlot put: slotElement.
			attributesContainer addChild: slotElement ].
	^ BlElement new
		padding: (BlInsets
				top: 0
				left: 10
				bottom: 0
				right: 10);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		layout: BlLinearLayout vertical;
		addChild: layerLabel;
		addChild: attributesContainer;
		when: BlClickEvent
			do: [ :e | 
				e target phlow spawnObject: aCollection.
				e consumed: true ]
]

{ #category : #rendering }
GtClassBlueprint >> createType: aType [
	| childrenContainer classLabel classElement |
	childrenContainer := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c linear horizontal alignCenter ].	"border: (BlBorder paint: Color lightGray width: 1);"
	classLabel := BlTextElement new
			margin: (BlInsets all: 5);
			text: (aType name asRopedText
					glamorousRegularFont;
					foreground: Color black);
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c linear horizontal alignCenter ].
	classElement := BlElement new
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent ];
"			border: (BlBorder paint: Color black width: 0.5 );
"			layout: BlLinearLayout vertical;
			when: BlClickEvent do: [ :e | e target phlow spawnObject: aType ];
			addChild: classLabel;
			addChild: childrenContainer.
	classElement graph model: aType.
	childrenContainer 
		addChild: (self createLayerForMethods: aType gtInitializerMethods named: 'Initializers').
	childrenContainer 
		addChild: (self createLayerForMethods: aType gtInterfaceMethods named: 'Interface').
	childrenContainer 
		addChild: (self createLayerForMethods: aType gtImplementationMethods named: 'Internal').
	childrenContainer
		addChild: (self createLayerForMethods: aType gtAccessorMethods named: 'Accessors').
	childrenContainer addChild: (self createLayerForSlots: aType slots).
	^ classElement
]

{ #category : #'as yet unclassified' }
GtClassBlueprint >> gtLiveFor: aView [
	^ aView canvassable
		title: 'Live';
		priority: 0;
		stencil: [ self ];
		actionButtonIcon: BrGlamorousVectorIcons inspect action: [ :aBrButton | 
			aBrButton phlow spawnObject: self asElement ]
]

{ #category : #initialization }
GtClassBlueprint >> initialize [
	super initialize.
	methodsToElements := IdentityDictionary new.
	attributesToElements := IdentityDictionary new.
	classesToElements := IdentityDictionary new.
	types := OrderedCollection new
]

{ #category : #accessing }
GtClassBlueprint >> type: aType [
	types := { aType }
]

{ #category : #accessing }
GtClassBlueprint >> types: aCollection [
	types := aCollection
]
