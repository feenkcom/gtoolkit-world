"
I am obsolete. Use GtHome>>#getStartedSection instead.
"
Class {
	#name : #GtHomeGetStartedSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Deprecated'
}

{ #category : #accessing }
GtHomeGetStartedSection >> create [
	| sectionContainer cardsContainer |
	self deprecated: 'Obsolete. See GtHome>>#getStartedSection'.
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Get started').
	cardsContainer := self newCardsContainer.
	cardsContainer
		addChild: (self
				newLepiterPageCardForPageNamed: 'Glamorous Toolkit'
				inDatabaseNamed: 'Glamorous Toolkit Book'
				withTitle: 'Glamorous Toolkit Book'
				andDescription: 'Read the Glamorous Toolkit book').

	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
