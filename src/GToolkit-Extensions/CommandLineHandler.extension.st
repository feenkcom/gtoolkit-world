Extension { #name : #CommandLineHandler }

{ #category : #'*GToolkit-Extensions' }
CommandLineHandler class >> gtCommandLineHandlersFor: aView [
	<gtClassView>
	<gtView>
	^ aView columnedList
		title: 'Handlers';
		items: [ CommandLineHandler allSubclasses sort: [ :a :b | a commandName < b commandName ] ];
		column: 'Command name'
			text: [ :aClass | 
				| aText |
				aText := (aClass commandName ifEmpty: [ aClass ]) asRopedText.

				(aClass isAbstract or: [ aClass commandName isEmpty ])
					ifTrue: [ aText
							italic;
							foreground: BrGlamorousColors disabledButtonTextColor ].
				aText ];
		column: 'Description' text: [ :aClass | aClass description ifNil: [ '' ] ];
		sendTool: [ :aClass | GtClassCoderTool forClass: aClass ]
]

{ #category : #'*GToolkit-Extensions' }
CommandLineHandler class >> gtCommandLineOptionsFor: aView [
	<gtClassView>
	<gtView>
	^ aView columnedList
		title: 'Options';
		items: [ ((Array
				streamContents: [ :aStream | 
					| aClass |
					aClass := self.
					[ aClass == Object ]
						whileFalse: [ aStream nextPutAll: aClass methods.
							aClass := aClass superclass ] ])
				flatCollect: [ :method | 
					method ast sendNodes
						select: [ :node | 
							(node selector = #hasOption: and: [ node arguments anyOne isLiteralNode ])
								or: [ (node selector beginsWith: 'optionAt:')
										and: [ node arguments anyOne isLiteralNode ] ] ] ])
				sort: [ :a :b | a arguments anyOne value < b arguments anyOne value ] ];
		column: 'Argument' text: [ :aMethod | aMethod arguments anyOne value ];
		column: 'Method' text: [ :aMethod | aMethod methodNode ifNotNil: #method ]
]
