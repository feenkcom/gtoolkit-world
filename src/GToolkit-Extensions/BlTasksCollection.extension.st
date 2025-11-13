Extension { #name : #BlTasksCollection }

{ #category : #'*GToolkit-Extensions' }
BlTasksCollection >> gtItemsFor: aView [
	<gtView>
	tasks ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Tasks';
		priority: 1;
		items: [ tasks ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 80;
		column: 'Task' text: #yourself;
		column: 'Permanent'
			text: [ :aTask | 
				GtPhlowOverviewItem new
					boolean: aTask isIndefiniteTermTask;
					description ]
			width: 80;
		actionUpdateButton
]
