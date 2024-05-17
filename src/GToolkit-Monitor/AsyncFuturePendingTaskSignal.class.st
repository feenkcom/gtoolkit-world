Class {
	#name : #AsyncFuturePendingTaskSignal,
	#superclass : #AsyncFutureSignal,
	#instVars : [
		'pendingTask'
	],
	#category : #'GToolkit-Monitor-Future Workers'
}

{ #category : #accessing }
AsyncFuturePendingTaskSignal >> gtCompositionFor: aView [
	<gtView>
	^ aView forward
		title: 'Pending task';
		object: [ self pendingTask ];
		view: #gtCompositionFor:
]

{ #category : #accessing }
AsyncFuturePendingTaskSignal >> pendingTask [
	<return: #AsyncFutureThreadPoolPendingTask>
	^ pendingTask
]

{ #category : #accessing }
AsyncFuturePendingTaskSignal >> pendingTask: aTask [
	pendingTask := aTask
]

{ #category : #accessing }
AsyncFuturePendingTaskSignal >> printOneLineContentsOn: stream [
	pendingTask ifNil: [ ^ self ].
	timestamp ifNil: [ ^ self ].

	stream nextPutAll: 'After '.
	(timestamp - pendingTask sinceTime) printHumanReadableOn: stream
]
