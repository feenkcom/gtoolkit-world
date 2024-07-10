Class {
	#name : #GtHomeListItemElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'label',
		'actOnButton',
		'item'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeListItemElement >> initialize [
	| aToolbar |
	super initialize.
	
	self
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		padding: (BlInsets top: 5 right: 10 bottom: 5 left: 10).
	
	label := self newCandidateLabel.
	actOnButton := self newActOnButton.

	aToolbar := BrHorizontalPane new
		fitContent;
		background: Color transparent;
		addChildren: { actOnButton }.

	self addChildren: { 
		label.
		aToolbar
	}.
	
	self addAptitude: (BrStyleCommonAptitude new
		@ aToolbar;
		default: [ :aStyle | aStyle visibility: BlVisibility gone ];
		when: [ :aState | aState hovered or: aState selected ]
			style: [ :aStyle | aStyle visibility: BlVisibility visible ] ).
]

{ #category : #accessing }
GtHomeListItemElement >> item [
	^ item
]

{ #category : #accessing }
GtHomeListItemElement >> item: anObject [
	item := anObject.
	
	self onItemChanged
]

{ #category : #accessing }
GtHomeListItemElement >> newActOnButton [
	^ BrButton new
		id: GtSpotterCandidateActOnButtonId;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		label: 'Show page';
		action: [ :aButton | 
			GtWorldUtility
				showSpaceWithTitle: self item title
				icon: LeIcons lepiterPage
				inPagerWith: [ self item asPhlowTool asElementDo: [ :e | e ] ] asStencil
				from: self ];
		beTinySize;
		yourself
]

{ #category : #accessing }
GtHomeListItemElement >> newCandidateLabel [
	^ BrLabel new
		hMatchParent;
		beSmallSize;
		aptitude: BrGlamorousLabelAptitude new;
		addAptitude: GtHomeLepiterCardListItemAptitude new
]

{ #category : #accessing }
GtHomeListItemElement >> onItemChanged [
	label text: self item title
]
