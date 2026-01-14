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
	^ GtWorldPreviewerTabContentTreePagerElement new
		treePagerPaneElementClass: GtWorldPreviewerTreePagerPaneWithLabelElement;
		tabContentModel: self
]

{ #category : #'api - exporting' }
GtWorldPreviewerTabContentTreePagerModel >> computeScreenshot [
	<return: #FileReference>
	| screenshot scripter element |
	screenshot := GtWorldPreviewerTabContentTreePagerElement new
			treePagerPaneElementClass: GtWorldPreviewerTreePagerPaneElement;
			background: Color white;
			fitContent;
			previewScale: 1.0;
			tabContentModel: self.

	scripter := BlScripter new
			maxPulseElapsedTime: 30 seconds;
			element: screenshot.
	
	element := scripter element.
	^ BlExporter png element: element; scaled: 2; export
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerModel >> treePagerElement [
	^ treePagerElement
]

{ #category : #accessing }
GtWorldPreviewerTabContentTreePagerModel >> treePagerElement: anObject [
	treePagerElement := anObject
]
