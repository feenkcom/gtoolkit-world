Extension { #name : #AsyncSharedWeakIdentityKeyDictionary }

{ #category : #'*GToolkit-Extensions' }
AsyncSharedWeakIdentityKeyDictionary >> gtItemsFor: aView [
	<gtView>
	dictionary ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Items';
		priority: 1;
		items: [ monitor critical: [ dictionary copy associations ] ];
		column: ''
			text: [ :_ :anIndex | anIndex ]
			width: 30;
		column: 'Key' text: #key;
		column: 'Value' text: #value;
		send: #value;
		actionUpdateButton;
		contextItemLabel: 'Inspect key'
			action: [ :anElement :anAssoc | anElement phlow spawnObject: anAssoc key ];
		contextItemLabel: 'Inspect value'
			action: [ :anElement :anAssoc | anElement phlow spawnObject: anAssoc value ]
]
