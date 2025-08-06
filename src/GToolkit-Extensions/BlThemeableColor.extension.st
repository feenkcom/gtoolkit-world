Extension { #name : #BlThemeableColor }

{ #category : #'*GToolkit-Extensions' }
BlThemeableColor >> gtColorFor: aView [
	<gtView>
	^ aView forward
		title: 'Color preview';
		object: [ color ];
		view: #gtPreviewFor:
]
