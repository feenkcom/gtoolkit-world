Extension { #name : #AsyncSharedDictionary }

{ #category : #'*GToolkit-Extensions' }
AsyncSharedDictionary >> gtItemsFor: aView [
	<gtView>

	^ aView columnedTree
		title: 'Items';
		priority: 1;
		items: [ self associations sort: (#key collatedBy: #asString) ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations sort: (#key collatedBy: #asString) ]
				ifFalse: [ 
					(each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ] weight: 3;
		contextItemLabel: 'Inspect key' action: [ :anElement :anAssoc | 
			anElement phlow spawnObject: anAssoc key ];
		contextItemLabel: 'Inspect value' action: [ :anElement :anAssoc | 
			anElement phlow spawnObject: anAssoc value ];
		contextItemLabel: 'Inspect association' action: [ :anElement :anAssoc | 
			anElement phlow spawnObject: anAssoc ];
		contextItemLabel: 'Remove key and value' action: [ :anElement :anAssoc | 
			self removeKey: anAssoc key ifAbsent: [ "ignore" ].
			anElement phlow contextMenuUpdateViewContent ];
		send: [ :assoc | assoc value ].
		
	"Implementation note: association sorting uses #collatedBy: to avoid a 'Symbol DNU value: value: error'"
]
