Extension { #name : #Exception }

{ #category : #'*GToolkit-Extensions' }
Exception >> gtStackFor: aView [
	<gtView>
	<gtEmbeddedDebuggerView>
	self gtHasStack ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Stack';
		priority: 10000;
		stencil: [ | anElement |
			anElement := GtPharoStackIndexStencil new asElement.
			anElement
				background: anElement theme default contentBackground;
				hMatchParent;
				vMatchParent;
				padding: (BlInsets left: 5 right: 5).
			self signalerContext
				ifNotNil: [ :anInterruptedContext | 
					anInterruptedContext stack
						ifNotNil: [ :aStack | anElement items: (aStack collect: #copy) ] ].
			anElement ]
]
