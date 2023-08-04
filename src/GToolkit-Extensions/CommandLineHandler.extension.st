Extension { #name : #CommandLineHandler }

{ #category : #'*GToolkit-Extensions' }
CommandLineHandler class >> gtCommandLineHandlersFor: aView [
	<gtClassView>
	<gtView>
	^ aView columnedList
		title: 'Handlers';
		items: [ CommandLineHandler allHandlers  sort: [ :a :b | a commandName < b commandName ] ];
		column: 'Command name'
			text: [ :aClass | 
				aClass commandName
					ifEmpty: [ aClass name asRopedText
							italic;
							foreground: BrGlamorousColors disabledButtonTextColor ]
					ifNotEmpty: #yourself ];
		column: 'Description' text: [ :aClass | aClass description ifNil: [ '' ] ];
		sendTool: [ :aClass | GtClassCoderTool forClass: aClass ]
]
