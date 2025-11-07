Extension { #name : #AsyncFutureExecutionPriority }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureExecutionPriority class >> gtPrioritiesFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Priorities';
		items: [ ((AsyncFutureExecutionPriority allSubclasses reject: #isAbstract)
				collect: #uniqueInstance)
				sort: [ :a :b | a asPharoProcessPriority > b asPharoProcessPriority ] ];
		column: 'Class'
			text: [ :aPriority | 
				aPriority == self uniqueInstance
					ifTrue: [ aPriority gtDisplayText bold ]
					ifFalse: [ aPriority ] ];
		column: 'Pharo priority' text: #asPharoProcessPriority
]
