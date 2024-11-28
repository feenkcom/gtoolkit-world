Extension { #name : #BrMenuItem }

{ #category : #'*GToolkit-Extensions' }
BrMenuItem >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ BrFrame new
			fitContentLimited;
			vFitContent;
			padding: (BlInsets all: 10);
			addChild: (BrVerticalPane new 
				fitContentLimited;
				layout: BlLinearLayout new;
				border: (BlBorder paint: BrGlamorousColors defaultButtonBorderColor width: 1);
				addChild: self asElement) ]
]
