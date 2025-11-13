Class {
	#name : #GtWorldPreviewerTabExplicitQuery,
	#superclass : #Object,
	#instVars : [
		'queryStencilBuilder',
		'itemModelStencilBuilder'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #queries }
GtWorldPreviewerTabExplicitQuery >> elementClass: aClass [
	self queryStencil: [ :aRootElement | aRootElement query // aClass ]
]

{ #category : #'as yet unclassified' }
GtWorldPreviewerTabExplicitQuery >> initialize [
	super initialize.
	queryStencilBuilder := GtWorldPreviewerTabQueryStencilBuilder new.
	itemModelStencilBuilder := GtWorldPreviewerTabItemStencilBuilder new
]

{ #category : #queries }
GtWorldPreviewerTabExplicitQuery >> queryStencil: aStencilBuilder [
	queryStencilBuilder := aStencilBuilder
			asStencilBuilder: GtWorldPreviewerTabQueryStencilBuilder
]

{ #category : #queries }
GtWorldPreviewerTabExplicitQuery >> stencil: aStencilBuilder [
	itemModelStencilBuilder := aStencilBuilder
			asStencilBuilder: GtWorldPreviewerTabItemStencilBuilder
]

{ #category : #'api - converting' }
GtWorldPreviewerTabExplicitQuery >> tabItemForTabModel: aTabModelWithSpace [
	<return: #GtWorldPreviewerTabContentModel or: nil>
	| anElementQuery |
	anElementQuery := queryStencilBuilder
			rootElement: aTabModelWithSpace model root;
			build.
	anElementQuery ifNil: [ ^ nil ].
	anElementQuery isEmpty ifTrue: [ ^ nil ].
	anElementQuery all size = 1 ifFalse: [ ^ nil ]. 

	^ itemModelStencilBuilder
		tabModelWithSpace: aTabModelWithSpace;
		element: anElementQuery anyOne;
		build
]
