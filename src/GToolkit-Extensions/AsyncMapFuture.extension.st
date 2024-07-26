Extension { #name : #AsyncMapFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncMapFuture >> gtCompositionChildren [

	^ { future }
]

{ #category : #'*GToolkit-Extensions' }
AsyncMapFuture >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: (mapBlock printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]

{ #category : #'*GToolkit-Extensions' }
AsyncMapFuture >> gtMapBlockFor: aView [
	<gtView>
	mapBlock ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Map block';
		object: [ mapBlock ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncMapFuture >> gtVariablesFor: aView [
	<gtView>
	mapBlock ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Variables';
		object: [ mapBlock ];
		view: #gtVariablesFor:
]
