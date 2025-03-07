Extension { #name : #BrMenuLabelModel }

{ #category : #'*GToolkit-Extensions' }
BrMenuLabelModel >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [
			BrFrame new 
				matchParent;
				padding: (BlInsets all: 20);
				addChild: (self acceptVisitor: BrGlamorousMenuElementBuilder new) ]
]
