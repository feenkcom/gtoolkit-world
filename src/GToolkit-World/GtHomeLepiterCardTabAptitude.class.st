Class {
	#name : #GtHomeLepiterCardTabAptitude,
	#superclass : #BrTabAptitude,
	#instVars : [
		'bar'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #initialization }
GtHomeLepiterCardTabAptitude >> initialize [
	super initialize.
	self add: (BrGlamorousTextLabelAptitude new foreground: Color black).
	self add: BrGlamorousTabActionbarAptitude new.
	self add: BrLayoutAlignmentAptitude new.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].
		
	bar := BlElement new
		visibility: BlVisibility hidden;
		background: self theme default primaryBorderColor;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored vertical alignBottom.
			c vertical exact: 2.
			c horizontal matchParent ].
	self
		add:
			(BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle
						padding:
							(BlInsets
								top: 0
								left: 3
								bottom: 1
								right: 3) ]).
	self
		add:
			(BrStyleCommonAptitude new
				@ bar;
				deselected: [ :aStyle | aStyle hidden ];
				selected: [ :aStyle | aStyle visible ]).
	self addChangeAddChildAs: #(content bar) with: [ bar ]
]
