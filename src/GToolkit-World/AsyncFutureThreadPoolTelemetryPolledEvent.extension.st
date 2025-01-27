Extension { #name : #AsyncFutureThreadPoolTelemetryPolledEvent }

{ #category : #'*GToolkit-World' }
AsyncFutureThreadPoolTelemetryPolledEvent >> gtTimelineFor: aView [
	<gtView>
	^ aView explicit
		title: 'Timeline';
		priority: 5;
		stencil: [ | anElement statusWeight pollTimeScale pollDurationScale |

			statusWeight := 1.
			
			anElement := BlElement new.
			anElement layout: BlFrameLayout new.
			anElement constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical exact: 50 ].

			anElement
				addChild: (BlElement new
						background: Color blue;
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent.
							c frame vertical weight: statusWeight.
							c frame vertical alignBottom ]).

			pollTimeScale := GtPlotterTimeScale new
					domainFrom: self startTime
					to: self endTime.

			pollDurationScale := GtPlotterDurationScale new
					domainFrom: 0 seconds
					to: self duration.

			self processTelemetry pauseEvents
				do: [ :eachPause | 
					anElement
						addChild: (BlElement new
								background: (eachPause isWaitingOnSemaphore
											ifTrue: [ Color orange ]
											ifFalse: [ Color veryLightGray ]);
								constraintsDo: [ :c | 
									c vertical matchParent.
									c horizontal matchParent.
									c frame vertical weight: statusWeight.
									c frame vertical alignBottom.
									c frame horizontal weight: (pollDurationScale map: eachPause duration).
									c frame horizontal
										alignLeftAt: (pollTimeScale map: eachPause startTime) ]) ].

			anElement ]
]
