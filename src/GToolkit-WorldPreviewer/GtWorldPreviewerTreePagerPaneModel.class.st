Class {
	#name : #GtWorldPreviewerTreePagerPaneModel,
	#superclass : #Object,
	#traits : 'TGtWorldWithTabModelWithSpace',
	#classTraits : 'TGtWorldWithTabModelWithSpace classTrait',
	#instVars : [
		'treePager',
		'paneElement',
		'paneModel'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - converting' }
GtWorldPreviewerTreePagerPaneModel >> asElement [
	^ (self asElementScaled: 0.3)
]

{ #category : #'api - converting' }
GtWorldPreviewerTreePagerPaneModel >> asElementScaled: aScale [
	^ GtWorldPreviewerTreePagerPaneElement new
		withStyling;
		previewScale: aScale;
		treePagerPaneModel: self
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneModel >> paneElement [
	^ paneElement
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneModel >> paneElement: anObject [
	paneElement := anObject
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneModel >> paneModel [
	^ paneModel
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneModel >> paneModel: anObject [
	paneModel := anObject
]

{ #category : #'api - actions' }
GtWorldPreviewerTreePagerPaneModel >> select [
	tabModelWithSpace select.
	treePager smoothScrollToColumn: paneElement constraints horizontalTreeFlow depth
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneModel >> treePager [
	<return: #GtTreePagerFlowPanesElement>
	^ treePager
]

{ #category : #accessing }
GtWorldPreviewerTreePagerPaneModel >> treePager: aTreePagerElement [
	treePager := aTreePagerElement
]
