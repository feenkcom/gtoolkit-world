Extension { #name : #GtSearchScopedMethodsScope }

{ #category : #'*GToolkit-Extensions' }
GtSearchScopedMethodsScope class >> gtScopesFor: aView [
	<gtClassView>
	^ aView columnedList
		title: 'Scopes';
		items: [ self allSubclasses sort: [ :a :b | a order < b order ] ];
		column: 'Order' text: [ :each | each order ] width: 50;
		column: 'Icon' icon: [ :each | each new icon ];
		column: 'Label' text: [ :each | each new label ];
		column: 'Class' text: #yourself;
		sendTool: [ :each | GtClassCoderTool forClass: each ];
		actionUpdateButton
]
