Extension { #name : #BrMenu }

{ #category : #'*GToolkit-Extensions' }
BrMenu >> gtContextMenuFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Context menu';
		priority: 2;
		stencil: [ 
			BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (BlElement new
						size: 25 @ 25;
						relocate: 30@30;
						geometry: BlCircleGeometry new;
						background: (Color red alpha: 0.5);
						addEventHandler: BlPullHandler new 
							disallowOutOfBounds;
						addAptitude: (BrGlamorousWithExplicitContextMenuAptitude 
							menu: self)) ]
]

{ #category : #'*GToolkit-Extensions' }
BrMenu >> gtDropdownFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Dropdown';
		priority: 5;
		stencil: [ 
			BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (BrButton new
						aptitude: BrGlamorousButtonWithLabelAptitude ;
						label: 'Dropdown';
						relocate: 30@30;
						addEventHandler: BlPullHandler new 
							disallowOutOfBounds;
						addAptitude: (BrGlamorousWithExplicitDropdownAptitude new
							handle: [ BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude 
											- BrGlamorousButtonExteriorAptitude;
										label: 'Dropdown' ] 
								submenu: self)) ]
]
