Class {
	#name : #GtHomeLepiterEditToolbarStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'card'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #'api - instantiation' }
GtHomeLepiterEditToolbarStencilBuilder >> buildDefault [
	^ BrToolbar new
		aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
		fitContent;
		addChild: self newAddSnippetButtonWithDropdownAptitude
]

{ #category : #accessing }
GtHomeLepiterEditToolbarStencilBuilder >> card [
	^ card
]

{ #category : #accessing }
GtHomeLepiterEditToolbarStencilBuilder >> card: anObject [
	card := anObject
]

{ #category : #private }
GtHomeLepiterEditToolbarStencilBuilder >> newAddSnippetButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
		icon: BrGlamorousVectorIcons add;
		label: 'Add new page'
]

{ #category : #private }
GtHomeLepiterEditToolbarStencilBuilder >> newAddSnippetButtonWithDropdownAptitude [
	| aButton anAptitude |
	aButton := self newAddSnippetButton.
	aButton userData at: #gtHomeLepiterBaseCard put: self card.
	anAptitude := BrGlamorousWithExplicitDropdownAptitude
			handle: [ | aHandle |
				aHandle := self newAddSnippetButton.
				aHandle aptitude - BrGlamorousButtonExteriorAptitude.
				aHandle ]
			content: [ | aCard |
				aCard := aButton userData at: #gtHomeLepiterBaseCard.
				GtSpotterDropdownButtonStencil new
					valuable: (LeContextMenuSpotterStart new database: aCard database);
					extent: [ 300 @ 400 ];
					spotterModelDo: [ :aSpotter | aSpotter hidePreview ];
					objectActOn: [ :anActOnEvent :aMenuItem :theButton | 
						self
							pageWithSnippetRequested: aMenuItem asSnippet
							inDatabase: aCard database
							fromCard: aCard
							button: aButton.
						anActOnEvent beActed ];
					spotterElementFor: aButton ]
			containerDo: [ :aMenuContainer | 
				aMenuContainer background: BrGlamorousColors secondaryHeaderBackgroundColor ].

	aButton addAptitude: anAptitude.
	^ aButton
]

{ #category : #private }
GtHomeLepiterEditToolbarStencilBuilder >> pageWithSnippetRequested: aSnippet inDatabase: aLeDatabase fromCard: aCard button: aButton [
	| aPage |
	aPage := LePage unnamedPage.
	aPage addSnippet: aSnippet.
	aLeDatabase addPage: aPage.

	BlTaskAction
		enqueueElement: aButton
		action: [ aCard spawnPage: aPage from: aButton ]
]

{ #category : #'api - instantiation' }
GtHomeLepiterEditToolbarStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor push: card
]

{ #category : #initialization }
GtHomeLepiterEditToolbarStencilBuilder >> reset [
	card := nil.
	super reset
]
