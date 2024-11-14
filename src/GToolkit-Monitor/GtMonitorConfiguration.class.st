Class {
	#name : #GtMonitorConfiguration,
	#superclass : #Object,
	#category : #'GToolkit-Monitor-Support'
}

{ #category : #accessing }
GtMonitorConfiguration class >> defaultFutureConfiguration [
	^ AsyncFutureExecutionConfiguration new 
		customGroup: #Monitor;
		highPriority
]
