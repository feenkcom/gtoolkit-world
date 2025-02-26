Class {
	#name : #GtSendersOfHaltSelectorsInGtPackagesConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #views }
GtSendersOfHaltSelectorsInGtPackagesConstraint class >> gtViewSendersOfHaltFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'Senders of halt (by package)';
		priority: 25;
		object: [ self new ];
		view: #gtViewSendersOfHaltFor:
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> classesAllowedToSendHalt [
	^ #()
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> description [
	^ 'Locate methods sending halt-related selectors in GT packages'
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> gtViewSendersOfHaltFor:aView [ 
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
				aButton phlow spawnObject: self wrongSendersInGt ]
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> haltSelectors [ 
	^ #(#halt #halt: #haltIf: #haltOnce #haltIfNil #haltOnCount:).
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> haltSendersFilter [
	| haltFilters |
	haltFilters := self haltSelectors collect: [ :aSelector |
		aSelector gtSenders ].
	^ haltFilters copyWithoutFirst
		inject: haltFilters first
		into: [ :compinedFilter :aFilter |
			compinedFilter | aFilter ].
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> issues [
	^ self wrongSendersInGt contents
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> methodsAllowedToSendHalt [
	^ {
		self class >>#haltSelectors.
		GtGemStonePostMortemDebugger>>#defaultFrameOrdinalFrom:.
		GtRrSampleExample>>#haltExample.
		GtPharoMethodExample>>#exampleWithNumber:.
		GtHaltAdvice>>#haltSelectors}
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
GtSendersOfHaltSelectorsInGtPackagesConstraint >> wrapInExplicitFilter: aFilter [

	^ GtSearchFixedMethodsFilter new 
		methods: aFilter contents;
		highlighter: aFilter highlighter;
		label: 'Wrong halt senders in GT'
]

{ #category : #accessing }
GtSendersOfHaltSelectorsInGtPackagesConstraint >> wrongSendersInGt [
	| gtPackages allowedClasses allowedMethods |
	gtPackages := BaselineOfGToolkit gtRlAllValidRPackages.
	allowedClasses := self classesAllowedToSendHalt.
	allowedMethods := self methodsAllowedToSendHalt.
	
	^self wrapInExplicitFilter: ((self haltSendersFilter 
		select: [ :aMethod |
			gtPackages includes: aMethod package ]) 
		select: [ :aMethod |
			(allowedClasses includes: aMethod methodClass) not and: [
				(allowedMethods includes: aMethod) not ] ])
]
