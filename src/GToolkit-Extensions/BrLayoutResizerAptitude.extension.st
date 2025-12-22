Extension { #name : #BrLayoutResizerAptitude }

{ #category : #'*GToolkit-Extensions' }
BrLayoutResizerAptitude >> gtPropagationsFor: aView [
	<gtView>
	propagations ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Propagations';
		object: [ propagations ];
		view: #gtPropagationsFor:
]
