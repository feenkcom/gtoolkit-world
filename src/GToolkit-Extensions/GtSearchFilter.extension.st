Extension { #name : #GtSearchFilter }

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> children [
	<return: #Collection of: #GtSearchFilter>
	^ Array empty
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtAreAllGtSearchMethodsFilterKind [
	^ false
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter class >> gtHierarchyFor: aView [
	<gtView>
	<gtClassView>
	^ aView mondrian
		title: 'Hierarchy';
		priority: 10;
		painting: [ :m | 
			m nodes 
				stencil: [ :eachClass | 
					| anExpander text |
					text := (eachClass = GtSearchFilter 
								ifTrue: ['Filter']
								ifFalse: [ 
									(eachClass name gtRemovePrefix: 'GtSearch') 
										gtRemoveSuffix: 'Filter' ])
									asRopedText 
									glamorousRegularFont;
									fontSize: 18.
					anExpander := BrExpander new.
					anExpander vFitContent; hExact: 300.
					anExpander aptitude: GtCoderExpanderAptitude new.
					anExpander header: [ BlTextElement new 
						padding: (BlInsets left: 5 right: 5);
						text: text ].
					anExpander content: [ 
						| container methods |
						container := BlElement new
							layout: BlLinearLayout vertical;
							constraintsDo: [ :c | c vertical fitContent. c horizontal fitContent].
						container addChild: (BlTextElement new 
							padding: (BlInsets left: 5 right: 5);
							text: text).
						methods := eachClass = GtSearchFilter 
							ifTrue: [ (GtSearchFilter methods select: #isOverridden) ]
							ifFalse: [ eachClass methods select: [:method | 
								method gtIsOverridingUpTo: GtSearchFilter ] ].
						methods do: [:aMethod | 
							container addChild: ((GtPharoMethodCoder forMethod: aMethod) asElement)].
						container ].
					anExpander margin: (BlInsets all: 10).
						 ];
				with: self withAllSubclasses.
			m edges 
				stencil: [ :each |
					BlLineElement new 
						zIndex: -1;
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
						fromHead: (BlArrowheadTriangle new scale: 4; background: Color white;
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 1))];
				fromRightCenter;
				toLeftCenter;
				connectFrom: #superclass.
			m layout explicit: (GtGraphHorizontalTreeLayout new layered horizontalGap: 20; verticalGap: 10).
			]
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtHierarchyFor: aView [
	<gtView>
	^ aView tree
		title: 'Hierarchy';
		priority: 80;
		items: [ { self } ];
		children: [ :aFilter | aFilter children ];
		expandUpTo: 2
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtItemsByClassFor: aView [
	<gtView>
	<gtToolView>

	self gtAreAllGtSearchMethodsFilterKind ifFalse: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'By Class';
		priority: 44;
		withMultipleSelection;
		items: [ 
			((self & GtSearchImageMethodsFilter new) result 
				asyncSimilarCopy toArray wait 
				groupedBy: [ :aCompiledMethod | aCompiledMethod methodClass ])
				associations sorted: [ :assoc | assoc key name ] ascending ];
		column: 'Class' do: [ :aColumn |
			aColumn
				cellStencil: [ 
					GtPhlowLabelWithIcon new ];
				dataBinder: [ :anElement :assoc | 
					anElement updateForClass: assoc key ] ];
		column: 'Items' text: [ :assoc | assoc value size ];
		send: [ :oneOrMoreAssociations :selectionIndexes |
			selectionIndexes size = 1
				ifTrue: [ GtSearchFixedMethodsFilter new 
					withDefinedMethodsFrom: oneOrMoreAssociations value ;
					highlighter: self highlighter;
					label: self gtDisplayString
						, ' & '
						, oneOrMoreAssociations key name, ' class' ]
				ifFalse: [
					GtSearchFixedMethodsFilter new 
						withDefinedMethodsFrom: (oneOrMoreAssociations
							flatCollect: [ :each | each value])  ;
						highlighter: self highlighter;
						label: self gtDisplayString
							, ' & ('
							, (String streamContents: [ :s | 
								(oneOrMoreAssociations collect: [ :each | each key name])
									asStringOn: s delimiter: ' | ' ])
							, ') classes'] ]
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtItemsByMethodFor: aView [
	<gtView>
	<gtToolView>
	
	self gtAreAllGtSearchMethodsFilterKind ifFalse: [^aView empty].
	
	^(aView columnedList)
		title: 'By Method';
		priority: 45;
		withMultipleSelection;
		items: [
			self result asyncSimilarCopy toArray wait
				sorted: [:assoc | assoc selector] ascending];
		column: 'Method'
			do: [:aColumn |
				aColumn
					cellStencil: [GtPhlowLabelWithIcon new];
					dataBinder: [:anElement :aMethod |
						anElement updateForMethod: aMethod ] ];
		send: [:oneOrMoreMethods :selectionIndexes |
			selectionIndexes size = 1
				ifTrue: [
					oneOrMoreMethods methodReference
						gtHighlighter: self highlighter;
						yourself ]
				ifFalse: [
					(GtRGMethodDefinitionWithComparisonGroup 
						withAll: (oneOrMoreMethods collect: [ :aMethod |
								aMethod methodReference
									gtHighlighter: self highlighter;
									yourself ]))
							highlighter: self highlighter ] ]
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtItemsByPackageFor: aView [
	<gtView>
	<gtToolView>

	self gtAreAllGtSearchMethodsFilterKind ifFalse: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'By Package';
		priority: 43;
		withMultipleSelection;
		items: [ 
			((self & GtSearchImageMethodsFilter new) result 
				asyncSimilarCopy toArray wait 
				groupedBy: [ :aCompiledMethod | aCompiledMethod package ])
				associations sorted: [ :assoc | 
					assoc key 
						ifNil: [ '' ] 
						ifNotNil: [:aPackage | aPackage name] ] ascending ];
		column: 'Package' do: [ :aColumn |
			aColumn
				cellStencil: [ 
					GtPhlowLabelWithIcon new ];
				dataBinder: [ :anElement :assoc | 
					anElement 
						initializeWithIcon: (self 
							gtSafeIconNamed: #package)
						label: (assoc key 
							ifNil: [ '<Obsolete>' ] 
							ifNotNil: [:aPackage | aPackage name ] ) ] ];
		column: 'Items' text: [ :assoc | assoc value size ];
		send: [ :oneOrMoreAssociations :selectionIndexes |
			selectionIndexes size = 1
				ifTrue: [GtSearchFixedMethodsFilter new 
					withDefinedMethodsFrom: oneOrMoreAssociations value ;
					highlighter: self highlighter;
					label: (self gtDisplayString
						, ' & '
						, (oneOrMoreAssociations key 
							ifNil: [ '<Obsolete>' ] 
							ifNotNil: [:aPackage | aPackage name ])
						, ' package')]
				ifFalse: [GtSearchFixedMethodsFilter new 
					withDefinedMethodsFrom: (oneOrMoreAssociations
						flatCollect: [ :each | each value]) ;
					highlighter: self highlighter;
					label: (self gtDisplayString
						, ' & ('
						, (String streamContents: [ :s | 
								(oneOrMoreAssociations collect: [ :each |
									each key 
										ifNil: [ '<Obsolete>' ] 
										ifNotNil: [:aPackage | aPackage name ]])
									asStringOn: s delimiter: ' | ' ])
						, ') packages')] ] 
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtItemsFor: aView [
	"this is a view that is polymorphic with the one defined in ${method:Collection>>#gtItemsFor:}$"
	<gtView>
	<gtToolView>

	^ aView forward
		title: 'Results';
		priority: 10;
		object: [ self result ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtMetricsFor: aView [
	<gtView>

	^ aView forward
		  title: 'Metrics';
		  priority: 15;
		  object: [ self result ];
		  view: #gtMetricsFor:
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> methodPackages [

	| aResult |
	aResult := OrderedCollection new.

	self do: [ :eachMethod | 
		| aSearchPackage aMethodPackage |
		aMethodPackage := eachMethod package.

		(aResult anySatisfy: [ :eachSearchPackage | 
			 eachSearchPackage package = aMethodPackage ]) ifFalse: [ 
			aSearchPackage := GtSearchPackage new
				                  package: aMethodPackage;
				                  group: self.
			aResult add: aSearchPackage ] ].
			
	^ aResult
]
