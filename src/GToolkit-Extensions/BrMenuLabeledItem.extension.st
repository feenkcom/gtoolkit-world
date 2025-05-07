Extension { #name : #BrMenuLabeledItem }

{ #category : #'*GToolkit-Extensions' }
BrMenuLabeledItem >> gtItemLabel [
	^ self labelModel ifNotNil: #gtItemLabel
]
