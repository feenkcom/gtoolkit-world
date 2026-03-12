Extension { #name : #BrMenuItems }

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
