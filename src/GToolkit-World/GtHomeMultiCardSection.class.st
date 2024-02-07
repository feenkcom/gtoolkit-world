"
I am a home section that can hold multiple cards. 
My subclasses should have cards each defined in a method with a `<gtSectionCard>` pragma.
See {{gtClass:name=GtHomeMultiCardGetStartedSection}}.

To install an instance of me or a subclass, define an extension method of {{gtClass:name=GtHome}} that has the `<gtHomeSection>` pragma and returns the instance. For example: {{gtMethod:name=GtHome>>#getStartedSection}}

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
GtHomeMultiCardSection >> cardMethods [
	^ self class methods select: [ :m | m hasPragmaNamed: 'gtSectionCard' ]
]

{ #category : #accessing }
GtHomeMultiCardSection >> cards [
	<gtCollector>
	^ cards
		ifNil: [ cards := self cardMethods
					collect: [ :m | 
						[ thisContext
							object: self
							perform: m selector
							withArguments: {}
							inClass: self class ]
							on: Error
							do: [ :error | 
								error freeze.
								GtHomeErrorCard new targetError: error ] ].
			cards := (cards reject: #isEmpty) sortedAs: #priority ]
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

{ #category : #utility }
GtHomeMultiCardSection >> repoIsPresent: aRepoName [
	"Can be used to return an empty card if a repo already exists."

	^ IceRepository registry
		detect: [ :aRepository | aRepository name = aRepoName ]
		ifFound: [ :aRepository | true ]
		ifNone: [ false ]
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
