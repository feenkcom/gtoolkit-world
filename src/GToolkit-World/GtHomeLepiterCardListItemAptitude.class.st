Class {
	#name : #GtHomeLepiterCardListItemAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#category : #'GToolkit-World-Helpers'
}

{ #category : #initialization }
GtHomeLepiterCardListItemAptitude >> initialize [
	super initialize.
	self
		default: [ :aStyle | aStyle background: self theme item deselectedColor ];
		hovered: [ :aStyle | aStyle background: self theme item hoveredColor ];
		pressed: [ :aStyle | aStyle background: self theme item pressedColor ]
]
