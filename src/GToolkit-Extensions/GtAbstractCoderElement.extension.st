Extension { #name : #GtAbstractCoderElement }

{ #category : #'*GToolkit-Extensions' }
GtAbstractCoderElement >> gtCoderNavigationModelProperty [
	<gtInspectorElementOverview>
	self navigationModel ifNil: [ ^ nil ].
	
	^ GtInspectorElementOverviewProperty new
		label: 'Coder navigation model';
		object: [ self navigationModel ]
]
