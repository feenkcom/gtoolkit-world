Extension { #name : #AsyncForkPollFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncForkPollFuture >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ((pollBlock ifNil: [ executedBlock ]) printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]

{ #category : #'*GToolkit-Extensions' }
AsyncForkPollFuture >> gtSourceCodeFor: aView [
	<gtView>
	pollBlock ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source code';
		object: [ pollBlock ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncForkPollFuture >> gtViewExecutedBlockFor: aView [
	<gtView>
	executedBlock ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Executed block';
		object: [ executedBlock ];
		view: #gtSourceCodeFor:
]
