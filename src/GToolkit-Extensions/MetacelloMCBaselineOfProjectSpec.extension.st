Extension { #name : #MetacelloMCBaselineOfProjectSpec }

{ #category : #'*GToolkit-Extensions' }
MetacelloMCBaselineOfProjectSpec >> gtBaselineClassFor: aView [
	<gtView>
	self className asClassIfAbsent: [ ^ aView empty ].
	^ aView explicit
		title: 'Baseline class';
		priority: 1;
		stencil: [ | container |
			container := BrVerticalPane new
					matchParent;
					background: BrGlamorousColors backdropColor.
			container
				addAptitude: (BrLayoutResizerAptitude new common: [ container children ]);
				addChild: ((GtCoderElement forClass: self className asClass)
						disablePlayPage;
						margin: (BlInsets all: 10);
						background: Color white;
						addAptitude: BrShadowAptitude) ]
]
