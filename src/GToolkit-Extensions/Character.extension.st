Extension { #name : #Character }

{ #category : #'*GToolkit-Extensions' }
Character >> gtUnicodeDetailsFor: aView [
	<gtView>
	| unicodeCharacterData |
	unicodeCharacterData := [ self unicodeCharacterData ]
			on: NotFound
			do: [ ^ aView empty ].
	^ aView forward
		title: 'Unicode';
		priority: 20;
		object: [ unicodeCharacterData ];
		view: #gtPreviewFor:
]
