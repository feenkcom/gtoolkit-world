Class {
	#name : #GtHomeLepiterReadMoreToolbarStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'card'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #'api - instantiation' }
GtHomeLepiterReadMoreToolbarStencilBuilder >> buildDefault [
	^ BrToolbar new
		aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
		fitContent;
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
				icon: LeIcons lepiterIcon;
				label: 'Read more';
				action: self card action)
]

{ #category : #accessing }
GtHomeLepiterReadMoreToolbarStencilBuilder >> card [
	^ card
]

{ #category : #accessing }
GtHomeLepiterReadMoreToolbarStencilBuilder >> card: anObject [
	card := anObject
]

{ #category : #'api - instantiation' }
GtHomeLepiterReadMoreToolbarStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor push: card
]

{ #category : #initialization }
GtHomeLepiterReadMoreToolbarStencilBuilder >> reset [
	card := nil.
	super reset
]
