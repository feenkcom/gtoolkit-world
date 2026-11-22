Class {
	#name : #GtClassBlueprintDiff,
	#superclass : #BrStencil,
	#instVars : [
		'types',
		'methodsToElements',
		'attributesToElements',
		'classesToElements',
		'classNode',
		'methodNodesBySelector'
	],
	#category : #'GToolkit-Extensions-Visualization'
}

{ #category : #colors }
GtClassBlueprintDiff class >> addedBackgroundColor [
	^ BrAntColors green1
]

{ #category : #colors }
GtClassBlueprintDiff class >> addedBorderColor [
	^ BrAntColors green6
]

{ #category : #colors }
GtClassBlueprintDiff class >> modifiedBackgroundColor [
	^ BrAntColors blue1
]

{ #category : #colors }
GtClassBlueprintDiff class >> modifiedBorderColor [
	^ BrAntColors blue6
]

{ #category : #'instance creation' }
GtClassBlueprintDiff class >> on: anIceNode [
	^ self new initializeFromIceNode: anIceNode
]

{ #category : #colors }
GtClassBlueprintDiff class >> removedBackgroundColor [
	^ BrAntColors red1
]

{ #category : #colors }
GtClassBlueprintDiff class >> removedBorderColor [
	^ BrAntColors red6
]

{ #category : #colors }
GtClassBlueprintDiff class >> unchangedBackgroundColor [
	^ BrAntColors gray2
]

{ #category : #colors }
GtClassBlueprintDiff class >> unchangedBorderColor [
	^ BrAntColors gray6
]

{ #category : #private }
GtClassBlueprintDiff >> addPreviousDependenciesTo: aContainer [
	| type removedSelectors previousMethods methodElements superclass slotElements |
	classNode ifNil: [ ^ self ].
	type := classNode definition actualClass.
	removedSelectors := (self removedMethodDefinitionsFor: type)
			collectAsSet: #selector.
	removedSelectors ifEmpty: [ ^ self ].
	previousMethods := self previousMethodsFor: type.
	methodElements := Dictionary new.
	previousMethods
		do: [ :method | 
			| renderedMethod |
			renderedMethod := type compiledMethodAt: method selector ifAbsent: [ method ].
			methodElements
				at: method selector
				put: (methodsToElements at: renderedMethod ifAbsent: [ nil ]) ].
	superclass := self previousSuperclassOf: type.
	slotElements := self previousSlotElementsOf: type superclass: superclass.
	previousMethods
		do: [ :method | 
			(methodElements at: method selector)
				ifNotNil: [ :source | 
					| ast selfSelectors targets |
					ast := self treeOfMethod: method.
					selfSelectors := self selectorsSentTo: #self in: ast.
					targets := IdentitySet new.
					(removedSelectors includes: method selector)
						ifTrue: [ selfSelectors
								do: [ :selector | 
									targets
										add: (methodElements
												at: selector
												ifAbsent: [ self methodElementFor: selector in: superclass ]) ].
							(self selectorsSentTo: #super in: ast)
								do: [ :selector | targets add: (self methodElementFor: selector in: superclass) ].
							ast variableNodes
								do: [ :variable | 
									(variable whoDefines: variable name)
										ifNil: [ targets add: (slotElements at: variable name ifAbsent: [ nil ]) ] ] ]
						ifFalse: [ selfSelectors
								do: [ :selector | 
									(removedSelectors includes: selector)
										ifTrue: [ targets add: (methodElements at: selector) ] ] ].
					targets remove: nil ifAbsent: [  ].
					targets
						do: [ :target | aContainer addChild: (self dependencyLineFrom: source to: target) ] ] ]
]

{ #category : #colors }
GtClassBlueprintDiff >> backgroundColorForChange: aChange [
	aChange ifNil: [ ^ self class unchangedBackgroundColor ].
	(self isAddition: aChange) ifTrue: [ ^ self class addedBackgroundColor ].
	(self isRemoval: aChange) ifTrue: [ ^ self class removedBackgroundColor ].
	^ self class modifiedBackgroundColor
]

{ #category : #colors }
GtClassBlueprintDiff >> borderColorForChange: aChange [
	aChange ifNil: [ ^ self class unchangedBorderColor ].
	(self isAddition: aChange) ifTrue: [ ^ self class addedBorderColor ].
	(self isRemoval: aChange) ifTrue: [ ^ self class removedBorderColor ].
	^ self class modifiedBorderColor
]

{ #category : #private }
GtClassBlueprintDiff >> changeForMethod: aMethod [
	^ (self changeNodeForMethod: aMethod)
		ifNotNil: [ :node | self definitionsBeforeAndAfter: node value ]
]

{ #category : #private }
GtClassBlueprintDiff >> changeForType: aType [
	(classNode isNil or: [ aType ~~ classNode definition actualClass ])
		ifTrue: [ ^ nil ].
	^ self definitionsBeforeAndAfter: classNode value
]

{ #category : #private }
GtClassBlueprintDiff >> changeNodeForMethod: aMethod [
	| methodNode |
	methodNodesBySelector ifNil: [ ^ nil ].
	methodNode := methodNodesBySelector at: aMethod selector ifAbsent: [ ^ nil ].
	methodNode hasChanges ifFalse: [ ^ nil ].
	aMethod == methodNode definition ifTrue: [ ^ methodNode ].
	(aMethod isCompiledMethod
		and: [ aMethod methodClass == classNode definition actualClass ])
		ifTrue: [ ^ methodNode ].
	^ nil
]

{ #category : #accessing }
GtClassBlueprintDiff >> classNode [
	^ classNode
]

{ #category : #rendering }
GtClassBlueprintDiff >> colorForMethod: aMethod [
	^ self backgroundColorForChange: (self changeForMethod: aMethod)
]

{ #category : #rendering }
GtClassBlueprintDiff >> create [
	| container |
	container := BlElement new
			padding: (BlInsets all: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			layout: (GtGradVerticalTreeLayout new
					nodeDistance: 20;
					levelDistance: 50).
	methodsToElements := IdentityDictionary new.
	attributesToElements := IdentityDictionary new.
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
							| lineColor |
							lineColor := self lineColorFrom: assoc value to: subclassElement.
							assoc value graph connectTo: subclassElement.
							container
								addChild: (BlLineElement new
										constraintsDo: [ :c | c ignoreByLayout ];
										border: (BlBorder paint: lineColor width: 2);
										zIndex: -2;
										fromAnchor: (BlElementBottomCenterAnchor
												referenceElement: assoc value
												relatedTo: subclassElement);
										toAnchor: (BlElementTopCenterAnchor
												referenceElement: subclassElement
												relatedTo: assoc value);
										fromHead: (BlArrowheadTriangle new
												scale: 3;
												border: (BlBorder builder
														paint: lineColor;
														width: 1;
														build))) ] ] ].
	methodsToElements
		keysAndValuesDo: [ :method :methodElement | 
			method isCompiledMethod
				ifTrue: [ method gtSelfMethods , method gtSuperMethods
						do: [ :invokedMethod | 
							methodsToElements
								at: invokedMethod
								ifPresent: [ :invokedElement | container addChild: (self dependencyLineFrom: methodElement to: invokedElement) ] ].
					method gtAccessedSlots
						do: [ :slot | 
							attributesToElements
								at: slot
								ifPresent: [ :slotElement | container addChild: (self dependencyLineFrom: methodElement to: slotElement) ] ] ] ].
	self addPreviousDependenciesTo: container.
	^ container
]

{ #category : #rendering }
GtClassBlueprintDiff >> createLayerForAttributes: aCollection [
	| attributesContainer layerLabel |
	attributesContainer := BrVerticalPane new
			cellSpacing: 5;
			fitContent;
			padding: (BlInsets all: 5);
			constraintsDo: [ :c | c linear horizontal alignCenter ].
	layerLabel := BrLabel new
			text: 'Attributes';
			aptitude: (BrGlamorousLabelAptitude new
					fontSize: 8;
					foreground: Color gray);
			constraintsDo: [ :c | c linear horizontal alignCenter ].
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
GtClassBlueprintDiff >> createLayerForMethods: aCollection named: aString [
	| methodsContainer layerMethodsToElements |
	layerMethodsToElements := IdentityDictionary new.
	methodsContainer := self layerContentsContainer.
	aCollection
		do: [ :aMethod | 
			| methodElement |
			methodElement := BlElement new
					size: ((self widthOfMethod: aMethod) @ (self heightOfMethod: aMethod)
							max: self minimumNodeSize);
					addEventHandler: BlPullHandler new;
					addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
							menu: [ self menuForMethod: aMethod ]);
					when: BlClickEvent
						do: [ :e | 
							e target phlow spawnObject: (self objectToInspectForMethod: aMethod).
							e consumed: true ].
			self styleNode: methodElement forChange: (self changeForMethod: aMethod).
			methodElement graph
				beNode;
				model: aMethod.
			methodsToElements at: aMethod put: methodElement.
			aMethod isCompiledMethod
				ifTrue: [ layerMethodsToElements at: aMethod put: methodElement ]
				ifFalse: [ methodElement
						addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: aMethod selector asString) ].
			methodsContainer addChild: methodElement ].
	aCollection
		do: [ :aMethod | 
			layerMethodsToElements
				at: aMethod
				ifPresent: [ :methodElement | 
					aMethod gtSelfMethods
						do: [ :anInvokedMethod | 
							layerMethodsToElements
								at: anInvokedMethod
								ifPresent: [ :anInvokedMethodElement | methodElement graph connectTo: anInvokedMethodElement ] ] ] ].
	^ (self layerContainerNamed: aString withObjects: aCollection)
		addChild: methodsContainer
]

{ #category : #rendering }
GtClassBlueprintDiff >> createLayerForSlots: aCollection [
	^ self createLayerForSlots: aCollection changes: Dictionary new
]

{ #category : #private }
GtClassBlueprintDiff >> createLayerForSlots: aCollection changes: slotChanges [
	| attributesContainer container slots |
	attributesContainer := self layerContentsContainer.
	slots := OrderedDictionary new.
	aCollection do: [ :slot | slots at: slot name asSymbol put: slot ].
	slotChanges
		keysAndValuesDo: [ :name :change | slots at: name ifAbsentPut: [ change value ifNil: [ change key ] ] ].
	slots
		keysAndValuesDo: [ :name :aSlot | 
			| slotElement change |
			change := slotChanges at: name ifAbsent: [ nil ].
			slotElement := BlElement new
					size: self minimumNodeSize;
					addEventHandler: BlPullHandler new;
					when: BlClickEvent
						do: [ :e | 
							e target phlow spawnObject: (change ifNil: [ aSlot ] ifNotNil: [ classNode ]).
							e consumed: true ].
			self styleNode: slotElement forChange: change.
			slotElement graph
				beNode;
				model: aSlot.
			attributesToElements at: aSlot put: slotElement.
			attributesContainer addChild: slotElement ].
	container := self layerContainerNamed: 'Slots' withObjects: slots values.
	^ container addChild: attributesContainer
]

{ #category : #rendering }
GtClassBlueprintDiff >> createType: aType [
	| childrenContainer classLabel classElement |
	childrenContainer := BrHorizontalPane new
			fitContent;
			constraintsDo: [ :c | c linear horizontal alignCenter ].
	classLabel := BrLabel new
			aptitude: BrGlamorousLabelAptitude new;
			margin: (BlInsets all: 5);
			text: aType name;
			constraintsDo: [ :c | c linear horizontal alignCenter ].
	classElement := BrVerticalPane new
			fitContent;
			when: BlClickEvent do: [ :e | e target phlow spawnObject: aType ];
			addChild: classLabel;
			addChild: childrenContainer.
	classElement graph model: aType.
	classElement userData at: #blueprintChange put: (self changeForType: aType).
	(self methodLayersFor: aType)
		keysAndValuesDo: [ :name :methods | childrenContainer addChild: (self createLayerForMethods: methods named: name) ].
	childrenContainer
		addChild: (self createLayerForSlots: aType slots changes: (self slotChangesFor: aType)).
	^ classElement
]

{ #category : #private }
GtClassBlueprintDiff >> definitionsBeforeAndAfter: anOperation [
	anOperation isAddition ifTrue: [ ^ nil -> anOperation definition ].
	anOperation isRemoval ifTrue: [ ^ anOperation definition -> nil ].
	anOperation isModification
		ifTrue: [ ^ anOperation oldDefinition -> anOperation definition ].
	^ nil
]

{ #category : #private }
GtClassBlueprintDiff >> dependencyLineFrom: fromElement to: toElement [
	^ BlParabollaArcElement new
		border: (self lineColorFrom: fromElement to: toElement);
		zIndex: -1;
		curvatureFraction: 0.05;
		fromAnchor: (BlElementCenterRightAnchor referenceElement: fromElement relatedTo: toElement);
		toAnchor: (BlElementCenterLeftAnchor referenceElement: toElement relatedTo: fromElement);
		constraintsDo: [ :constraints | constraints ignoreByLayout ]
]

{ #category : #'as yet unclassified' }
GtClassBlueprintDiff >> gtDisplayOn: stream [
	stream nextPutAll: 'Blueprint of '.
	types do: [:t | stream nextPutAll: t name ] separatedBy: [stream nextPutAll: ', ']
]

{ #category : #views }
GtClassBlueprintDiff >> gtLiveFor: aView [
	^ aView canvassable
		title: 'Live';
		priority: 0;
		stencil: [ self ];
		actionButtonIcon: BrGlamorousVectorIcons inspect action: [ :aBrButton | 
			aBrButton phlow spawnObject: self asElement ]
]

{ #category : #rendering }
GtClassBlueprintDiff >> heightOfMethod: aMethod [
	^ "aMethod linesOfCode / 5"7
]

{ #category : #initialization }
GtClassBlueprintDiff >> initialize [
	super initialize.
	methodsToElements := IdentityDictionary new.
	attributesToElements := IdentityDictionary new.
	classesToElements := IdentityDictionary new.
	types := OrderedCollection new
]

{ #category : #initialization }
GtClassBlueprintDiff >> initializeFromIceNode: anIceNode [
	self assert: anIceNode definition isClassDefinition.
	self type: anIceNode definition actualClass.
	classNode := anIceNode.
	methodNodesBySelector := Dictionary new.
	classNode children
		do: [ :child | 
			child definition isMethodDefinition
				ifTrue: [ methodNodesBySelector at: child definition selector asSymbol put: child ] ]
]

{ #category : #private }
GtClassBlueprintDiff >> isAccessorTree: aMethodTree forSlots: slotNames [
	^ slotNames
		anySatisfy: [ :name | 
			| getter setter |
			getter := RBParseTreeSearcher getterMethod: name.
			getter executeTree: aMethodTree.
			getter answer notNil
				or: [ setter := RBParseTreeSearcher setterMethod: name.
					setter executeTree: aMethodTree.
					setter answer notNil ] ]
]

{ #category : #private }
GtClassBlueprintDiff >> isAddition: aChange [
	^ aChange notNil and: [ aChange key isNil ]
]

{ #category : #private }
GtClassBlueprintDiff >> isInitializerMethod: aMethod [
	| protocol |
	aMethod selector = #initialize ifTrue: [ ^ true ].
	protocol := aMethod isCompiledMethod
			ifTrue: [ aMethod protocolName ]
			ifFalse: [ aMethod protocol ].
	^ #('initialization' 'initialize')
		anySatisfy: [ :name | protocol includesSubstring: name ]
]

{ #category : #private }
GtClassBlueprintDiff >> isRemoval: aChange [
	^ aChange notNil and: [ aChange value isNil ]
]

{ #category : #rendering }
GtClassBlueprintDiff >> layerContainerNamed: aString withObjects: aCollection [
	^ BrVerticalPane new
		fitContent;
		clipChildren: false;
		padding: (BlInsets left: 5 right: 5);
		addChild: (BrLabel new
				text: aString;
				aptitude: (BrGlamorousLabelAptitude new
						fontSize: 6;
						foreground: Color lightGray);
				fitContent;
				constraintsDo: [ :c | c linear horizontal alignCenter ]);
		when: BlClickEvent
			do: [ :e | 
				e target phlow spawnObject: aCollection.
				e consumed: true ]
]

{ #category : #rendering }
GtClassBlueprintDiff >> layerContentsContainer [
	^ BlElement new
		clipChildren: false;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent.
			c linear horizontal alignCenter ];
		layout: (BlOnceLayout
				on: (GtGradHorizontalTreeLayout new
						treesDistance: 10;
						levelDistance: 10;
						nodeDistance: 5))
]

{ #category : #rendering }
GtClassBlueprintDiff >> layerLabelNamed: aString [
	^ BrLabel new
		text: aString;
		aptitude: (BrGlamorousLabelAptitude new
				fontSize: 6;
				foreground: Color lightGray);
		fitContent;
		constraintsDo: [ :c | c linear horizontal alignCenter ]
]

{ #category : #private }
GtClassBlueprintDiff >> lineColorFrom: fromElement to: toElement [
	| fromChange toChange |
	fromChange := fromElement userData at: #blueprintChange.
	toChange := toElement userData at: #blueprintChange.
	((self isRemoval: fromChange) or: [ self isRemoval: toChange ])
		ifTrue: [ ^ self class removedBackgroundColor ].
	(self isAddition: fromChange) ~= (self isAddition: toChange)
		ifTrue: [ ^ self class addedBackgroundColor ].
	^ self class unchangedBackgroundColor
]

{ #category : #rendering }
GtClassBlueprintDiff >> menuForMethod: aMethod [
	aMethod isCompiledMethod
		ifFalse: [ ^ BrMenuItems new
				addItemLabel: 'Open method diff'
				action: [ :element | element phlow spawnObject: (self objectToInspectForMethod: aMethod) ] ].
	^ BrMenuItems new
		addItem: (BrMenuSubmenuItem new
				label: 'Method source code';
				submenu: (GtPharoMethodCoderMenu new forMethod: aMethod);
				bePinSubmenuAction;
				hideOnClick: true);
		addItemLabel: 'Browse method'
			action: [ :anElement :aButtonModel :anEvent | anElement phlow spawnTool: (GtMethodCoderTool compiledMethod: aMethod) ]
]

{ #category : #private }
GtClassBlueprintDiff >> methodElementFor: aSelector in: aBehavior [
	^ aBehavior
		ifNotNil: [ methodsToElements at: (aBehavior lookupSelector: aSelector) ifAbsent: [ nil ] ]
]

{ #category : #private }
GtClassBlueprintDiff >> methodLayersFor: aType [
	| layers removed previousLayers |
	layers := OrderedDictionary
			newFrom: {'Initializers' -> aType gtInitializerMethods asOrderedCollection.
					'Interface' -> aType gtInterfaceMethods asOrderedCollection.
					'Internal' -> aType gtImplementationMethods asOrderedCollection.
					'Accessors' -> aType gtAccessorMethods asOrderedCollection}.
	removed := self removedMethodDefinitionsFor: aType.
	removed ifEmpty: [ ^ layers ].
	previousLayers := self previousMethodLayersFor: aType.
	removed
		do: [ :method | (layers at: (previousLayers at: method selector)) add: method ].
	^ layers
]

{ #category : #accessing }
GtClassBlueprintDiff >> methodNodesBySelector [
	^ methodNodesBySelector
]

{ #category : #rendering }
GtClassBlueprintDiff >> minimumNodeSize [
	^ 7 @ 7
]

{ #category : #private }
GtClassBlueprintDiff >> objectToInspectForMethod: aMethod [
	^ (self changeNodeForMethod: aMethod) ifNil: [ aMethod ]
]

{ #category : #private }
GtClassBlueprintDiff >> previousMethodLayersFor: aType [
	| layers candidates slotNames calledSelectors |
	layers := Dictionary new.
	candidates := OrderedCollection new.
	slotNames := self previousSlotNamesFor: aType.
	(self previousMethodsFor: aType)
		do: [ :method | 
			| ast |
			(self isInitializerMethod: method)
				ifTrue: [ layers at: method selector put: 'Initializers' ]
				ifFalse: [ ast := self treeOfMethod: method.
					(self isAccessorTree: ast forSlots: slotNames)
						ifTrue: [ layers at: method selector put: 'Accessors' ]
						ifFalse: [ candidates add: method selector -> ast ] ] ].
	calledSelectors := candidates
			flatCollectAsSet: [ :candidate | self selectorsSentTo: #self in: candidate value ].
	candidates
		do: [ :candidate | 
			layers
				at: candidate key
				put: ((calledSelectors includes: candidate key)
						ifTrue: [ 'Internal' ]
						ifFalse: [ 'Interface' ]) ].
	^ layers
]

{ #category : #private }
GtClassBlueprintDiff >> previousMethodsFor: aType [
	| methods |
	methods := Dictionary new.
	aType methods do: [ :method | methods at: method selector put: method ].
	methodNodesBySelector
		keysAndValuesDo: [ :selector :node | 
			| change |
			change := node value.
			change isAddition ifTrue: [ methods removeKey: selector ifAbsent: [  ] ].
			change isRemoval ifTrue: [ methods at: selector put: node definition ].
			change isModification
				ifTrue: [ methods at: selector put: change oldDefinition ] ].
	^ methods values
]

{ #category : #private }
GtClassBlueprintDiff >> previousSlotElementsOf: aType superclass: aSuperclass [
	| elements previousNames |
	elements := Dictionary new.
	aSuperclass
		ifNotNil: [ aSuperclass allSlots
				do: [ :slot | 
					attributesToElements
						at: slot
						ifPresent: [ :element | elements at: slot name put: element ] ] ].
	previousNames := (self previousSlotNamesFor: aType) asSet.
	previousNames do: [ :name | elements removeKey: name ifAbsent: [  ] ].
	aType slots
		do: [ :slot | 
			(previousNames includes: slot name)
				ifTrue: [ attributesToElements
						at: slot
						ifPresent: [ :element | elements at: slot name put: element ] ] ].
	(self slotChangesFor: aType)
		keysAndValuesDo: [ :name :change | 
			(self isRemoval: change)
				ifTrue: [ attributesToElements
						at: change key
						ifPresent: [ :element | elements at: name put: element ] ] ].
	^ elements
]

{ #category : #private }
GtClassBlueprintDiff >> previousSlotNamesFor: aType [
	| change definition |
	change := classNode value.
	definition := change isModification
			ifTrue: [ change oldDefinition ]
			ifFalse: [ classNode definition ].
	definition asMCDefinition ifNil: [ ^ aType slots collect: #name ].
	^ (self slotDefinitionsIn: definition) keys
]

{ #category : #private }
GtClassBlueprintDiff >> previousSuperclassOf: aType [
	| definition |
	classNode value isModification ifFalse: [ ^ aType superclass ].
	definition := classNode value oldDefinition asMCDefinition.
	definition ifNil: [ ^ aType superclass ].
	^ definition superclassName
		ifNotNil: [ :name | Smalltalk globals at: name asSymbol ifAbsent: [ nil ] ]
]

{ #category : #private }
GtClassBlueprintDiff >> removedMethodDefinitionsFor: aType [
	(classNode isNil or: [ aType ~~ classNode definition actualClass ])
		ifTrue: [ ^ #() ].
	^ (methodNodesBySelector values
		select: [ :node | 
			node value isRemoval
				and: [ (aType includesSelector: node definition selector) not ] ]
		thenCollect: #definition)
		sorted: [ :left :right | left selector < right selector ]
]

{ #category : #private }
GtClassBlueprintDiff >> selectorsSentTo: aReceiverName in: aMethodTree [
	^ aMethodTree sendNodes
		select: [ :send | send receiver isVariable and: [ send receiver name = aReceiverName ] ]
		thenCollect: #selector
]

{ #category : #private }
GtClassBlueprintDiff >> slotChangesFor: aType [
	| change before after changes |
	changes := OrderedDictionary new.
	(classNode isNil or: [ aType ~~ classNode definition actualClass ])
		ifTrue: [ ^ changes ].
	change := classNode value.
	(change isAddition or: [ change isRemoval or: [ change isModification ] ])
		ifFalse: [ ^ changes ].
	before := change isAddition
			ifTrue: [ OrderedDictionary new ]
			ifFalse: [ self
					slotDefinitionsIn: (change isModification
							ifTrue: [ change oldDefinition ]
							ifFalse: [ classNode definition ]) ].
	after := change isRemoval
			ifTrue: [ OrderedDictionary new ]
			ifFalse: [ self slotDefinitionsIn: classNode definition ].
	after
		keysAndValuesDo: [ :name :definition | 
			before
				at: name
				ifPresent: [ :oldDefinition | 
					oldDefinition = definition
						ifFalse: [ changes at: name put: oldDefinition -> definition ] ]
				ifAbsent: [ changes at: name put: nil -> definition ] ].
	before
		keysAndValuesDo: [ :name :definition | (after includesKey: name) ifFalse: [ changes at: name put: definition -> nil ] ].
	^ changes
]

{ #category : #private }
GtClassBlueprintDiff >> slotDefinitionsIn: anIceClassDefinition [
	| definition slotTest slots |
	slots := OrderedDictionary new.
	definition := anIceClassDefinition asMCDefinition.
	definition ifNil: [ ^ slots ].
	slotTest := anIceClassDefinition isMeta
			ifTrue: [ #isClassInstanceVariable ]
			ifFalse: [ #isInstanceVariable ].
	definition variables
		do: [ :variable | 
			(variable perform: slotTest)
				ifTrue: [ | name |
					name := variable name.
					(name beginsWith: '#')
						ifTrue: [ name := (OCParser parseExpression: name) receiver value ].
					slots at: name asSymbol put: variable ] ].
	^ slots
]

{ #category : #private }
GtClassBlueprintDiff >> styleNode: anElement forChange: aChange [
	anElement
		border: (self borderColorForChange: aChange);
		background: (self backgroundColorForChange: aChange).
	anElement userData at: #blueprintChange put: aChange
]

{ #category : #private }
GtClassBlueprintDiff >> treeOfMethod: aMethod [
	^ aMethod isCompiledMethod
		ifTrue: [ aMethod ast ]
		ifFalse: [ OCParser parseFaultyMethod: aMethod sourceCode ]
]

{ #category : #accessing }
GtClassBlueprintDiff >> type: aType [
	types := { aType }
]

{ #category : #accessing }
GtClassBlueprintDiff >> types: aCollection [
	types := aCollection
]

{ #category : #rendering }
GtClassBlueprintDiff >> widthOfMethod: aMethod [
	^ "aMethod messages size / 5"7
]
