Extension { #name : #AsyncPausableSink }

{ #category : #'*Gtoolkit-Extensions' }
AsyncPausableSink >> gtCompositionChildren [
	^ { sink }
]

{ #category : #'*Gtoolkit-Extensions' }
AsyncPausableSink >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('remaining=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (remaining value printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
