Extension { #name : #AsyncWithoutDuplicatesStream }

{ #category : #'*GToolkit-Extensions' }
AsyncWithoutDuplicatesStream >> gtCompositionChildren [

	^ { stream } 
]

{ #category : #'*GToolkit-Extensions' }
AsyncWithoutDuplicatesStream >> gtCompositionDescription [

	| aString |
	aString := self printString asRopedText append: ': ' asRopedText.
	comparisonBlock ifNotNil: [ 
		aString append:
			(comparisonBlock printString asRopedText foreground:
				 BrGlamorousColors disabledButtonTextColor) ].
	^ aString
]

{ #category : #'*GToolkit-Extensions' }
AsyncWithoutDuplicatesStream >> useContentComparison [
	setClass := GtStringContentSet.
	seenItems ifNotNil: [ seenItems := setClass withAll: seenItems ]
]
