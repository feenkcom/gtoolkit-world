Extension { #name : #MessageNotUnderstood }

{ #category : #'*GToolkit-Extensions' }
MessageNotUnderstood >> gtCalledMethodFor: aView [
	<gtView>
	<gtEmbeddedDebuggerView>
	self gtHasStack ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Caller';
		object: [ | aStack |
			aStack := self signalerContext stack.
			aStack
				detect: [ :aContext | aContext selector ~= #doesNotUnderstand: ]
				ifNone: [ aStack at: (2 min: aStack size) ] ];
		view: #gtSourceFor:
]
