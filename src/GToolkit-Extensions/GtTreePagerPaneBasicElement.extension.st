Extension { #name : #GtTreePagerPaneBasicElement }

{ #category : #'*GToolkit-Extensions' }
GtTreePagerPaneBasicElement >> gtPaneModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Pane model';
		object: [ self paneModel ]
]
