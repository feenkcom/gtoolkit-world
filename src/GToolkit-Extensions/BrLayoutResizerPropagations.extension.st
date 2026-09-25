Extension { #name : #BrLayoutResizerPropagations }

{ #category : #'*GToolkit-Extensions' }
BrLayoutResizerPropagations >> gtPropagationsFor: aView [
	<gtView>
	propagations ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Propagations';
		items: [ propagations ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]
