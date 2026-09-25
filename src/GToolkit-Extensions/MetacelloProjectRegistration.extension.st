Extension { #name : #MetacelloProjectRegistration }

{ #category : #'*GToolkit-Extensions' }
MetacelloProjectRegistration >> gtBaselineProjectSpecFor: aView [
	<gtView>
	^ aView forward
		title: 'Baseline class';
		priority: 1;
		object: [ baselineProjectSpec ];
		view: #gtBaselineClassFor:
]
