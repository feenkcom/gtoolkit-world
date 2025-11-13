Class {
	#name : #GtWorldPreviewerTreePagerPaneElement,
	#superclass : #GtWorldPreviewerFormElement,
	#traits : 'TGtWorldWithPreviewerTreePagerPaneModel',
	#classTraits : 'TGtWorldWithPreviewerTreePagerPaneModel classTrait',
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneElement >> itemElement [
	"Return a model element for which a preview is created"

	^ self treePagerPaneModel paneElement
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneElement >> itemModel [
	"Return a model which represents a given preview"

	^ self treePagerPaneModel
]

{ #category : #'api - tree pager pane model' }
GtWorldPreviewerTreePagerPaneElement >> onTreePagerPaneModelChanged [
	self updateElement
]
