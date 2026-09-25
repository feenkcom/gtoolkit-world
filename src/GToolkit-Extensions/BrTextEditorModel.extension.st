Extension { #name : #BrTextEditorModel }

{ #category : #'*GToolkit-Extensions' }
BrTextEditorModel >> gtCoderAttributes [
	^ Array
		streamContents: [ :s | 
			self text
				findAttributesSuchThat: [ :anAttribute | anAttribute class name beginsWith: 'Gt' ]
				indicesDo: [ :i :j :a | s nextPut: {i. j. a} ] ]
]

{ #category : #'*GToolkit-Extensions' }
BrTextEditorModel >> gtCoderAttributesFor: aView [
	<gtView>
	| someAttributes |
	someAttributes := nil.

	^ aView columnedList
		title: 'Coder attributes';
		priority: -20;
		disableAsync;
		items: [ someAttributes := self gtCoderAttributes ];
		column: 'Attribute' text: [ :aCol | aCol at: 3 ];
		column: 'Range'
			text: [ :aCol | 
				'{1}..{2}'
					format: {aCol at: 1.
							aCol at: 2} ]
			width: 50;
		column: 'Count'
			text: [ :aCol | 
				| aCount |
				aCount := (someAttributes select: [ :each | (each at: 3) == (aCol at: 3) ])
						size.

				aCount > 1
					ifTrue: [ aCount asRopedText foreground: BrGlamorousColors errorBackgroundColor ]
					ifFalse: [ '' ] ]
			width: 50;
			send: [ :aCol | aCol at: 3 ]
]
