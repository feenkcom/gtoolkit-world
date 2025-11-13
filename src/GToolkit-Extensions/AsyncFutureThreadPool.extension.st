Extension { #name : #AsyncFutureThreadPool }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPool >> gtWorkersFor: aView [
	<gtView>
	| aTelemetry aMemoryLogger |
	aTelemetry := self telemetryDo: #yourself ifNone: nil.

	^ aView columnedList
		title: 'Workers';
		importantFutureExecutionConfiguration;
		priority: 10;
		items: [ workers asArray withIndexCollect: [ :each :index | each -> index ] ];
		column: 'Worker'
			text: [ :each | each value ]
			weight: 0.5;
		column: 'Name'
			text: [ :each | 
				| aLabel |
				aLabel := each key group ifNotNil: [ :aGroup | aGroup label ] ifNil: [ '' ].

				aLabel := '{1} ({2})'
						format: {aLabel.
								each key priority gtDisplayString}.

				each key group
					ifNotNil: [ :aGroup | 
						aGroup isUnspecified
							ifTrue: [ aLabel := aLabel asRopedText
										foreground: BrGlamorousColors disabledButtonTextColor ] ].
				aLabel ];
		column: 'Futures/min'
			stencil: [ :each | 
				(GtHorizontalSparklineStencil new
					values: (each key timelineOfRecentFutures withIndexCollect: [ :v :i | v -> i ]))
					asElement height: 15 ]
			width: 100;
		column: 'Tasks'
			text: [ :each | 
				| size |
				size := each key amountOfFutures.
				size isZero ifTrue: [ '' ] ifFalse: [ size ] ];
		column: 'Pending'
			text: [ :each | 
				| size |
				size := each key pendingQueueSize.
				size isZero ifTrue: [ '' ] ifFalse: [ size ] ];
		column: 'Busy'
			text: [ :each | 
				each key isBusy
					ifFalse: [ '' ]
					ifTrue: [ each key isWaitingOnSemaphore ifTrue: [ 'true (waiting)' ] ifFalse: [ 'true' ] ] ];
		column: 'Running'
			text: [ :each | each key isRunning ifFalse: [ '' ] ifTrue: [ 'true' ] ];
		send: [ :each | each key ];
		actionUpdateButton;
		actionButtonIcon: BrGlamorousVectorIcons add
			tooltip: 'Start counter'
			action: [ :aButton | 
				AsyncFutureThreadPoolWorker futuresCounterClass: AsyncFutureThreadPoolCounter2.
				AsyncFutureThreadPoolWorker
					allInstancesDo: [ :each | each instVarNamed: #futuresCounter put: AsyncFutureThreadPoolCounter2 new ].
				aButton phlow fireViewUpdateWish ];
		actionButtonIcon: BrGlamorousVectorIcons play
			tooltip: 'Enable telemetry'
			action: [ self
					telemetryDo: #yourself
					ifNone: [ self telemetry: (aTelemetry := AsyncFutureThreadPoolTelemetry new) ] ];
		actionButtonIcon: BrGlamorousVectorIcons stop
			tooltip: 'Stop telemetry'
			action: [ :aButton | 
				self
					telemetryDo: [ :aPreviousTelemetry | 
						telemetry := nil.
						aButton phlow spawnObject: aPreviousTelemetry ] ];
		actionButtonIcon: BrGlamorousVectorIcons cancel
			tooltip: 'Reset telemetry'
			action: [ self telemetryDo: #reset ];
		actionButtonIcon: BrGlamorousVectorIcons left
			tooltip: 'Wake all items up: Push all pending tasks to local queue'
			action: [ :aButton :aTab | 
				workers do: #gtPushPendingTasksToLocalQueue.
				aTab viewContentElement phlow update ];
		actionButtonIcon: BrGlamorousVectorIcons right
			tooltip: 'Monitor pending tasks'
			action: [ :aButton | 
				AsyncFutureThreadPoolWorker ensureDefaultLogger: AsyncFutureBeaconLogger new.
				aButton phlow
					spawnObject: (aMemoryLogger
							ifNil: [ aMemoryLogger := MemoryLogger new startFor: AsyncFutureSignal ]) ]
]
