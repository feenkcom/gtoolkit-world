Extension { #name : #BrMenuItem }

{ #category : #'*GToolkit-Extensions' }
BrMenuItem >> gtItemSelection [
	^ self isSelected
		ifTrue: [ 'selected' ]
		ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
]
