Extension { #name : #AsyncMapFutureStream }

{ #category : #'*GToolkit-Extensions' }
AsyncMapFutureStream >> gtCompositionChildren [

	^ { stream } 
]

{ #category : #'*GToolkit-Extensions' }
AsyncMapFutureStream >> gtCompositionDescription [

	^ self printString asRopedText 
		  append: ': ' asRopedText;
		  append: (mapBlock printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
