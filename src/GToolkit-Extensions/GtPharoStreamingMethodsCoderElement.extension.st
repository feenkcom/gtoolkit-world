Extension { #name : #GtPharoStreamingMethodsCoderElement }

{ #category : #'*GToolkit-Extensions' }
GtPharoStreamingMethodsCoderElement >> gtStreamingCodersViewModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Streaming coders view model';
		object: [ self hasStreamingCodersViewModel
			ifTrue: [ self streamingCodersViewModel ]
			ifFalse: [ nil ] ]
]
