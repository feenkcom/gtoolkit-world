Extension { #name : #GtJUnitTestCase }

{ #category : #'*GToolkit-Extensions' }
GtJUnitTestCase >> gtPharoMethodFor: aView [
	<gtView>
	self pharoMethod ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Method';
		priority: 20;
		question: 'What Pharo method was executed?';
		stencil: [ (GtPharoMethodCoder forMethod: self pharoMethod) asExpandedOnlyElement
				vFitContentLimited ]
]
