Extension { #name : #GtTemporaryDirectory }

{ #category : #'*GToolkit-Extensions' }
GtTemporaryDirectory >> gtPathFor: aView [
	<gtView>
	^ aView forward
		title: 'Path';
		priority: 55;
		object: [ self reference ];
		view: #gtPathFor:
]

{ #category : #'*GToolkit-Extensions' }
GtTemporaryDirectory >> gtTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Tree';
		priority: 15;
		object: [ self reference ];
		view: #gtTreeFor:
]
