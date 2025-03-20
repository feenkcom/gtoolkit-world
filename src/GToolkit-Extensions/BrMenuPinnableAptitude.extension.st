Extension { #name : #BrMenuPinnableAptitude }

{ #category : #'*GToolkit-Extensions' }
BrMenuPinnableAptitude >> gtPinningActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pin actions';
		priority: 50;
		items: [ self pinningActions ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Pre start action'
			text: [ :eachItem | eachItem preStartPinBlock ifNotNil: #gtDisplayText ifNil: [ '' ] ];
		column: 'Pre end action'
			text: [ :eachItem | eachItem preEndPinBlock ifNotNil: #gtDisplayText ifNil: [ '' ] ]
]
