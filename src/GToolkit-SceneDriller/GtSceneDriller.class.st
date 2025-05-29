Class {
	#name : #GtSceneDriller,
	#superclass : #BrPager,
	#instVars : [
		'targetContainer',
		'selectedElement',
		'inspector',
		'elementsTree'
	],
	#category : #'GToolkit-SceneDriller-UI'
}

{ #category : #'private - tree' }
GtSceneDriller >> bindElementTreeValue: eachElement toRowElement: aRowElement [	
	aRowElement
		childWithId: #elementLabel
		ifFound: [ :anElementLabel | anElementLabel text: eachElement class name ]
		ifNone: [  ].

	aRowElement
		childWithId: #elementId
		ifFound: [ :anElementIdButton |
			eachElement id = BlElementId noId
				ifTrue: [
					anElementIdButton model: nil.
					anElementIdButton label: ''.
					anElementIdButton visibility: BlVisibility gone ]
				ifFalse: [
					anElementIdButton model: eachElement id.
					anElementIdButton label: eachElement id asSymbol printString.
					anElementIdButton visibility: BlVisibility visible
				] ]
		ifNone: [  ].

	aRowElement
		childWithId: #elementResizers
		ifFound: [ :anElementResizersLabel |
			anElementResizersLabel text: (String streamContents: [ :aStream |
				aStream
					nextPutAll: 'h: ';
					nextPutAll: eachElement constraints horizontal resizer asString asLowercase;
					nextPutAll: '   ';
					nextPutAll: 'v: ';
					nextPutAll: eachElement constraints vertical resizer asString asLowercase
			]) ]
		ifNone: [  ].
		
	self bindElementTreeValuePhlowContext: eachElement toRowElement: aRowElement.
	self bindElementTreeValueWhenAddedToSceneGraph: eachElement toRowElement: aRowElement
]

{ #category : #'private - tree' }
GtSceneDriller >> bindElementTreeValuePhlowContext: eachElement toRowElement: aRowElement [ 
	aRowElement
		childWithId: #phlowContext
		ifFound: [ :anPhlowContextButton | 
			((eachElement userData includesKey: #phlow)  and: [
				eachElement phlow hasActivePhlowContexts])
			ifTrue: [
				anPhlowContextButton model: eachElement phlow.
				anPhlowContextButton label: ('phlow: ', eachElement phlow activePhlowContextsDescription).
				anPhlowContextButton visibility: BlVisibility visible]
			ifFalse: [
				anPhlowContextButton model: nil.
				anPhlowContextButton label: ''.
				anPhlowContextButton visibility: BlVisibility gone ] ]
		ifNone: [  ].
]

{ #category : #'private - tree' }
GtSceneDriller >> bindElementTreeValueWhenAddedToSceneGraph: eachElement toRowElement: aRowElement [
	aRowElement
		childWithId: #whenAddedToSceneGraph
		ifFound: [ :anElementIdButton |
			| anOverridenMethod isOverriden eventHandlers|
			
			anOverridenMethod := eachElement class lookupSelector: #onAddedToSceneGraph.
			isOverriden := anOverridenMethod
				ifNil: [ false ]
				ifNotNil: [ :aMethod | aMethod methodClass ~= BlElement ].
				
			eventHandlers := Array
				streamContents: [ :aStream |
					eachElement eventDispatcher
						handlersDo: [ :eachEventHandler |
							(self doesEventHandler: eachEventHandler want: BlElementAddedToSceneGraphEvent)
								ifTrue: [ aStream nextPut: eachEventHandler ] ];
						filtersDo: [ :eachEventHandler |
							(self doesEventHandler: eachEventHandler want: BlElementAddedToSceneGraphEvent)
								ifTrue: [ aStream nextPut: eachEventHandler ] ] ].

			(isOverriden not and: [ eventHandlers isEmpty ])
				ifTrue: [
					anElementIdButton model: nil.
					anElementIdButton label: ''.
					anElementIdButton visibility: BlVisibility gone ]
				ifFalse: [
					| aLabel aModel |
				
					aLabel := String streamContents: [ :aStream |
						isOverriden
							ifTrue: [ aStream nextPutAll: '#onAddedToSceneGraph' ].
						eventHandlers ifNotEmpty: [ :theHandlers |
							isOverriden ifTrue: [ aStream nextPutAll: ' and ' ].
							aStream
								print: theHandlers size;
								space;
								nextPutAll: 'AddedToSceneGraph event handlers' ] ].
					
					(isOverriden and: [ eventHandlers isNotEmpty ])
						ifTrue: [ aModel := OrderedDictionary new
							at: anOverridenMethod  printString put: anOverridenMethod;
							at: 'AddedToSceneGraph event handlers' put: eventHandlers;
							yourself ].
							
					(isOverriden and: [ eventHandlers isEmpty ])
						ifTrue: [ aModel := anOverridenMethod ].
					
					(isOverriden not and: [ eventHandlers isNotEmpty ])
						ifTrue: [ aModel := eventHandlers ].
				
					anElementIdButton model: aModel.
					anElementIdButton label: aLabel.
					anElementIdButton visibility: BlVisibility visible
				] ]
		ifNone: [  ].
]

{ #category : #'private - tree' }
GtSceneDriller >> doesEventHandler: anEventHandler want: anEventClass [
	<return: #Boolean>

	((anEventHandler isKindOf: BlEventHandler) and: [ anEventHandler eventClass = anEventClass ])
		ifTrue: [ ^ true ].
		
	(anEventHandler isKindOf: BlEventForwarder)
		ifTrue: [ ^ self doesEventHandler: anEventHandler eventHandler want: anEventClass ].
		
	^ false
]

{ #category : #initialization }
GtSceneDriller >> initialize [
	super initialize.
	self
		matchParent;
		background: self theme header defaultBackgroundColor;
		aptitude: BrProportionalHorizontalPagerAptitude new
]

{ #category : #initialization }
GtSceneDriller >> initializeWith: aTargetContainer [
	targetContainer := aTargetContainer.

	self addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		layout: BlLinearLayout vertical alignCenter;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 0.4 ];
		addChild: (self newSceneContainerFor: aTargetContainer)).
		
	self addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 0.6 ];
		addChild: (self newPagerFor: aTargetContainer)).

	self addChildren: { 
		self newCloseButtonFor: aTargetContainer }
]

{ #category : #accessing }
GtSceneDriller >> inspectElement: anElement [
	selectedElement == anElement
		ifTrue: [ ^ self ].

	selectedElement := anElement.
	elementsTree phlow spawnObject: selectedElement
]

{ #category : #'instance creation' }
GtSceneDriller >> newCloseButtonFor: aTargetContainer [
	^ BrButton new
		aptitude: BrGlamorousButtonCircularAptitude + BrGlamorousButtonIconAptitude + BrGlamorousButtonFlatExteriorAptitude + BrGlamorousButtonLayoutAptitude;
		icon: [ (BrGlamorousVectorIcons close asElement
				outskirts: BlOutskirts centered;
				background: Color gray;
				border: (BlBorder paint: Color transparent width: 0.8)) ] asStencil;
		beLargeSize;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignTop.
			c margin: (BlInsets top: 5) ];
		action: [ :e | e fireEvent: GtSceneDrillerHideWish new ]
]

{ #category : #'instance creation' }
GtSceneDriller >> newElementsTree [	
	^ BrSimpleTree new
		matchParent;
		padding: (BlInsets top: 5);
		rowStencil: (GtSceneDrillerTreeRowStencilBuilder new
			whenHovered: [ :anEvent |
				| thisRow thisRowValue |
				
				thisRow := anEvent currentTarget.
				thisRowValue := (elementsTree nodeAt: thisRow constraints infinite holder dataSourcePosition) value.
				thisRow fireEvent: (GtSceneDrillerHighlightElementWish new element: thisRowValue) ];
			whenUnhovered: [ :anEvent | anEvent currentTarget fireEvent: (GtSceneDrillerHideHighlightWish new) ]);
		addEventHandler: (GtPhlowListToSelectHandler new transformation: (GtPhlowSendTransformation object: [ :aTreeNode | aTreeNode value ]));
		when: GtPhlowObjectEvent do: [ :anEvent |
			"only visual elements can be selected in a driller"
			(anEvent object isKindOf: BlElement)
				ifTrue: [ self fireEvent: (GtSceneDrillerSelectElementWish new element: anEvent object) ] ];
		nodeStencil: [ self newTreeRowElement ];
		nodeDataBinder: [ :eachLabel :eachElement | self bindElementTreeValue: eachElement toRowElement: eachLabel ];
		yourself
]

{ #category : #'instance creation' }
GtSceneDriller >> newPagerFor: aTargetContainer [
	^ BrVerticalPane new
		matchParent;
		constraintsDo: [ :c | c linear weight: 0.7 ];
		padding:
			(BlInsets
				top: 10
				left: 10
				bottom: 10
				right: 0);
		addAptitude: BrShadowAptitude new beLarge;
		background: self theme default backdropBackground;
		addChildren:
			{(self newSectionLabel text: 'Details').
			((GtPager
				createWrappedOn:
					(BrVerticalPane new
						matchParent;
						addChild:
							(BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								hMatchParent;
								padding:
									(BlInsets
										top: 10.0
										right: 12.0
										bottom: 10.0
										left: 12.0);
								background: self theme header defaultBackgroundColor;
								text: 'Elements');
						addChild: (elementsTree := self newElementsTree)))
				id: '#gtoolkit-driller--pager')}
]

{ #category : #'instance creation' }
GtSceneDriller >> newSceneContainerFor: aTargetContainer [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent;
		constraintsDo: [ :c | c linear weight: 0.3 ];
		padding: (BlInsets all: 20);
		addChildren:
			{(self newSectionLabel text: 'Scene').
			(BlElement new
				height: 10;
				width: 0).
			(BlScalableElement new
				fitWidth;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent ];
				addAptitude:
					(BrShadowAptitude new beLarge
						color:
							self theme default defaultShadowColor darker);
				background: self theme default contentBackground;
				addChild: aTargetContainer)}
]

{ #category : #'instance creation' }
GtSceneDriller >> newSectionLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray)
]

{ #category : #'private - tree' }
GtSceneDriller >> newTreeRowElement [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		addChildren: {
			BrLabel new
				beSmallSize;
				id: #elementLabel;
				aptitude: BrGlamorousLabelAptitude new.
			BrButton new
				beTinySize;
				id: #elementId;
				aptitude: (BrGlamorousButtonLabelAptitude new
							hoveredColor: Color black;
							pressedColor: Color black) +
						(BrGlamorousButtonRectangularAptitude
							paddingScale: 0.8
							heightScale: 0.85
							cornerRadius: 3) + (BrStyleCommonAptitude new
					default: [ :s | s background: (Color gray alpha: 0.1) ];
					hovered: [ :s | s background: (Color gray alpha: 0.2) ];
					pressed: [ :s | s background: (Color gray alpha: 0.3) ]);
				action: [ :aButtonElement | aButtonElement phlow spawnObject: aButtonElement model ].
			BrLabel new
				beSmallSize;
				id: #elementResizers;
				aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray).
			BrButton new
				beTinySize;
				id: #phlowContext;
				aptitude: (BrGlamorousButtonLabelAptitude new
							hoveredColor: Color black;
							pressedColor: Color black) +
						(BrGlamorousButtonRectangularAptitude
							paddingScale: 0.8
							heightScale: 0.85
							cornerRadius: 3) + (BrStyleCommonAptitude new
					default: [ :s | s background: (Color gray alpha: 0.1) ];
					hovered: [ :s | s background: (Color gray alpha: 0.2) ];
					pressed: [ :s | s background: (Color gray alpha: 0.3) ]);
				action: [ :aButtonElement | aButtonElement phlow spawnObject: aButtonElement model ].
			BrButton new
				beTinySize;
				id: #whenAddedToSceneGraph;
				aptitude: (BrGlamorousButtonLabelAptitude new
							hoveredColor: Color black;
							pressedColor: Color black) +
						(BrGlamorousButtonRectangularAptitude
							paddingScale: 0.8
							heightScale: 0.85
							cornerRadius: 3) + (BrStyleCommonAptitude new
					default: [ :s | s background: (self theme  status failureBackgroundColor alpha: 0.6) ];
					hovered: [ :s | s background: (self theme  status failureBackgroundColor alpha: 0.8) ];
					pressed: [ :s | s background: (self theme  status failureBackgroundColor alpha: 1.0) ]);
				action: [ :aButtonElement | aButtonElement phlow spawnObject: aButtonElement model ] }
]

{ #category : #accessing }
GtSceneDriller >> selectElement: anElement [
	| wasNil |
	selectedElement == anElement
		ifTrue: [ ^ self ].
	
	wasNil := selectedElement isNil.
	selectedElement := anElement.
	
	elementsTree items: targetContainer children lazy: [ :each | each children ].
	elementsTree expandSuchThat: [ :aTreeNode | (selectedElement hasParent: aTreeNode value) or: [ selectedElement == aTreeNode value ] ].
	elementsTree selectAndScrollTo: selectedElement.
	elementsTree phlow spawnObject: selectedElement.
	
	wasNil ifTrue: [
		self
			childWithId: '#gtoolkit-driller--pager'
			ifFound: [ :aPager |
				aPager maximizePageContentIn: aPager pages first contentElement ]
			ifNone: [  ] ]
]

{ #category : #accessing }
GtSceneDriller >> targetContainer [
	^ targetContainer
]
