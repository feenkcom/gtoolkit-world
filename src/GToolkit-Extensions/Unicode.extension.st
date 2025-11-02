Extension { #name : #Unicode }

{ #category : #'*GToolkit-Extensions' }
Unicode class >> gtSymbolsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Symbols';
		priority: 21;
		items: [ (0 to: Unicode maxValue) asAsyncStream
				collect: [ :each | (Character value: each) unicodeCharacterData ] ];
		column: 'Code point'
			text: [ :each | each gtCodePointHexString ]
			width: 100;
		column: 'Symbol'
			stencil: [ :each | 
				BrEditor new
					beReadOnlyWithoutSelection;
					aptitude: BrGlamorousRegularEditorAptitude new;
					hMatchParent;
					padding: (BlInsets left: 5);
					vExact: 20;
					text: each character asString ]
			width: 100;
		column: 'Name' text: [ :each | each name asLowercase capitalized ];
		column: 'Encoded hex'
			text: [ :each | 
				String
					streamContents: [ :out | 
						each character asString utf8Encoded
							do: [ :byte | 
								byte
									printOn: out
									base: 16
									nDigits: 2 ]
							separatedBy: [ out space ] ] ]
			width: 100;
		column: 'Encoded binary'
			text: [ :each | 
				each asTextWithUtf8EncodedBinary ]
]
