Extension { #name : #Unicode }

{ #category : #'*GToolkit-Extensions' }
Unicode >> gtSpotterCodePointsFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 10;
		title: 'Code points';
		search: [ :aSpotterContext | 
			| stream |
			stream := (0 to: Unicode maxValue) asAsyncStream.
			(((GtSpotterSubstringsFilterStream
				forStream: stream
				search: aSpotterContext searchQuery trimBoth capitalized)
				itemString: [ :codePoint | 'U+' , codePoint printStringHex ])
				collect: [ :codePoint | 
					[ (Character value: codePoint) unicodeCharacterData ]
						on: NotFound
						do: [ :e | nil ] ])
				select: [ :each | each notNil ] ]
]

{ #category : #'*GToolkit-Extensions' }
Unicode >> gtSpotterSymbolNameFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 11;
		title: 'Symbol names';
		search: [ :aSpotterContext | 
			| stream |
			stream := ((0 to: Unicode maxValue) asAsyncStream
					collect: [ :each | [ each unicodeCharacterData ] on: NotFound do: [ nil ] ])
					select: [ :each | each notNil ].
			(GtSpotterSubstringsFilterStream
				forStream: stream
				search: aSpotterContext searchQuery trimBoth)
				itemString: [ :characterData | characterData name asLowercase capitalized ] ]
]

{ #category : #'*GToolkit-Extensions' }
Unicode class >> gtSymbolsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Symbols';
		priority: 21;
		items: [ (0 to: Unicode maxValue) asAsyncStream
				collect: [ :each | each -> (Character value: each) ] ];
		column: 'Code point'
			text: [ :each | 
				String
					streamContents: [ :stream | 
						stream << 'U+'.
						each key
							printOn: stream
							base: 16
							nDigits: 4 ] ]
			width: 100;
		column: 'Symbol'
			stencil: [ :each | 
				BrEditor new
					beReadOnlyWithoutSelection;
					aptitude: BrGlamorousRegularEditorAptitude new;
					hMatchParent;
					padding: (BlInsets left: 5);
					vExact: 20;
					text: each value asString ]
			width: 100;
		column: 'Name'
			text: [ :each | 
				[ each value unicodeCharacterData value name asLowercase capitalized ]
					on: NotFound
					do: [ 'N/A' ] ];
		column: 'Encoded hex'
			text: [ :each | 
				String
					streamContents: [ :out | 
						(Character value: each key) asString utf8Encoded
							do: [ :byte | 
								byte
									printOn: out
									base: 16
									nDigits: 2 ]
							separatedBy: [ out space ] ] ]
			width: 100;
		column: 'Encoded binary'
			text: [ :each | 
				[ each value unicodeCharacterData asTextWithUtf8EncodedBinary ]
					on: NotFound
					do: [ 'N/A' ] ];
		actionStencil: [ :aButton | 
				GtSpotterDropdownButtonStencil new
					object: self new;
					tooltip: 'Search symbols';
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						aButton phlow spawnTool: anActOnEvent toolToSend.
						anActOnEvent beActed ] ]
			tooltip: 'Search symbols';
		send: #value
]
