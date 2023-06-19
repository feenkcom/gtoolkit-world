Class {
	#name : #GtClassesShouldNotOverrideGtDisplayStringConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtClassesShouldNotOverrideGtDisplayStringConstraint >> issues [
	| implementors |
	implementors := #gtDisplayString gtImplementors contents.
	
	^ implementors copyWithout: (Object>>#gtDisplayString)
]

{ #category : #accessing }
GtClassesShouldNotOverrideGtDisplayStringConstraint >> name [
	^ 'Classes should not override gtDisplayString.'
]
