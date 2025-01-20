Extension { #name : #BrWithExplicitMenuAptitude }

{ #category : #'*GToolkit-Extensions' }
BrWithExplicitMenuAptitude >> gtMenuContainerFor: aView [
	<gtView>
	menuContainer ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Menu cache';
		object: [ menuContainer ];
		view: #gtElementCacheFor:
]
