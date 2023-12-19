Extension { #name : #AsyncCachedFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncCachedFuture >> gtCompositionChildren [

	^ { future }
]

{ #category : #'*GToolkit-Extensions' }
AsyncCachedFuture >> gtCompositionDescription [
	| aText |
	aText := self printString asRopedText.
	cache ifNil: [ ^ aText ].
	cache
		ifSome: [ :aValue | 
			aText
				append: (' cache=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
				append: (aValue gtDisplayText foreground: BrGlamorousColors disabledButtonTextColor) ]
		ifNone: [ aText
				append: (' no cached value' asRopedText foreground: BrGlamorousColors disabledButtonTextColor) ].

	^ aText
]
