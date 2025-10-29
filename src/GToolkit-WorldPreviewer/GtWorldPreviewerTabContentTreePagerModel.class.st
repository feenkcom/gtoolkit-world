Class {
	#name : #GtWorldPreviewerTabContentTreePagerModel,
	#superclass : #GtWorldPreviewerTabContentModel,
	#instVars : [
		'treePagerElement'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - converting' }
GtWorldPreviewerTabContentTreePagerModel >> asElement [
	<return: #BlElement>
	^ GtWorldPreviewerTabContentTreePagerElement new tabContentModel: self
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerModel >> treePagerElement [
	^ treePagerElement
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerModel >> treePagerElement: anObject [
	treePagerElement := anObject
]
