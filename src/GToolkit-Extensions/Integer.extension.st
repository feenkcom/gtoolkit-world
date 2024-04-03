Extension { #name : #Integer }

{ #category : #'*GToolkit-Extensions' }
Integer >> gtIntegerFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Integer';
		items: [ | associations |
			associations :=	{
				{ 'grouped by thousands' . (String streamContents: [ :out |
										self
											printSeparatedBy: Character space
											every: 3
											signed: false
											on: out ]) }.
				{ 'decimal' . self printString }.
				{ 'hex' . self printStringHex }.
				{ 'octal' . (self printStringBase: 8) }.
				{ 'binary' . (self printStringBase: 2) }.
				{ 'bytes' . self }.
				{ 'kilobytes' . (self / (1024)) floor }.
				{ 'megabytes' . (self / (1024**2)) floor }.
				{ 'gigabytes' . (self / (1024**3)) floor }.
				{ 'bytearray' . self asByteArray }.
				{ 'bytearray reversed' . self asByteArray reversed } }.
			(self between: 0 and: 16r10FFFF)
				ifTrue: [ associations := associations copyWith: { 'character' . self asCharacter } ].
			associations ];
		column: 'Key' text: #first;
		column: 'Value' text: #second;
		send: #last
]
