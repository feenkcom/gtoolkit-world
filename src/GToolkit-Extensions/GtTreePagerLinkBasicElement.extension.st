Extension { #name : #GtTreePagerLinkBasicElement }

{ #category : #'*GToolkit-Extensions' }
GtTreePagerLinkBasicElement >> gtLinkModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Link model';
		object: [ self linkModel ]
]

{ #category : #'*GToolkit-Extensions' }
GtTreePagerLinkBasicElement >> gtPaneModelProperty [
	<gtInspectorElementOverview>
	^ GtInspectorElementOverviewProperty new
		label: 'Pane model';
		object: [ self linkModel ifNotNil: #paneModel ]
]
