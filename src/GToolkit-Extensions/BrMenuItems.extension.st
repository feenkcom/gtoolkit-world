Extension { #name : #BrMenuItems }

{ #category : #'*GToolkit-Extensions' }
BrMenuItems >> gtContextMenuFor: aView [
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
						addAptitude: (BrWithExplicitMenuAptitude new
							beContextMenu
							handleSubmenu: [ self ])) ]
]

{ #category : #'*GToolkit-Extensions' }
BrMenuItems >> gtDropdownFor: aView [
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
						addAptitude: (BrWithExplicitMenuAptitude new
							beDropdown;
							handle: [ BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude 
											- BrGlamorousButtonExteriorAptitude;
										label: 'Dropdown' ] 
								submenu: [ self ])) ]
]

{ #category : #'*GToolkit-Extensions' }
BrMenuItems >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [
			BrFrame new 
				matchParent;
				addChild: (BrFrame new
					matchParent;
					margin: (BlInsets all: 10);
					addChild: (BrMenuSteppedElement new
						addAptitude: BrMenuContainerAptitude new;
						menuModel: self)) ]
]
