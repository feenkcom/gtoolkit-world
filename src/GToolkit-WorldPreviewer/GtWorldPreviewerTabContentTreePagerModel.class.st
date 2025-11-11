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

{ #category : #'api - exporting' }
GtWorldPreviewerTabContentTreePagerModel >> computeScreenshot [
	<return: #FileReference>
	| screenshot |
	screenshot := GtWorldPreviewerTabContentTreePagerElement new
			background: Color white;
			fitContent;
			previewScale: 1.0;
			tabContentModel: self.

	^ (BlScripter new
		maxPulseElapsedTime: 30 seconds;
		element: screenshot) element exportAsPNG
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerModel >> treePagerElement [
	^ treePagerElement
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerModel >> treePagerElement: anObject [
	treePagerElement := anObject
]
