Extension { #name : #GtClipboard }

{ #category : #'*GToolkit-Extensions' }
GtClipboard class >> gtRecentItemsFor: aView [
	<gtClassView>
	^ aView forward
		title: 'Recent clipboard items';
		priority: 90;
		object: [ self default ];
		view: #gtRecentItemsFor:
]
