Extension { #name : #AsyncStreamBufferSentSink }

{ #category : #'*Gtoolkit-Extensions' }
AsyncStreamBufferSentSink >> gtCompositionChildren [
	^ { streamBuffer }
]

{ #category : #'*Gtoolkit-Extensions' }
AsyncStreamBufferSentSink >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('loaded amount=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (loadedAmount printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
