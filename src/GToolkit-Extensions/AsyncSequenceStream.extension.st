Extension { #name : #AsyncSequenceStream }

{ #category : #'*GToolkit-Extensions' }
AsyncSequenceStream >> gtCompositionChildren [

	^ { collectionFuture }
]

{ #category : #'*GToolkit-Extensions' }
AsyncSequenceStream >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('done=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (done printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (', index=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (index printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (', collection=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: ((collection ifNotNil: [ :aCollection | aCollection size printString, (' item' asPluralBasedOn: aCollection size) ]) asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
