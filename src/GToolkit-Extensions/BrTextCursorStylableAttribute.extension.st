Extension { #name : #BrTextCursorStylableAttribute }

{ #category : #'*GToolkit-Extensions' }
BrTextCursorStylableAttribute >> gtCursorActionsFor: aView [
	<gtView>
	cursorEnterActions ifNil: [ ^ aView empty ].
	cursorLeaveActions ifNil: [ ^ aView empty ].

	^ aView columnedTree
		title: 'Cursor actions';
		items: [ {'Cursor enter actions' -> (cursorEnterActions ifNil: [ #() ]).
				'Cursor leave actions' -> (cursorLeaveActions ifNil: [ #() ])} ];
		children: [ :each | each isAssociation ifTrue: [ each value ] ifFalse: [ #() ] ];
		expandUpTo: 1;
		column: 'Action'
			text: [ :each | 
				each isAssociation
					ifTrue: [ '{1} with {2} {3}'
							format: {each key.
									each value size.
									'item' asPluralBasedOn: each value size} ]
					ifFalse: [ each gtDisplayString ] ];
		send: [ :each | each isAssociation ifTrue: [ each value ] ifFalse: [ each ] ]
]
