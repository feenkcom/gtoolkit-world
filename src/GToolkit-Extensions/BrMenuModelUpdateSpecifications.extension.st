Extension { #name : #BrMenuModelUpdateSpecifications }

{ #category : #'*GToolkit-Extensions' }
BrMenuModelUpdateSpecifications >> gtSpecificationsFor: aView [
	<gtView>
	specifications ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Specifications';
		items: [ specifications ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Announcer' text: [ :each | each announcer ];
		column: 'Announcement' text: [ :each | each announcement ];
		contextItemLabel: 'Inspect announcer'
			action: [ :anElement :aSpecification | anElement phlow spawnObject: aSpecification announcer ];
		contextItemLabel: 'Inspect announcement'
			action: [ :anElement :aSpecification | anElement phlow spawnObject: aSpecification announcement ]
]
