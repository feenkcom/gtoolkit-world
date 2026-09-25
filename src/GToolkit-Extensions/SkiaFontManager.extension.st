Extension { #name : #SkiaFontManager }

{ #category : #'*GToolkit-Extensions' }
SkiaFontManager >> gtSpotterForFamilyNamesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 20;
		title: 'Families';
		items: [ self familyNames ];
		previewElement: [ :aFamilyName | 
			((self matchFamilyName: aFamilyName) gtFontStylesFor: GtPhlowEmptyView new)
				asElementDo: #yourself ];
		send: [ :aFamilyName | self matchFamilyName: aFamilyName ];
		filterBySubstring
]
