Extension { #name : #BlElement }

{ #category : #'*GToolkit-LlmExtensions' }
BlElement >> llmImageViewFor: aDataView [
	<gtLlmDataView>
	
	^aDataView imageData
			title: 'Image' ;
			element: [ self ]
]
