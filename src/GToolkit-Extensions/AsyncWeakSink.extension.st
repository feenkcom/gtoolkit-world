Extension { #name : #AsyncWeakSink }

{ #category : #'*Gtoolkit-Extensions' }
AsyncWeakSink >> gtCompositionChildren [
	^ sink first 
		ifNil: [ #() ]
		ifNotNil: [ :aSink | { aSink } ]
]

{ #category : #'*Gtoolkit-Extensions' }
AsyncWeakSink >> gtCompositionDescription [
	| aSink |
	aSink := sink first ifNotNil: [ :theStream | theStream ].

	^ self printString asRopedText
		append: ': ' asRopedText;
		append: (('sink={1}' format: {aSink}) asRopedText
				foreground: BrGlamorousColors disabledButtonTextColor)
]
