Extension { #name : #GtCoderAddOns }

{ #category : #'*GToolkit-Extensions' }
GtCoderAddOns >> gtViewContextActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Context actions' translated;
		priority: 25;
		items: [ self contextActions ];
		column: 'Title' text: [ :anAction | anAction title ifNil: [ '' ] ];
		column: 'Action' text: [ :anAction | anAction action ]
]

{ #category : #'*GToolkit-Extensions' }
GtCoderAddOns >> gtViewContextMenuActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Context menu actions' translated;
		priority: 26;
		items: [ self contextMenuActions
				sorted: [ :anAction | 
					anAction group
						ifNotNil: #priority
						ifNil: [ BrMenuItemGroupConfiguration default priority ] ] ascending
						, [ :anAction | anAction priority ] ascending ];
		column: 'Group'
			text: [ :anAction | 
				anAction group
					ifNotNil: [ :aGroup | 
						'{1} ({2})'
							format: {aGroup name.
									aGroup priority} ]
					ifNil: [ '' ] ]
			width: 120;
		column: 'Priority'
			text: #priority
			width: 60;
		column: 'Title' text: [ :anAction | anAction title ifNil: [ '' ] ];
		column: 'Action' text: [ :anAction | anAction action ]
]

{ #category : #'*GToolkit-Extensions' }
GtCoderAddOns >> gtViewKeybindingsFor: aView [
	<gtView>
	self shortcuts ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Shortcuts' translated;
		priority: 10;
		items: [ self shortcuts asArray ];
		column: 'Name' text: [ :each | each name ifNil: [ each gtDisplayString ] ];
		column: 'Combination' text: [ :each | each combination gtDisplayString ]
]

{ #category : #'*GToolkit-Extensions' }
GtCoderAddOns >> gtViewMainActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Main actions' translated;
		priority: 20;
		items: [ self mainActions ];
		column: 'Title'
			text: [ :anAction |  anAction title ifNil: [ '' ] ];
		column: 'Action' 
			text: [ :anAction | anAction action ]
			weight: 3
]
