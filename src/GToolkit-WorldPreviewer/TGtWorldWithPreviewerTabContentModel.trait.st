Trait {
	#name : #TGtWorldWithPreviewerTabContentModel,
	#instVars : [
		'tabContentModel'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - tab content model' }
TGtWorldWithPreviewerTabContentModel >> onTabContentModelChanged [
]

{ #category : #'api - tab content model' }
TGtWorldWithPreviewerTabContentModel >> tabContentModel [
	^ tabContentModel
]

{ #category : #'api - tab content model' }
TGtWorldWithPreviewerTabContentModel >> tabContentModel: aTabContentModel [
	tabContentModel = aTabContentModel ifTrue: [ ^ self ].
	
	tabContentModel := aTabContentModel.
	self onTabContentModelChanged
]
