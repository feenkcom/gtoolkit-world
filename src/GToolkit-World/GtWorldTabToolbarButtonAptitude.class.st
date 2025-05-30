Class {
	#name : #GtWorldTabToolbarButtonAptitude,
	#superclass : #BrStyleCommonAptitude,
	#category : #'GToolkit-World-UI'
}

{ #category : #initialization }
GtWorldTabToolbarButtonAptitude >> initialize [
	super initialize.

	self
		addAll: {BrGlamorousButtonIconAptitude new.
				BrGlamorousButtonWithLabelTooltipAptitude2 new.
				BrLayoutAlignmentAptitude new}.

	self addChangeProperty: #(widget layout) with: [ BlLinearLayout horizontal ].

	self
		default: [ :aStyle | 
			aStyle geometry: BlCircleGeometry new.
			aStyle layout: BlLinearLayout horizontal alignCenter.
			aStyle background: Color transparent ];
		hovered: [ :aStyle | aStyle background: (Color gray alpha: 0.2) ];
		pressed: [ :aStyle | aStyle background: (Color gray alpha: 0.4) ]
]
