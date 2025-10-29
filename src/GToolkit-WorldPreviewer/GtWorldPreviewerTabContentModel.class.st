Class {
	#name : #GtWorldPreviewerTabContentModel,
	#superclass : #Object,
	#traits : 'TGtWorldWithTabModelWithSpace',
	#classTraits : 'TGtWorldWithTabModelWithSpace classTrait',
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - converting' }
GtWorldPreviewerTabContentModel >> asElement [
	<return: #BlElement>
	^ self subclassResponsibility
]
