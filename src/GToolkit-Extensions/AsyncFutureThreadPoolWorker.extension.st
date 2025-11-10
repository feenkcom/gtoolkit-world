Extension { #name : #AsyncFutureThreadPoolWorker }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtLocalQueueFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Local queue';
		importantFutureExecutionConfiguration;
		priority: 11;
		object: [ localQueue ];
		view: #gtItemsFor:;
		actionButtonIcon: BrGlamorousVectorIcons cancel
			tooltip: 'Cancel pending tasks'
			action: [ :aButton :aTab |
				localQueue itemArray do: [ :each | each cancelSoft ].
				aTab viewContentElement phlow update ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtOverview [
	^ {
		GtPhlowOverviewItem new
			name: 'Group'; description: self group label; value: self group.
		GtPhlowOverviewItem new
			name: 'Priority'; value: self priority.
		GtPhlowOverviewItem new
			name: 'Is running'; boolean: self isRunning.
		GtPhlowOverviewItem new
			name: 'Is busy'; boolean: self isBusy.
		GtPhlowOverviewItem new
			name: 'Is shutting down'; boolean: self isShuttingDown.
		GtPhlowOverviewItem new
			name: 'Is waiting on semaphore'; boolean: self isWaitingOnSemaphore.
		GtPhlowOverviewItem new
			name: 'Local queue'; value: localQueue.
		GtPhlowOverviewItem new
			name: 'Pending queue'; value: pendingQueue.
		GtPhlowOverviewItem new
			name: 'Current task'; value: currentTask
	}
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		importantFutureExecutionConfiguration;
		priority: 60;
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Description' text: #description;
		send: #value;
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtPendingQueueFor: aView [
	<gtView>

	^ aView forward
		title: 'Pending queue';
		importantFutureExecutionConfiguration;
		priority: 12;
		object: [ pendingQueue ];
		view: #gtItemsFor:;
		actionButtonIcon: BrGlamorousVectorIcons left 
			tooltip: 'Wake all items up: Push all pending tasks to local queue' 
			action: [ :aButton :aTab |
				self gtPushPendingTasksToLocalQueue.
				aTab viewContentElement phlow update ];
		actionButtonIcon: BrGlamorousVectorIcons cancel
			tooltip: 'Cancel pending tasks'
			action: [ :aButton :aTab |
				pendingQueue itemArray do: [ :each | each task cancelSoft ].
				aTab viewContentElement phlow update ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtPushPendingTasksToLocalQueue [
	localQueue pushBackAll: (pendingQueue popAll collect: #task)
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtShutdownActionFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Shutdown';
		priority: 30;
		icon: BrGlamorousVectorIcons shutdown;
		action: [ self shutdown ]
]
