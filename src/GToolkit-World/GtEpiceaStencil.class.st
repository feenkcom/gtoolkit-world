Class {
	#name : #GtEpiceaStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #accessing }
GtEpiceaStencil >> asPreviewElement [
	^ GtEpiceaElement new asElement
]

{ #category : #accessing }
GtEpiceaStencil >> create [
	| tool compositeTool |
	tool := GtChangePhlowTool new.
	compositeTool := GtPhlowCompositeTool new
			addTool: tool;
			addTool: (GtInspectorTool forObject: nil).
	^ (GtPagerSettings usedPager createWrappedOn: compositeTool) maximized
]

{ #category : #accessing }
GtEpiceaStencil >> icon [
	^ BrGlamorousVectorIcons changes
]

{ #category : #accessing }
GtEpiceaStencil >> name [
	^ 'Code Changes'
]
