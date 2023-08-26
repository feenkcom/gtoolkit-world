Extension { #name : #ZnServerSession }

{ #category : #'*GToolkit-Extensions' }
ZnServerSession >> gtAttributesFor: aView [
	<gtView>
	attributes ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Attributes';
		items: [ attributes ifNil: [ #() ] ifNotNil: #associations ];
		column: 'Name' text: #key;
		column: 'Value' text: #value weight: 2;
		send: #value
]
