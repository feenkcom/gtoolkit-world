Class {
	#name : #AsyncFutureBeaconLogger,
	#superclass : #Object,
	#traits : 'TAsyncFutureLogger',
	#classTraits : 'TAsyncFutureLogger classTrait',
	#category : #'GToolkit-Monitor-Future Workers'
}

{ #category : #logging }
AsyncFutureBeaconLogger >> pendingTask: aPendingTask [
	AsyncFuturePendingTaskSignal new
		pendingTask: aPendingTask;
		emit
]
