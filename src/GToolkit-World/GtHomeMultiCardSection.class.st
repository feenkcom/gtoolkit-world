"
I am a home section that can hold multiple cards. 
My subclasses should have cards each defined in a method with a `<gtSectionCard>` pragma.
See {{gtClass:name=GtHomeMultiCardSectionExamples}} for an example.
"
Class {
	#name : #GtHomeMultiCardSection,
	#superclass : #GtHomeSection,
	#instVars : [
		'sectionTitle'
	],
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

{ #category : #'api - instantiation' }
GtHomeMultiCardSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: self sectionTitle).
	cardsContainer := self newCardsContainer.
	self cards do: [ :card | cardsContainer addChild: card asElement ].
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #initialization }
GtHomeMultiCardSection >> initialize [
	super initialize.
	self sectionTitle: 'New section'
]

{ #category : #accessing }
GtHomeMultiCardSection >> sectionTitle [
	"Set or override me in subclasses."

	^ sectionTitle
]

{ #category : #accessing }
GtHomeMultiCardSection >> sectionTitle: aString [
	sectionTitle := aString
]
