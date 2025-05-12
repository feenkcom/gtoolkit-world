Class {
	#name : #GtWorldPreviewerExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #accessing }
GtWorldPreviewerExamples >> worldElementWithPreviewerHandler [
	<gtExample>
	<return: #GtWorldElement>
	| worldElement |
	worldElement := GtWorldElement new.
	self assert: worldElement children size = 1.
	worldElement addEventHandler: GtWorldPreviewerEventHandler new.
	worldElement fireEvent: GtWorldPreviewerShowWish new.
	self assert: worldElement children size = 2.
	^ worldElement
]

{ #category : #accessing }
GtWorldPreviewerExamples >> worldPreviewerForWorldWithTwoTabs [
	<gtExample>
	<return: #GtWorldElement>
	| worldElement worldPreviewer scripter |
	worldElement := GtWorldElement new.
	scripter := BlScripter new element: worldElement.
	worldElement phlow showObject: 42.
	worldElement phlow showObject: Object.
	worldPreviewer := GtWorldPreviewer new worldElement: worldElement.
	^ worldPreviewer
]
