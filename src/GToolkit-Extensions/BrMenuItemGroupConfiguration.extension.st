Extension { #name : #BrMenuItemGroupConfiguration }

{ #category : #'*GToolkit-Extensions' }
BrMenuItemGroupConfiguration class >> gtGroups [
	^ (self classSide methods
		select: [ :each | each numArgs isZero and: [ (each selector = #gtGroups) not ] ]
		thenCollect: [ :each | 
			[ each methodClass instanceSide perform: each selector ]
				onErrorDo: [ :anException | anException return: nil ] ])
		select: [ :each | each isKindOf: BrMenuItemGroupConfiguration ]
]

{ #category : #'*GToolkit-Extensions' }
BrMenuItemGroupConfiguration class >> gtGroupsFor: aView [
	<gtClassView>
	<gtView>
	^ aView columnedList
		title: 'Groups';
		items: [ self gtGroups sort: [ :a :b | a priority < b priority ] ];
		column: 'Priority'
			text: #priority
			width: 60;
		column: 'Name' text: #name
]
