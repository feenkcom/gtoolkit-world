Trait {
	#name : #TGtWorldWithPreviewerTabModel,
	#instVars : [
		'tabModel'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - tab model' }
TGtWorldWithPreviewerTabModel >> hasTabModel [
	^ tabModel isNotNil
]

{ #category : #'api - tab model' }
TGtWorldWithPreviewerTabModel >> onTabModelChanged [
]

{ #category : #'api - tab model' }
TGtWorldWithPreviewerTabModel >> tabModel [
	^ tabModel
]

{ #category : #'api - tab model' }
TGtWorldWithPreviewerTabModel >> tabModel: aTabModel [
	tabModel = aTabModel ifTrue: [ ^ self ].

	tabModel := aTabModel.
	self onTabModelChanged
]
