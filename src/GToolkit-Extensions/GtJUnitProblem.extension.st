Extension { #name : #GtJUnitProblem }

{ #category : #'*GToolkit-Extensions' }
GtJUnitProblem >> gtDetailsStackEntriesFor: aView [
	<gtView>
	^ aView forward
		title: 'Entries';
		priority: 9;
		question: 'What diagnostic output or stack trace was recorded?';
		object: [ self pharoDebugLogInspector ];
		view: #gtViewEntriesFor:
]

{ #category : #'*GToolkit-Extensions' }
GtJUnitProblem >> gtDetailsStackFirstEntryFramesFor: aView [
	<gtView>
	^ aView forward
		title: 'Frames';
		tooltip: 'First entry frames';
		priority: 8;
		question: 'What diagnostic output or stack trace was recorded?';
		object: [ self pharoDebugLogInspector parseLogEntries
				ifNotEmpty: [ :aCollection | aCollection first ]
				ifEmpty: [ nil ] ];
		view: #gtViewFramesFor:
]

{ #category : #'*GToolkit-Extensions' }
GtJUnitProblem >> pharoDebugLogInspector [
	^ GtPharoDebugLogInspector new string: self details
]
