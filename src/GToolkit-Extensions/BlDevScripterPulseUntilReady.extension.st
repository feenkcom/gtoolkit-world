Extension { #name : #BlDevScripterPulseUntilReady }

{ #category : #'*GToolkit-Extensions' }
BlDevScripterPulseUntilReady >> gtPulseMethodFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source code';
		stencil: [ GtCoder forMethod: BlDevScripterPulseUntilReady >> #pulse ]
]

{ #category : #'*GToolkit-Extensions' }
BlDevScripterPulseUntilReady >> gtScripterPreviewFor: aView [
	<gtView>
	scripter ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Preview';
		priority: 1;
		object: [ scripter ];
		view: #gtSpaceFor:
]

{ #category : #'*GToolkit-Extensions' }
BlDevScripterPulseUntilReady >> gtSpaceActiveTasksFor: aView [
	<gtView>
	^ aView forward
		title: 'Active space tasks';
		priority: 41;
		object: [ scripter ];
		view: #gtSpaceActiveTasksFor:
]

{ #category : #'*GToolkit-Extensions' }
BlDevScripterPulseUntilReady >> gtSpacePendingTasksFor: aView [
	<gtView>
	scripter ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Pending space tasks';
		priority: 40;
		object: [ scripter ];
		view: #gtSpacePendingTasksFor:
]

{ #category : #'*GToolkit-Extensions' }
BlDevScripterPulseUntilReady >> gtStepsMondrianTreeFor: aView [
	<gtView>
	^ scripter gtStepsMondrianTreeFor: aView
]
