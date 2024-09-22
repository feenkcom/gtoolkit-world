Extension { #name : #AsyncPollFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncPollFuture >> gtCompositionDescription [
	| aText anExtraText |
	aText := self printString asRopedText append: ': ' asRopedText.

	anExtraText := executedBlock 
		ifNil: [ 'pending, ' asRopedText ] 
		ifNotNil: [ 'executed, ' asRopedText ].
	anExtraText
		append: (pollBlock ifNil: [ executedBlock ]) printString asRopedText.
	anExtraText foreground: BrGlamorousColors disabledButtonTextColor.
	aText append: anExtraText.
	^ aText
]

{ #category : #'*GToolkit-Extensions' }
AsyncPollFuture >> gtSourceCodeFor: aView [
	<gtView>
	pollBlock ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source code';
		object: [ pollBlock ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncPollFuture >> gtViewExecutedBlockFor: aView [
	<gtView>
	executedBlock ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Executed block';
		object: [ executedBlock ];
		view: #gtSourceCodeFor:
]
