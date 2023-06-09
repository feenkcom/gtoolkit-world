Class {
	#name : #GtButtonsDefiningActionsThroughModels,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtButtonsDefiningActionsThroughModels >> description [
	^ 'Button action is defined through the model instead of the button'
]

{ #category : #accessing }
GtButtonsDefiningActionsThroughModels >> issues [
	^ '`@a addViewModel: (BrButtonModel new action: [:`var | | `@temps | `@.Stmts ])'
		gtASTMatches result toArray wait
]

{ #category : #accessing }
GtButtonsDefiningActionsThroughModels >> name [
	^ 'Button action is defined through the model'
]
