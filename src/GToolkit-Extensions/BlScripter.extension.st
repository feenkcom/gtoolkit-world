Extension { #name : #BlScripter }

{ #category : #'*GToolkit-Extensions' }
BlScripter >> gtInfoFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].

	^ aView details
		title: 'Info';
		priority: 1.1;
		row: 'Pulse requested'
			value: [ self space ]
			text: [ :aSpace | aSpace pulseRequested printString ];
		row: 'Has definite term tasks'
			value: [ self space taskQueue ]
			text: [ :aTaskQueue | aTaskQueue hasDefiniteTermTasks printString ];
		row: 'Elements count'
			value: [ self space ]
			text: [ :aSpace | self gtSpaceElementsCount printString ];
		row: 'Space task events'
			value: [ self spaceTaskEvents ]
			text: [ :theEvents | theEvents size printString ];
		row: 'Leaves steps'
			value: [ rootStep ]
			text: [ :aStep | self gtLeavesStepsCount printString ]
]

{ #category : #'*GToolkit-Extensions' }
BlScripter >> gtLeavesStepsCount [
	"Answer the number of leave steps, that is, the steps without substeps.
	The steps are counted one by one instead of being collected first,
	because the step tree can be large."
	<return: #Number>
	| aCount |
	aCount := 0.
	rootStep withAllStepsBreadthFirstDo: [ :eachStep |
		eachStep isLeaveStep ifTrue: [ aCount := aCount + 1 ] ].
	^ aCount
]

{ #category : #'*GToolkit-Extensions' }
BlScripter >> gtSpaceActiveTasksFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self space taskQueue isEmpty ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Active space tasks';
		priority: 41;
		object: [ self space taskQueue ];
		view: #gtTasksFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Task Queue'
			tooltip: 'Inspect space task queue'
			action: [ :aButton | aButton phlow spawnObject: self space taskQueue ]
]

{ #category : #'*GToolkit-Extensions' }
BlScripter >> gtSpaceElementsCount [
	"Answer the number of all elements in the space, including the space root.
	The elements are counted one by one instead of being collected first,
	because the element tree can be large."
	<return: #Number>
	| aCount |
	aCount := 0.
	self space root withAllChildrenBreadthFirstDo: [ :eachElement | aCount := aCount + 1 ].
	^ aCount
]

{ #category : #'*GToolkit-Extensions' }
BlScripter >> gtSpacePendingTasksFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self space taskQueue isEmpty ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Pending space tasks';
		priority: 40;
		object: [ self space taskQueue ];
		view: #gtPendingTasksFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Task Queue'
			tooltip: 'Inspect space task queue'
			action: [ :aButton | aButton phlow spawnObject: self space taskQueue ]
]
