Extension { #name : #GtSubprocessWithInMemoryOutput }

{ #category : #'*GToolkit-Extensions' }
GtSubprocessWithInMemoryOutput >> gtCommandLineFor: aView [
	<gtView>

	^ aView textEditor
		title: 'Command line';
		priority: 30;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self commandLineString ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
GtSubprocessWithInMemoryOutput >> gtSwitchFor: anAction [
	<gtAction>
	^ anAction button
		priority: 1;
		icon: BrGlamorousVectorIcons shutdown;
		action: [ self isRunning ifTrue: [ self kill ] ifFalse: [ self run ] ]
]
