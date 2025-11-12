Trait {
	#name : #TGtWorldWithPreviewerPagerPageModel,
	#instVars : [
		'pagerPageModel'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - pager page model' }
TGtWorldWithPreviewerPagerPageModel >> onPagerPageModelChanged [
]

{ #category : #'api - pager page model' }
TGtWorldWithPreviewerPagerPageModel >> pagerPageModel [
	^ pagerPageModel
]

{ #category : #'api - pager page model' }
TGtWorldWithPreviewerPagerPageModel >> pagerPageModel: aPageModel [
	pagerPageModel = aPageModel ifTrue: [ ^ self ].
	pagerPageModel := aPageModel.
	self onPagerPageModelChanged
]
