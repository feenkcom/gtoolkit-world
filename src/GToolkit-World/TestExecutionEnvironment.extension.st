Extension { #name : #TestExecutionEnvironment }

{ #category : #'*GToolkit-World' }
TestExecutionEnvironment >> gtServicesFor: aView [
	<gtView>
	self services ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Services';
		items: [ self services ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]
