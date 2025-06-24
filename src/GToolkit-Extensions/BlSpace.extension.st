Extension { #name : #BlSpace }

{ #category : #'*GToolkit-Extensions' }
BlSpace >> gtSpaceActiveTasksFor: aView [
	<gtView>
	self taskQueue ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Active tasks';
		object: [ self taskQueue ];
		view: #gtTasksFor:
]

{ #category : #'*GToolkit-Extensions' }
BlSpace >> gtSpacePendingTasksFor: aView [
	<gtView>
	self taskQueue ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Pending tasks';
		object: [ tasks ];
		view: #gtPendingTasksFor:
]
