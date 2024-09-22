Extension { #name : #AsyncCollectionSink }

{ #category : #'*Gtoolkit-Extensions' }
AsyncCollectionSink >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: (self collection size asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (' items' asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]

{ #category : #'*Gtoolkit-Extensions' }
AsyncCollectionSink >> gtItemsFor: aView [
	<gtView>
	collection ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Items';
		object: [ collection ];
		view: #gtItemsFor:
]
