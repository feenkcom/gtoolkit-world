Extension { #name : #AsyncSplitStream }

{ #category : #'*GToolkit-Extensions' }
AsyncSplitStream >> gtCompositionChildren [

	^ { stream }
]

{ #category : #'*GToolkit-Extensions' }
AsyncSplitStream >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('by ' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (separatorCondition printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
