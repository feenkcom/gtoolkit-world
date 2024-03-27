Extension { #name : #Integer }

{ #category : #'*GToolkit-Extensions' }
Integer >> gtIntegerFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Integer';
		items: [ | associations |
			associations :=	{
					'display' -> self gtDisplayString.
					'decimal' -> self printString.
					'hex' -> self printStringHex.
					'octal' -> (self printStringBase: 8).
					'binary' -> (self printStringBase: 2).
					'bytes' -> self gtDisplayString.
					'kilobytes' -> (self / (1024)) floor gtDisplayString.
					'megabytes' -> (self / (1024**2)) floor gtDisplayString.
					'gigabytes' -> (self / (1024**3)) floor gtDisplayString.
					'bytearray' -> self asByteArray.
					'bytearray reversed' -> self asByteArray reversed } asOrderedCollection.
			(self between: 0 and: 16r10FFFF)
				ifTrue: [ associations add: 'character' -> self asCharacter ].
			associations ];
		column: 'Key' text: #key;
		column: 'Value' text: #value;
		send: #value
]
