Class {
	#name : #GtClassWithCommentsContainingMissingReferences,
	#superclass : #GtPharoConstraint,
	#traits : 'TLeInvalidCommentsConstraint',
	#classTraits : 'TLeInvalidCommentsConstraint classTrait',
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> description [
	^ 'All references from class comments should be present in the image.'
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> gtViewReferencesFor: aView [ 
	<gtView>
	^ aView forward 
		title: 'Missing references by class';
		priority: 20;
		object: [ self issues ];
		view: #gtViewReferencesFor:
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> name [
	^ 'Classes with comments containing missing references'
]

{ #category : #accessing }
GtClassWithCommentsContainingMissingReferences >> packagesToAnalyse [
	"We reject Magritte-Model because {{gtClass: MACompositeAccessor}} includes a link to a method that we do not load in GToolkit."

	^ BaselineOfGToolkit gtRlAllValidRPackages
		reject: [ :each | each name = 'Magritte-Model' ]
]
