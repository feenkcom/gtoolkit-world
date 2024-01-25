Extension { #name : #ClassSessionHandler }

{ #category : #'*GToolkit-Extensions' }
ClassSessionHandler >> gtShutDownMethod [
	| method |
	method := self registeredClass class lookupSelector: #shutDown:.
	method = (Behavior>>#shutDown:)
		ifFalse: [ ^ method ].
	^ self registeredClass class lookupSelector: #shutDown
]

{ #category : #'*GToolkit-Extensions' }
ClassSessionHandler >> gtStartUpMethod [
	| method |
	method := self registeredClass class lookupSelector: #startUp:.
	method = (Behavior>>#startUp:)
		ifFalse: [ ^ method ].
	^ self registeredClass class lookupSelector: #startUp
]

{ #category : #'*GToolkit-Extensions' }
ClassSessionHandler >> gtStyleMethod: method [
	^ method methodClass = Behavior
		ifTrue: [ method printString asRopedText foreground: Color gray ]
		ifFalse: [ method ]
]

{ #category : #'*GToolkit-Extensions' }
ClassSessionHandler >> gtViewDetailsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		priority: 30;
		items: [ {
			{ #Class . registeredClassName. self registeredClass }.
			{ #Startup . 
				self gtStyleMethod: self gtStartUpMethod. 
				self gtStartUpMethod  }.
			{ #Shutdown . 
				self gtStyleMethod: self gtShutDownMethod. 
				self gtShutDownMethod  } 
		} ];
		column: #key text: #first weight: 0.5;
		column: #value text: #second;
		send: #last
]
