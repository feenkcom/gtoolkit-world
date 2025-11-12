Trait {
	#name : #TGtWorldWithPreviewerTreePagerPaneModel,
	#instVars : [
		'treePagerPaneModel'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - tree pager pane model' }
TGtWorldWithPreviewerTreePagerPaneModel >> onTreePagerPaneModelChanged [
]

{ #category : #'api - tree pager pane model' }
TGtWorldWithPreviewerTreePagerPaneModel >> treePagerPaneModel [
	^ treePagerPaneModel
]

{ #category : #'api - tree pager pane model' }
TGtWorldWithPreviewerTreePagerPaneModel >> treePagerPaneModel: aPaneModel [
	treePagerPaneModel = aPaneModel ifTrue: [ ^ self ].
	treePagerPaneModel := aPaneModel.
	self onTreePagerPaneModelChanged
]
