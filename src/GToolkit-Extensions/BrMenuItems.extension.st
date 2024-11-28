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
					addChild: self asElement) ]
]
