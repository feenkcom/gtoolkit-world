Extension { #name : #BrMenuSteppedElement }

{ #category : #'*GToolkit-Extensions' }
BrMenuSteppedElement >> gtElementCacheFor: aView [
	<gtView>
	elementCache ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Menu cache';
		priority: 0.5;
		items: [ elementCache associations sort: (#key collatedBy: #gtDisplayString) ];
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		contextItemLabel: 'Spawn menu' action: [ :anElement :anAssoc | 
			anElement phlow spawnObject: anAssoc key ];
		contextItemLabel: 'Spawn element' action: [ :anElement :anAssoc | 
			anElement phlow spawnObject: anAssoc value ];
		send: #key
]
