Extension { #name : #AsyncSpreadSink }

{ #category : #'*Gtoolkit-Extensions' }
AsyncSpreadSink >> gtCompositionChildren [
	^ sinks
]

{ #category : #'*Gtoolkit-Extensions' }
AsyncSpreadSink >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: (sinks size asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: ((' sink' asPluralBasedOn: sinks) asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
