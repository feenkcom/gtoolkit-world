Extension { #name : #AsyncFutureThreadPoolTelemetry }

{ #category : #'*GToolkit-World' }
AsyncFutureThreadPoolTelemetry >> gtOverviewListFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Overview';
		priority: 5;
		stencil: [
			| colors |
			colors := Dictionary new
				at: AsyncFutureThreadPoolTelemetryScheduledEvent
					put: (Color transparent);
				at: AsyncFutureThreadPoolTelemetryDoneEvent
					put: (Color transparent);
				yourself.
			
			GtPlotterHorizontalCompositeBarChartStencil new
				leftPadding: 20;
				labelWidth: 250;
				rowHeight: 20;
				barHeight: 17;
				withoutGridlines;
				withoutTickLabels;
				withDescriptionAsLabel;
				executions: self eventsByWorker;
				startTimeComputation: #startTime;
				endTimeComputation: #endTime;
				colorComputation: [ :each | colors at: each class ifAbsent: [ Color veryLightGray ] ];
				executionGeometryComputation: [ :each | BlRectangleGeometry new ];
				rowValuesComputation: #events;
				barStyleComputation: [ :anElement :anEvent |
					(anEvent isKindOf: AsyncFutureThreadPoolTelemetryPolledEvent)
						ifTrue: [
							| statusWeight pollTimeScale pollDurationScale |
							
							statusWeight := 1.
							
							anElement layout: BlFrameLayout new.
					
							anElement addChild: (BlElement new
								background: Color blue;
								constraintsDo: [ :c |
									c horizontal matchParent.
									c vertical matchParent.
									c frame vertical weight: statusWeight.
									c frame vertical alignBottom
								]).
							
							pollTimeScale := GtPlotterTimeScale new 
								domainFrom: anEvent startTime
								to: anEvent endTime.
						
							pollDurationScale := (GtPlotterDurationScale new
								domainFrom: 0 seconds
								to: anEvent duration).
							
							anEvent processTelemetry pauseEvents
								do: [ :eachPause |
									anElement addChild: (BlElement new
										background: (eachPause isWaitingOnSemaphore
											ifTrue: [ Color orange ]
											ifFalse: [ Color veryLightGray ]);
										constraintsDo: [ :c | 
											c vertical matchParent.
											c horizontal matchParent.
											c frame vertical weight: statusWeight.
											c frame vertical alignBottom.
											c frame horizontal
												weight: (pollDurationScale map: eachPause duration).
											c frame horizontal 
												alignLeftAt: (pollTimeScale 
													map: (eachPause startTime)) ])
								].
						].
				]
				
				 ];
		actionUpdateButton
]
