Class {
	#name : #GtGitStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtGitStencil >> asPreviewElement [
	^ GtGitElement new asElement
]

{ #category : #'api - instantiation' }
GtGitStencil >> create [
	| tool compositeTool |
	tool := GtGitPhlowTool new.
	compositeTool := GtPhlowCompositeTool new
			addTool: tool;
			addTool: (GtInspectorTool forObject: nil).
	^ (GtPagerSettings usedPager createWrappedOn: compositeTool) maximized
]

{ #category : #accessing }
GtGitStencil >> icon [
	^ BrGlamorousVectorIcons branching
]

{ #category : #accessing }
GtGitStencil >> name [
	^ 'Git'
]
