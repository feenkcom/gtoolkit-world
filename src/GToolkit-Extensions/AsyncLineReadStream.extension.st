Extension { #name : #AsyncLineReadStream }

{ #category : #'*GToolkit-Extensions' }
AsyncLineReadStream >> gtCompositionChildren [

	^ { stream }
]

{ #category : #'*GToolkit-Extensions' }
AsyncLineReadStream >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('split by a line break (cr, lf, crlf)' asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
