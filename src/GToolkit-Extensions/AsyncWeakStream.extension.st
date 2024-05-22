Extension { #name : #AsyncWeakStream }

{ #category : #'*GToolkit-Extensions' }
AsyncWeakStream >> gtCompositionChildren [

	^ stream first
		ifNil: [ #() ]
		ifNotNil: [ :aStream | { aStream } ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncWeakStream >> gtCompositionDescription [
	| aStream |
	aStream := stream first ifNotNil: [ :theStream | theStream ].

	^ self printString asRopedText
		append: ': ' asRopedText;
		append: (('stream={1}' format: {aStream}) asRopedText
				foreground: BrGlamorousColors disabledButtonTextColor)
]
