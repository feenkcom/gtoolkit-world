Class {
	#name : #GtWorldPreviewerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerEventHandler >> eventsToHandle [
	^ {
		GtWorldPreviewerSelectWish.
		GtWorldPreviewerShowWish.
		"BlKeyDownEvent.
		BlKeyUpEvent.
		BlMouseMoveEvent.
		BlClickEvent"
	}
]

{ #category : #accessing }
GtWorldPreviewerEventHandler >> previewerSelectEvent: aPreviewerEvent [
	aPreviewerEvent consumed: true.
	aPreviewerEvent worldTabPreview select
]

{ #category : #accessing }
GtWorldPreviewerEventHandler >> previewerShowEvent: aPreviewerShowWish [
	| previewOverlay preview worldElement |
	aPreviewerShowWish consumed: true.
	worldElement := aPreviewerShowWish currentTarget.
	previewOverlay := BrVerticalPane new
			background: (Color veryLightGray alpha: 0.3);
			zIndex: 100;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c horizontal matchParent.
				c vertical matchParent ];
			when: BlClickEvent
				do: [ :e | 
					aPreviewerShowWish currentTarget removeChild: previewOverlay.
					e consumed: true ].
	preview := (GtWorldPreviewer new worldElement: worldElement) asElement.
	preview
		background: Color white;
		addAptitude: BrShadowAptitude new beLarge;
		padding: (BlInsets all: 10);
		margin: (BlInsets all: 100);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	previewOverlay addChild: preview.
	worldElement addChild: previewOverlay
]
