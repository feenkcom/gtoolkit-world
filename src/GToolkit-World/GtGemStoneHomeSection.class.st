Class {
	#name : #GtGemStoneHomeSection,
	#superclass : #GtHomeMultiCardSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtGemStoneHomeSection >> gemstoneSessionCard [
	<gtSectionCard>

	^ GtHomeMultiCardGetStartedSection new gemStoneSessionsCard
]

{ #category : #accessing }
GtGemStoneHomeSection >> sectionTitle [
	^ 'GemStone'
]
