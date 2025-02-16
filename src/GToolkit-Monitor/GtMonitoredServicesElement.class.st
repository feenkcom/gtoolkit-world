Class {
	#name : #GtMonitoredServicesElement,
	#superclass : #BlElement,
	#instVars : [
		'servicesList'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #initialization }
GtMonitoredServicesElement >> initialize [
	super initialize.
	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	servicesList := BrColumnedList new.
	servicesList
		addEventHandler:
			(GtPhlowListToSelectHandler new
				transformation: self onClickTransformation).
	servicesList
		rowStencil:
			(BrGlamorousColumnedListSelectableRowElementStencilBuilder new
				cellSpacing: 10;
				padding: (BlInsets top: 4 bottom: 4)).
	self addChild: servicesList.
	self initializeServiceListDefinition.
	self updateList.
]

{ #category : #initialization }
GtMonitoredServicesElement >> initializeServiceListDefinition [
	self subclassResponsibility
]

{ #category : #initialization }
GtMonitoredServicesElement >> onClickTransformation [
	^ [ :aMonitoredService | aMonitoredService ]
]

{ #category : #updating }
GtMonitoredServicesElement >> retreiveNewServiceList [
	^ #()
]

{ #category : #updating }
GtMonitoredServicesElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedFutureAction new
				name: self updateTaskName;
				futureConfiguration: GtMonitorConfiguration defaultFutureConfiguration;
				action: [ self retreiveNewServiceList ];
				element: self;
				onFailureEnqueueAction: [ :anException | 
					'Failed to update TaskIt services list' traceCr.
					anException traceCr ];
				onSuccessEnqueueAction: [ :theServices | 
					servicesList items: theServices.
					self
						enqueueTask:
							(BlDelayedTaskAction new
								delay: 5 seconds;
								action: [ self updateList ]) ])
]

{ #category : #updating }
GtMonitoredServicesElement >> updateTaskName [
	^ '[Monitor] Services Update Task'
]
