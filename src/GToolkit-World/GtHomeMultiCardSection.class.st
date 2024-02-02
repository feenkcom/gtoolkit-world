"
I am a home section that can hold multiple cards. 
My subclasses should have cards each defined in a method with a `<gtSectionCard>` pragma.
See {{gtMethod:name=GtHomeMultiCardSectionExamples>>#gtBook2CardSectionWithSubclassing}}. 

I can also have cards added explicitly with `addCard:`, with or without subclassing.
See {{gtMethod:name=GtHomeMultiCardSectionExamples>>#gtBook2CardSectionWithoutSubclassing}}. 

To install an instance of me or a subclass, define an extension method of {{gtClass:name=GtHome}} that has the `<gtHomeSection>` pragma and returns the instance. For example:
```
GtHome>>gtBookSection
	<gtHomeSection>
	^ GtHomeMultiCardSectionExamples new
		gtBook2CardSectionWithoutSubclassing
```


"
Class {
	#name : #GtHomeMultiCardSection,
	#superclass : #GtHomeSection,
	#instVars : [
		'sectionTitle',
		'cards'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeMultiCardSection >> addCard: aGtHomeCard [ 
	cards addLast: aGtHomeCard
]

{ #category : #accessing }
GtHomeMultiCardSection >> cardMethods [
	^ self class methods select: [ :m | m hasPragmaNamed: 'gtSectionCard' ]
]

{ #category : #accessing }
GtHomeMultiCardSection >> cards [
"Concatenate any cards that have been explicitly added with addCard: and cards defined in methods with the <gtSectionCard> pragma"
	^ cards
		copyWithAll: ((self cardMethods collect: [ :m | m valueWithReceiver: self arguments: #() ])
				sort: [ :a :b | a priority < b priority ])
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
	self sectionTitle: 'New section'.
	cards := OrderedCollection new.
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
