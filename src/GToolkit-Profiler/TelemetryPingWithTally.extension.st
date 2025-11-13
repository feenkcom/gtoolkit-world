Extension { #name : #TelemetryPingWithTally }

{ #category : #'*GToolkit-Profiler' }
TelemetryPingWithTally >> gtMessagesTreeIn: aView [
	<gtView>
	
	^ aView forward
		title: 'Tally';
		object: [ tally ];
		priority: 4;
		view: #gtMessagesTreeIn:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Tally'
			tooltip: 'Inspect tally' 
			action: [ :aButton | 
				aButton phlow spawnObject: tally ]
]

{ #category : #'*GToolkit-Profiler' }
TelemetryPingWithTally >> gtPingToSpawn: aTelemetryPing [
	^ aTelemetryPing copyWithTally: (tally applyFilter: (GtGatherMessageTallyFilter forMethod: aTelemetryPing sender))
]

{ #category : #'*GToolkit-Profiler' }
TelemetryPingWithTally >> gtRecursionSummaryMessagesTreeIn: aView [
	<gtView>
	
	^ aView forward
		title: 'Tally (Summary)';
		object: [ tally ];
		priority: 5;
		view: #gtRecursionSummaryMessagesTreeIn:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Tally'
			tooltip: 'Inspect tally' 
			action: [ :aButton | 
				aButton phlow spawnObject: tally ]
]
