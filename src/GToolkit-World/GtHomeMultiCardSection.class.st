"
I am a home section that can hold multiple cards. My cards are each defined in a method with a `<gtSectionCard>` pragma.
"
Class {
	#name : #GtHomeMultiCardSection,
	#superclass : #GtHomeStartPageSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeMultiCardSection >> cardMethods [
	^ self class methods select: [ :m | m hasPragmaNamed: 'gtSectionCard' ]
]

{ #category : #accessing }
GtHomeMultiCardSection >> cards [
	^ (self cardMethods collect: [ :m | m valueWithReceiver: self arguments: #() ])
		sort: [ :a :b | a priority < b priority ]
]

{ #category : #accessing }
GtHomeMultiCardSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: self sectionTitle).
	cardsContainer := self newCardsContainer.
	self cards do: [ :card | cardsContainer addChild: card asElement ].
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
