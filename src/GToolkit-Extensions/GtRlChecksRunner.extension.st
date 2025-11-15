Extension { #name : #GtRlChecksRunner }

{ #category : #'*GToolkit-Extensions' }
GtRlChecksRunner >> gtStopRunnersFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons stop;
		tooltip: 'Stop runners';
		action: [ self stopRunners ]
]
