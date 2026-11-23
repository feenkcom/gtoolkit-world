Class {
	#name : #GtClassBlueprintDiffExamples,
	#superclass : #Object,
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #examples }
GtClassBlueprintDiffExamples >> blueprintFromClassChange [
	<gtExample>
	<return: #GtClassBlueprintDiff>
	| node blueprint |
	node := self classChangeNode.
	blueprint := GtClassBlueprintDiff on: node.
	self assert: blueprint classNode == node.
	self
		assert: (blueprint methodNodesBySelector at: #minimumNodeSize)
				== (node / #minimumNodeSize).
	self assert: blueprint asElement children first graph model == GtClassBlueprint.
	^ blueprint
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> classBlueprintView [
	<gtExample>
	<return: #GtPhlowCanvassableView>
	| node emptyView view blueprint |
	node := self classChangeNode.
	emptyView := GtPhlowView empty.
	view := node gtViewClassBlueprintFor: emptyView.
	self assert: (view isKindOf: GtPhlowCanvassableView).
	self assert: view title equals: 'Class Blueprint'.
	blueprint := view stencilBuilder asElement.
	self assert: blueprint children first graph model == GtClassBlueprint.
	self
		assert: (node / #minimumNodeSize gtViewClassBlueprintFor: emptyView) class
		equals: emptyView class.
	^ view
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> classChangeNode [
	<gtExample>
	<return: #IceNode>
	| definition node method before after |
	definition := (IceClassDefinition named: #GtClassBlueprint isMeta: false)
			mcDefinition: GtClassBlueprint asClassDefinition.
	node := IceNode value: (IceNoModification definition: definition).
	method := GtClassBlueprint >> #minimumNodeSize.
	after := IceMethodDefinition
			className: #GtClassBlueprint
			classIsMeta: false
			protocol: method protocolName
			name: method selector
			sourceCode: method sourceCode.
	before := after copy sourceCode: 'minimumNodeSize ^ 5 @ 5'.
	node addChild: (IceModification left: after right: before).
	^ node
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> clickChangedSlot [
	<gtExample>
	<return: #BlScripter>
	| node element scripter spawned |
	node := self slotChangeNode.
	element := (GtClassBlueprintDiff on: node) asElement.
	element
		when: GtPhlowObjectToSpawn
		do: [ :event | 
			spawned := event object.
			event consumed: true ].
	scripter := BlScripter new element: element.
	scripter click
		onChildFromBlock: [ :root | 
			| slotElement |
			root
				allChildrenBreadthFirstDo: [ :child | 
					| slot |
					slot := child graph model.
					((slot isKindOf: MCVariableDefinition)
						and: [ slot name = 'removedExampleSlot' ])
						ifTrue: [ slotElement := child ] ].
			slotElement ];
		play.
	self assert: spawned == node.
	^ scripter
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> clickDeletedMethod [
	<gtExample>
	<return: #BlScripter>
	| element scripter methodElement spawned |
	element := self deletedMethodInBlueprint.
	element
		allChildrenBreadthFirstDo: [ :child | 
			(child graph model isKindOf: IceMethodDefinition)
				ifTrue: [ methodElement := child ] ].
	element
		when: GtPhlowObjectToSpawn
		do: [ :event | 
			spawned := event object.
			event consumed: true ].
	scripter := BlScripter new element: element.
	scripter click
		onChildFromBlock: [ :root | methodElement ];
		play.
	self assert: spawned value isRemoval.
	self assert: spawned definition == methodElement graph model.
	^ scripter
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> clickMethodNodes [
	<gtExample>
	<return: #BlScripter>
	| node changedMethod unchangedMethod element scripter spawned |
	node := self classChangeNode.
	changedMethod := GtClassBlueprint >> #minimumNodeSize.
	unchangedMethod := GtClassBlueprint >> #widthOfMethod:.
	node
		addChild: (IceNoModification
				definition: (IceMethodDefinition
						className: #GtClassBlueprint
						classIsMeta: false
						protocol: unchangedMethod protocolName
						name: unchangedMethod selector
						sourceCode: unchangedMethod sourceCode)).
	element := (GtClassBlueprintDiff on: node) asElement.
	element
		when: GtPhlowObjectToSpawn
		do: [ :event | 
			spawned := event object.
			event consumed: true ].
	scripter := BlScripter new element: element.
	{changedMethod -> (node / changedMethod selector).
		unchangedMethod -> unchangedMethod.
		(GtClassBlueprint >> #heightOfMethod:)
			-> (GtClassBlueprint >> #heightOfMethod:)}
		do: [ :entry | 
			spawned := nil.
			scripter click
				onChildFromBlock: [ :root | 
					| methodElement |
					root
						allChildrenBreadthFirstDo: [ :child | child graph model == entry key ifTrue: [ methodElement := child ] ].
					methodElement ];
				play.
			self assert: spawned == entry value ].
	^ scripter
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> connectionChangeColors [
	<gtExample>
	<return: #BlElement>
	| node definition element colors |
	node := self slotChangeNode.
	definition := node definition asMCDefinition.
	definition variables
		remove: (definition variables
				detect: [ :variable | variable isInstanceVariable and: [ variable name = 'attributesToElements' ] ]).
	self classChangeNode children do: [ :child | node addChild: child value ].
	{IceAddition -> #createLayerForMethods:named:.
		IceAddition -> #widthOfMethod:.
		IceRemoval -> #heightOfMethod:.
		IceRemoval -> #initialize}
		do: [ :entry | 
			| method |
			method := GtClassBlueprint >> entry value.
			node
				addChild: (entry key
						definition: (IceMethodDefinition
								className: #GtClassBlueprint
								classIsMeta: false
								protocol: method protocolName
								name: method selector
								sourceCode: method sourceCode)) ].
	element := (GtClassBlueprintDiff on: node) asElement.
	colors := Dictionary new.
	element children
		do: [ :child | 
			(child isKindOf: BlParabollaArcElement)
				ifTrue: [ | from to |
					from := child fromAnchor referenceElement graph model.
					to := child toAnchor referenceElement graph model.
					colors
						at: from selector
								-> (to isCompiledMethod ifTrue: [ to selector ] ifFalse: [ to name ])
						put: child border paint color ] ].
	self
		assert: (colors at: #createLayerForMethods:named: -> #heightOfMethod:)
		equals: BrAntColors red1.
	self
		assert: (colors at: #createLayerForMethods:named: -> #minimumNodeSize)
		equals: BrAntColors green1.
	self
		assert: (colors at: #createLayerForMethods:named: -> #widthOfMethod:)
		equals: BrAntColors gray2.
	self
		assert: (colors at: #initialize -> #methodsToElements)
		equals: BrAntColors red1.
	self
		assert: (colors at: #create -> #attributesToElements)
		equals: BrAntColors red1.
	self
		assert: (colors at: #create -> #methodsToElements)
		equals: BrAntColors green1.
	self
		assert: (colors at: #create -> #classesToElements)
		equals: BrAntColors gray2.
	^ element
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> deletedMethodConnections [
	<gtExample>
	<return: #BlElement>
	| node element edges expected |
	node := self slotChangeNode.
	self classChangeNode children do: [ :child | node addChild: child value ].
	(node / #minimumNodeSize) value oldDefinition
		sourceCode: 'minimumNodeSize ^ self deletedBlueprintCaller'.
	{#deletedBlueprintCaller
			-> 'deletedBlueprintCaller
		| attributesToElements |
		attributesToElements := self deletedBlueprintCallee.
		self layerContentsContainer.
		self layerContentsContainer.
		super asItem.
		^ removedExampleSlot'.
		#deletedBlueprintCallee -> 'deletedBlueprintCallee ^ types'}
		do: [ :entry | 
			node
				addChild: (IceRemoval
						definition: (IceMethodDefinition
								className: #GtClassBlueprint
								classIsMeta: false
								protocol: 'private'
								name: entry key
								sourceCode: entry value)) ].
	element := (GtClassBlueprintDiff on: node)
			types: {GtClassBlueprint superclass.
					GtClassBlueprint};
			asElement.
	edges := Bag new.
	element children
		do: [ :line | 
			(line isKindOf: BlParabollaArcElement)
				ifTrue: [ | from to targetName |
					from := line fromAnchor referenceElement graph model.
					to := line toAnchor referenceElement graph model.
					((from isKindOf: IceMethodDefinition)
						or: [ to isKindOf: IceMethodDefinition ])
						ifTrue: [ self
								assert: line border paint color
								equals: GtClassBlueprintDiff removedBackgroundColor.
							targetName := (to isCompiledMethod
									or: [ to isKindOf: IceMethodDefinition ])
									ifTrue: [ to selector ]
									ifFalse: [ to name asSymbol ].
							edges add: from selector -> targetName ] ] ].
	expected := {#minimumNodeSize -> #deletedBlueprintCaller.
			#deletedBlueprintCaller -> #deletedBlueprintCallee.
			#deletedBlueprintCaller -> #layerContentsContainer.
			#deletedBlueprintCaller -> #asItem.
			#deletedBlueprintCaller -> #removedExampleSlot.
			#deletedBlueprintCallee -> #types} asBag.
	self assert: edges equals: expected.
	^ element
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> deletedMethodInBlueprint [
	<gtExample>
	<return: #BlElement>
	| methodNode element methodElements |
	methodNode := self recoverDeletedMethod.
	element := (GtClassBlueprintDiff on: methodNode parent) asElement.
	methodElements := OrderedCollection new.
	element
		allChildrenBreadthFirstDo: [ :child | child graph model == methodNode definition ifTrue: [ methodElements add: child ] ].
	self assert: methodElements size equals: 1.
	self
		assert: methodElements first border paint color
		equals: GtClassBlueprintDiff removedBorderColor.
	self
		assert: methodElements first background paint color
		equals: GtClassBlueprintDiff removedBackgroundColor.
	^ element
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> deletedMethodsInExistingLayers [
	<gtExample>
	<return: #BlElement>
	| node element classLayers actualLayers layersByMethod |
	node := self recoverDeletedMethod parent.
	(node / #minimumNodeSize) value oldDefinition
		sourceCode: 'minimumNodeSize ^ self deletedBlueprintHelper'.
	{{#deletedBlueprintInitializer.
			'initialization'.
			'deletedBlueprintInitializer ^ self'}.
		{#deletedBlueprintAccessor.
			'accessing'.
			'deletedBlueprintAccessor ^ types'}.
		{#deletedBlueprintHelper.
			'private'.
			'deletedBlueprintHelper ^ 42'}}
		do: [ :spec | 
			node
				addChild: (IceRemoval
						definition: (IceMethodDefinition
								className: #GtClassBlueprint
								classIsMeta: false
								protocol: spec second
								name: spec first
								sourceCode: spec third)) ].
	element := (GtClassBlueprintDiff on: node) asElement.
	classLayers := element children first children second children.
	actualLayers := OrderedCollection new.
	layersByMethod := Dictionary new.
	classLayers
		do: [ :layer | 
			| name |
			name := layer children first text asString.
			actualLayers add: name.
			layer
				allChildrenBreadthFirstDo: [ :child | 
					| method |
					method := child graph model.
					(method isKindOf: IceMethodDefinition)
						ifTrue: [ layersByMethod at: method selector put: name ] ] ].
	self
		assert: actualLayers asArray
		equals: #('Initializers' 'Interface' 'Internal' 'Accessors' 'Slots').
	self
		assert: layersByMethod
		equals: (Dictionary
				newFrom: {#deletedBlueprintInitializer -> 'Initializers'.
						#deletedBlueprintExample -> 'Interface'.
						#deletedBlueprintHelper -> 'Internal'.
						#deletedBlueprintAccessor -> 'Accessors'}).
	^ element
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> methodChangeColors [
	<gtExample>
	<return: #BlElement>
	| node element expectedColors actualColors |
	node := self classChangeNode.
	{IceAddition -> #widthOfMethod:.
		IceRemoval -> #heightOfMethod:}
		do: [ :entry | 
			| method definition |
			method := GtClassBlueprint >> entry value.
			definition := IceMethodDefinition
					className: #GtClassBlueprint
					classIsMeta: false
					protocol: method protocolName
					name: method selector
					sourceCode: method sourceCode.
			node addChild: (entry key definition: definition) ].
	element := (GtClassBlueprintDiff on: node) asElement.
	expectedColors := Dictionary
			newFrom: {#widthOfMethod:
						-> {BrAntColors green6.
								BrAntColors green1}.
					#heightOfMethod:
						-> {BrAntColors red6.
								BrAntColors red1}.
					#minimumNodeSize
						-> {BrAntColors blue6.
								BrAntColors blue1}}.
	actualColors := Dictionary new.
	element
		allChildrenBreadthFirstDo: [ :child | 
			| method |
			method := child graph model.
			(method isKindOf: CompiledMethod)
				ifTrue: [ actualColors
						at: method selector
						put: {child border paint color.
								child background paint color} ] ].
	self assert: actualColors notEmpty.
	self assert: actualColors keys asSet equals: GtClassBlueprint selectors asSet.
	actualColors
		keysAndValuesDo: [ :selector :colors | 
			self
				assert: colors
				equals: (expectedColors
						at: selector
						ifAbsent: [ {BrAntColors gray6.
								BrAntColors gray2} ]) ].
	^ element
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> recoverDeletedMethod [
	<gtExample>
	<return: #IceNode>
	| classNode selector oldSource oldMethod blueprint methodNode |
	classNode := self classChangeNode.
	selector := #deletedBlueprintExample.
	oldSource := 'deletedBlueprintExample
	^ 42'.
	self assert: (classNode definition actualClass lookupSelector: selector) isNil.
	oldMethod := IceMethodDefinition
			className: classNode definition name
			classIsMeta: false
			protocol: 'examples'
			name: selector
			sourceCode: oldSource.
	classNode addChild: (IceRemoval definition: oldMethod).
	blueprint := GtClassBlueprintDiff on: classNode.
	methodNode := blueprint methodNodesBySelector at: selector.
	self assert: methodNode value isRemoval.
	self assert: methodNode definition sourceCode equals: oldSource.
	^ methodNode
]

{ #category : #examples }
GtClassBlueprintDiffExamples >> slotChangeColors [
	<gtExample>
	<return: #BlElement>
	| element actualColors expectedColors |
	element := (GtClassBlueprintDiff on: self slotChangeNode) asElement.
	actualColors := Dictionary new.
	element
		allChildrenBreadthFirstDo: [ :child | 
			| slot |
			slot := child graph model.
			((slot isKindOf: Slot) or: [ slot isKindOf: MCVariableDefinition ])
				ifTrue: [ actualColors
						at: slot name asSymbol
						put: {child border paint color.
								child background paint color} ] ].
	expectedColors := Dictionary new.
	GtClassBlueprint slots
		do: [ :slot | 
			expectedColors
				at: slot name
				put: {BrAntColors gray6.
						BrAntColors gray2} ].
	expectedColors
		at: #methodsToElements
			put: {BrAntColors green6.
					BrAntColors green1};
		at: #addedExampleSlot
			put: {BrAntColors green6.
					BrAntColors green1};
		at: #removedExampleSlot
			put: {BrAntColors red6.
					BrAntColors red1};
		at: #types
			put: {BrAntColors blue6.
					BrAntColors blue1}.
	self assert: actualColors equals: expectedColors.
	^ element
]

{ #category : #private }
GtClassBlueprintDiffExamples >> slotChangeNode [
	| before after oldDefinition newDefinition |
	newDefinition := GtClassBlueprint asClassDefinition.
	oldDefinition := newDefinition deepCopy.
	oldDefinition variables
		remove: (oldDefinition variables
				detect: [ :variable | variable isInstanceVariable and: [ variable name = 'methodsToElements' ] ]).
	oldDefinition variables
		remove: (oldDefinition variables
				detect: [ :variable | variable isInstanceVariable and: [ variable name = 'types' ] ]).
	oldDefinition instVarNames: #(removedExampleSlot '#types => PropertySlot').
	newDefinition instVarNames: #(addedExampleSlot).
	after := (IceClassDefinition named: #GtClassBlueprint isMeta: false)
			mcDefinition: newDefinition.
	before := after copy mcDefinition: oldDefinition.
	^ IceNode value: (IceModification left: after right: before)
]
