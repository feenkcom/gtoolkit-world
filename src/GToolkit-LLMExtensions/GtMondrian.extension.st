Extension { #name : #GtMondrian }

{ #category : #'*GToolkit-LlmExtensions' }
GtMondrian >> llmImageViewFor: aDataView [
	<gtLlmDataView>
	^ aDataView imageData
		title: 'Element';
		element: [ self asElement ]
]
