Extension { #name : #Process }

{ #category : #'*GToolkit-Extensions' }
Process >> gtUpdatingStackFor: aView [
	<gtView>
	(self isTerminated or: [ self isTerminating ]) ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Updating stack';
		priority: 20;
		stencil: [ GtMonitoredProcessElement new service: (GtMonitoredProcess new service: self) ]
]
