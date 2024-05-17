Extension { #name : #AsyncFutureCompositeLogger }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureCompositeLogger >> gtLoggersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Loggers';
		items: [ self loggers ];
		column: 'Name' text: #yourself
]
