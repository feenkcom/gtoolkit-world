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
						addAptitude: (BrGlamorousWithExplicitContextMenuAptitude 
							menu: self)) ]
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
						addAptitude: (BrGlamorousWithExplicitDropdownAptitude new
							handle: [ BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude 
											- BrGlamorousButtonExteriorAptitude;
										label: 'Dropdown' ] 
								submenu: self)) ]
]

{ #category : #'*GToolkit-Extensions' }
BrMenuItems >> gtGroupsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Grouped menu items';
		priority: 10;
		items: [ self groups ifNil: [ #() ] ];
		children: #gtItemChildren;
		expandAll;
		column: 'Label' text: [ :anItem | anItem gtItemLabel ];
		column: 'Selection'
			text: #gtItemSelection
			weight: 0.2;
		column: 'Depth'
			text: #gtItemDepth
			weight: 0.2;
		column: 'Type' text: #class weight: 0.5;
		actionUpdateButton
]
