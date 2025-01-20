Extension { #name : #BrMenuModel }

{ #category : #'*GToolkit-Extensions' }
BrMenuModel >> gtLiveFor: aView [
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
					clipChildren: false;
					margin: (BlInsets all: 20);
					addChild: (BrMenuSteppedElement new
						addAptitude: BrMenuContainerAptitude new;
						menuModel: self)) ]
]
