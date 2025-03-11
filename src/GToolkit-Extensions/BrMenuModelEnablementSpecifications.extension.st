Extension { #name : #BrMenuModelEnablementSpecifications }

{ #category : #'*GToolkit-Extensions' }
BrMenuModelEnablementSpecifications >> gtSpecificationsFor: aView [
	<gtView>
	specifications ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Specifications';
		items: [ specifications ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Specification' text: [ :each | each ]
]
