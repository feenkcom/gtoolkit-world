Extension { #name : #AsyncTerminatableStream }

{ #category : #'*GToolkit-Extensions' }
AsyncTerminatableStream >> gtCompositionChildren [

	^ { stream }
]

{ #category : #'*GToolkit-Extensions' }
AsyncTerminatableStream >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('terminated=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (isTerminated printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
