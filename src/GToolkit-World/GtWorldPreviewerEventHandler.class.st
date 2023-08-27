Class {
	#name : #GtWorldPreviewerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previewerOverlay'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerEventHandler >> eventsToHandle [
	^ {
		GtWorldPreviewerSelectPagerPageWish.
		GtWorldPreviewerShowWish.
		GtWorldPreviewerSelectSpaceTabWish
	}
]

{ #category : #accessing }
GtWorldPreviewerEventHandler >> previewerSelectPagerPageEvent: aPreviewerEvent [
	aPreviewerEvent consumed: true.
	aPreviewerEvent pagerPagePreview select.
	self removePreviewerOverlay
]

{ #category : #accessing }
GtWorldPreviewerEventHandler >> previewerSelectSpaceTabEvent: aPreviewerEvent [
	aPreviewerEvent consumed: true.
	aPreviewerEvent spaceTabPreview select.
	self removePreviewerOverlay
]

{ #category : #accessing }
GtWorldPreviewerEventHandler >> previewerShowEvent: aPreviewerShowWish [
	| preview worldElement |
	aPreviewerShowWish consumed: true.
	previewerOverlay ifNotNil: [ ^ self ].
	worldElement := aPreviewerShowWish currentTarget.
	previewerOverlay := BrVerticalPane new
			background: (Color veryLightGray alpha: 0.3);
			zIndex: 100;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c horizontal matchParent.
				c vertical matchParent ];
			when: BlClickEvent
				do: [ :e | 
					self removePreviewerOverlay.
					e consumed: true ].
	preview := (GtWorldPreviewer new worldElement: worldElement) asElement.
	previewerOverlay addChild: preview.
	worldElement addChild: previewerOverlay
]

{ #category : #accessing }
GtWorldPreviewerEventHandler >> removePreviewerOverlay [
	previewerOverlay removeFromParent.
	previewerOverlay := nil
]
