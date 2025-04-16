Extension { #name : #BrWithExplicitPopoverAptitude }

{ #category : #'*GToolkit-Extensions' }
BrWithExplicitPopoverAptitude >> gtMenuContainerFor: aView [
	<gtView>
	menuContainer ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Menu cache';
		object: [ menuContainer ];
		view: #gtElementCacheFor:
]

{ #category : #'*GToolkit-Extensions' }
BrWithExplicitPopoverAptitude >> gtSourceCodeFor: aView [
	<gtView>
	(menuStencil respondsTo: #gtSourceCodeFor:)
		ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source code';
		object: [ menuStencil ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Extensions' }
BrWithExplicitPopoverAptitude >> gtSubmenusFor: aView [
	<gtView>
	submenus ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Submenus';
		tooltip: 'Submenus that were opened from this context menu or dropdown';
		items: [ self submenus asOrderedCollection ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each gtDisplayString ]
]
