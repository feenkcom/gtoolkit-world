Extension { #name : #BrMenuItems }

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
				padding: (BlInsets all: 10);
				addChild: (BrMenuSteppedElement new
					menuModel: self) ]
]

{ #category : #'*GToolkit-Extensions' }
BrMenuItems >> gtPlaygroundFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Playground';
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
							stencil: [ self ])) ]
]
