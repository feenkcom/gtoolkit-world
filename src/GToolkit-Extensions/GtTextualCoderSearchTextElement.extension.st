Extension { #name : #GtTextualCoderSearchTextElement }

{ #category : #'*GToolkit-Extensions' }
GtTextualCoderSearchTextElement >> gtSearchTextMarkerContextProperty [
	<gtInspectorElementOverview>
	 self markerContext ifNil: [ ^ nil ].
	
	^ GtInspectorElementOverviewProperty new
		label: 'Search text marker context';
		object: [ self markerContext ]
]
