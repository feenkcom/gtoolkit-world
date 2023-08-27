Class {
	#name : #GtWorldPreviewerExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #accessing }
GtWorldPreviewerExamples >> worldElementWithPreviewerHandler [
	<gtExample>
	| worldElement |
	worldElement := GtWorldElement new.
	self assert: worldElement children size = 1.
	worldElement addEventHandler: GtWorldPreviewerEventHandler new.
	worldElement fireEvent: GtWorldPreviewerShowWish new.
	self assert: worldElement children size = 2.
	^ worldElement
]
