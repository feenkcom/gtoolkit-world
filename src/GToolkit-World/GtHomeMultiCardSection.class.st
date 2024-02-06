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
	<gtCollector>
	^ cards
		ifNil: [ cards := (self cardMethods
					collect: [ :m | 
						thisContext
							object: self
							perform: m selector
							withArguments: {}
							inClass: self class ]) sortedAs: #priority ]
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
