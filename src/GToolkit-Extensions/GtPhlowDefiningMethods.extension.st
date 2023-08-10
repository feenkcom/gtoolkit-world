Extension { #name : #GtPhlowDefiningMethods }

{ #category : #'*GToolkit-Extensions' }
GtPhlowDefiningMethods >> gtSourceFor: aView [
	<gtView>
	self methods ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Source';
		stencil: [ 
			| aContainer |
			aContainer := BlElement new.
			aContainer 
				layout: BlLinearLayout vertical;
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal matchParent ].
			self methods do: [ :eachMethod | 
				aContainer addChild: (
					(GtPharoMethodCoder forMethod: eachMethod) asCoderViewModel
						withHeader;
						expanded: true;
						asElement) ].
			aContainer asScrollableElement]
]
