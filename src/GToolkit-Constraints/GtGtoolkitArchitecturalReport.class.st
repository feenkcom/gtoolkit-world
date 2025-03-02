"
Architectural report for Glamorous Toolkit. This  report works in either a released image or in an image created from sources.

"
Class {
	#name : #GtGtoolkitArchitecturalReport,
	#superclass : #GtConstrainerReport,
	#category : #'GToolkit-Constraints'
}

{ #category : #'gt - exte' }
GtGtoolkitArchitecturalReport class >> gtViewReportFor: aView [
	<gtView>
	<gtClassView>
	
	^ aView forward 
		title: 'Report';
		object: [ self new ];
		view: #gtItemsFor: 
]

{ #category : #accessing }
GtGtoolkitArchitecturalReport class >> yourself [
	<gtExample>
	^ self new
]

{ #category : #building }
GtGtoolkitArchitecturalReport >> build: aComposite [
	aComposite name: 'GToolkit Architectural Report'.
	aComposite
		addConstraint: GtClassWithCommentsContainingMissingReferences new;
		addConstraint: GtReturnPragmasShouldPointToExistingClasses new;
		addConstraint: GtRBAcceptVisitorCalledFromNonVisitingMethods  new;
		addConstraint: GtButtonsDefiningActionsThroughModels new;
		addConstraint: GtLooksSubscribingToEventsNotFromInitializeListenerMethods new;
		addConstraint: GtBlocEventsShouldHaveDispatchMethodSimilarToClass new;
		addConstraint: GtBlocStencilBuilderShouldImplementReset new;
		addConstraint: GtSubscriptionsShouldNotUseDeliveryConditionWhere new;
		addConstraint: GtWeakSubscriptionsWithBlockSubscribers new;
		addConstraint: GtGlamorousToolkitBookPagesContainingMissingReferences new;
		"addConstraint: GtBaselinesShouldProperlySpecifyDependencies new;"
		addConstraint: GSubclassesOfExternalObjectShouldImplementStartUp new;
		addConstraint: GtAnnouncementSubscriberShouldNotBeChanged new;
		addConstraint: GtBoxerExternalObjectsShouldOnlyImplementFFILibrary new;
		addConstraint: GtDoNotManuallyFindThisContextMethodDefinition new;
		addConstraint: GtPharoPackageDependenciesConstraint new;
		addConstraint: GtEqualsMethodsShouldReturnAValueConstraint new;
		addConstraint: GtHashMethodsShouldReturnAValueConstraint new;
		addConstraint: GtClassesImplementingEqualsShouldAlsoHaveHashConstraint new;
		addConstraint: GtClassesShouldNotOverrideGtDisplayStringConstraint new;
		addConstraint: GtMethodsWithUndeclaredVariablesConstraint new;
		addConstraint: GtSendersOfHaltSelectorsInGtPackagesConstraint new
]
