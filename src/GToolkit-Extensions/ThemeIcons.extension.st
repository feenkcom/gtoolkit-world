Extension { #name : #ThemeIcons }

{ #category : #'*GToolkit-Extensions' }
ThemeIcons >> gtIconsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Icons';
		items: [ icons associations sorted: #key ascending ];
		column: 'Icon'
			icon: [ :anAssoc | anAssoc value asElement ]
			width: 150;
		column: 'Name' text: [ :anAssoc | anAssoc key ];
		send: [ :anAssoc | anAssoc value ];
		contextItemLabel: 'Copy name'
			action: [ :anElement :anItem | 
				Clipboard clipboardText: anItem asString ]
]
