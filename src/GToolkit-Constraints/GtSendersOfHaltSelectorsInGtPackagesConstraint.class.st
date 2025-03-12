Class {
	#name : #GtSendersOfHaltSelectorsInGtPackagesConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #views }
GtSendersOfHaltSelectorsInGtPackagesConstraint class >> gtViewAllowedSendersOfHaltFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'Allowed Senders of halt (by package)';
		priority: 26;
		object: [ self new ];
		view: #gtViewAllowedSendersOfHaltFor:
]

{ #category : #views }
GtSendersOfHaltSelectorsInGtPackagesConstraint class >> gtViewWrongSendersOfHaltFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'Wrong Senders of halt (by package)';
		priority: 25;
		object: [ self new ];
		view: #gtViewWrongSendersOfHaltFor:
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint class >> haltSelectors [ 
	<gtIgnoreConstraint: #GtSendersOfHaltSelectorsInGtPackagesConstraint>
	
	^ #(#halt #halt: #haltIf: #haltIfTest #haltIfNotTest #haltOnce #haltFromCount: #haltOnCount: #haltIfNil).
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint class >> haltSendersFilter [
	| haltFilters |
	haltFilters := self haltSelectors collect: [ :aSelector |
		aSelector gtSenders ].
	^ haltFilters copyWithoutFirst
		inject: haltFilters first
		into: [ :compinedFilter :aFilter |
			compinedFilter | aFilter ].
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> allSendersOfHaltInGt [
	| gtPackages  |
	gtPackages := BaselineOfGToolkit gtRlAllValidRPackages.
	
	^self 
		wrapInExplicitFilter: (self class haltSendersFilter 
			select: [ :aMethod |
				gtPackages includes: aMethod package ])
		labeled: 'Wrong halt senders in GT'
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> allowedSendersOfHaltInGt [
	| allowedClasses allowedMethods |

	allowedClasses := self classesAllowedToSendHalt.
	allowedMethods := self methodsAllowedToSendHalt.
	
	^self 
		wrapInExplicitFilter: (self allSendersOfHaltInGt 
			select: [ :aMethod |
				(allowedClasses includes: aMethod methodClass) or: [
					(allowedMethods includes: aMethod) or: [
						self shouldIgnoreBasedOnMethodPragma: aMethod]  ] ])
		labeled: 'Allowed halt senders in GT'
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> classesAllowedToSendHalt [
	^ { TDAPProtocolVisitor . GtEpImageModelHasImpactVisitor }
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> description [
	^ 'Locate methods sending halt-related selectors in GT packages'
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> gtViewAllSendersOfHaltFor:aView [ 
	<gtView>
	^ aView tree
		title: 'All halt senders in GT (by package)';
		priority: 25;
		items: [ (self allSendersOfHaltInGt contents groupedBy: #package) associations
				sort: [ :a :b | a key name < b key name ] ];
		children: [ :anObject | (anObject isKindOf: Association) ifTrue: [ anObject value ] ifFalse: [ #() ] ];
		itemText: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ anObject key name asRopedText
						append: ((' {1} issues' format: {anObject value size}) asRopedText
								foreground: BrGlamorousColors disabledButtonTextColor) ]
				ifFalse: [ anObject ] ];
		send: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ anObject value size = 1
						ifTrue: [ anObject value first ]
						ifFalse: [ anObject value ] ]
				ifFalse: [ anObject ] ];
		actionUpdateButton;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Filters' 
			tooltip: 'Inspect the filters objects'
			action: [ :aButton |
				aButton phlow spawnObject: self allSendersOfHaltInGt ]
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> gtViewAllowedSendersOfHaltFor:aView [ 
	<gtView>
	^ aView tree
		title: 'Allowed halt senders in GT';
		priority: 25;
		items: [ (self allowedSendersOfHaltInGt contents groupedBy: #package) associations
				sort: [ :a :b | a key name < b key name ] ];
		children: [ :anObject | (anObject isKindOf: Association) ifTrue: [ anObject value ] ifFalse: [ #() ] ];
		itemText: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ anObject key name asRopedText
						append: ((' {1} issues' format: {anObject value size}) asRopedText
								foreground: BrGlamorousColors disabledButtonTextColor) ]
				ifFalse: [ anObject ] ];
		send: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ anObject value size = 1
						ifTrue: [ anObject value first ]
						ifFalse: [ anObject value ] ]
				ifFalse: [ anObject ] ];
		actionUpdateButton;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Filters' 
			tooltip: 'Inspect the filters objects'
			action: [ :aButton |
				aButton phlow spawnObject: self allSendersOfHaltInGt ]
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> gtViewWrongSendersOfHaltFor:aView [ 
	<gtView>
	^ aView tree
		title: 'Issues per package';
		priority: 5;
		items: [ (self issues groupedBy: #package) associations
				sort: [ :a :b | a key name < b key name ] ];
		children: [ :anObject | (anObject isKindOf: Association) ifTrue: [ anObject value ] ifFalse: [ #() ] ];
		itemText: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ anObject key name asRopedText
						append: ((' {1} issues' format: {anObject value size}) asRopedText
								foreground: BrGlamorousColors disabledButtonTextColor) ]
				ifFalse: [ anObject ] ];
		send: [ :anObject | 
			(anObject isKindOf: Association)
				ifTrue: [ anObject value size = 1
						ifTrue: [ anObject value first ]
						ifFalse: [ anObject value ] ]
				ifFalse: [ anObject ] ];
		actionUpdateButton;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Filters' 
			tooltip: 'Inspect the filters objects'
			action: [ :aButton |
				aButton phlow spawnObject: self wrongSendersOfHaltInGt ]
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> issues [
	^ self ignoreIssuesInMethodsBasedOnPragmas:self wrongSendersOfHaltInGt contents
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> methodsAllowedToSendHalt [
	"Ignored methods where we do not use gtIgnoreConstraint:"
	^ {
		GtPharoMethodExample>>#exampleWithNumber:.
		PP2AllNodesVisitor>>#children.
		PP2EventsTrace>>#filterEvents:.
		PP2WrappingStrategy>>#changeStrategy:}
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> name [
	^ 'Methods sending halt'
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> packagesToAnalyse [
	^ BaselineOfGToolkit gtRlAllValidRPackages
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> status [ 
	^ GtNeutralConstraintStatus new
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> wrapInExplicitFilter: aFilter labeled: aFilterLabel [

	^ GtSearchFixedMethodsFilter new 
		methods: aFilter contents;
		highlighter: aFilter highlighter;
		label: aFilterLabel 
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> wrongSendersOfHaltInGt [
	| allowedClasses allowedMethods |

	allowedClasses := self classesAllowedToSendHalt.
	allowedMethods := self methodsAllowedToSendHalt.
	
	^self 
		wrapInExplicitFilter: (self allSendersOfHaltInGt 
			select: [ :aMethod |
			(allowedClasses includes: aMethod methodClass) not and: [
				(allowedMethods includes: aMethod) not ] ])
		labeled: 'Wrong halt senders in GT'
]
