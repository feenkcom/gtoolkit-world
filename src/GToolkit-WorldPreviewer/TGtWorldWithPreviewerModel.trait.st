Trait {
	#name : #TGtWorldWithPreviewerModel,
	#instVars : [
		'previewer'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - previewer' }
TGtWorldWithPreviewerModel >> onPreviewerChanged [
]

{ #category : #'api - previewer' }
TGtWorldWithPreviewerModel >> previewer [
	^ previewer
]

{ #category : #'api - previewer' }
TGtWorldWithPreviewerModel >> previewer: aPreviewer [
	previewer = aPreviewer ifTrue: [ ^ self ].

	previewer := aPreviewer.

	self onPreviewerChanged
]
