"
I illustrate a typical usage of a multi-card home section:
- I subclass {{gtClass:name=GtHomeMultiCardSection}}
- I override (or set)  `sectionTitle`
- I define card methods with the `<gtSectionCard>` pragma
"
Class {
	#name : #GtHomeMultiCardSectionExamples,
	#superclass : #GtHomeMultiCardSection,
	#category : #'GToolkit-World-Examples'
}

{ #category : #example }
GtHomeMultiCardSectionExamples >> aboutThisBookCard [
	<gtSectionCard>
	<gtExample>
	<noTest>
	^ GtHomeCard page
		priority: 20;
		page: (LeDatabase gtBook pageNamed: 'About this book');
		yourself
]

{ #category : #accessing }
GtHomeMultiCardSectionExamples >> defaultPriority [
	^ 50
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> errorCard [
	<gtSectionCard>
	<gtExample>
	^ GtHomeCard errorCard
		priority: 30;
		targetError: Error new;
		yourself
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> gemStoneSessionsCard [
	<gtSectionCard>
	<gtExample>
	
	^ GtHomeCard explicit
		priority: 50;
		stencil: [BrFrame new
			background: Color white;
			aptitude: BrShadowAptitude new beLarge;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
			padding: (BlInsets top: 0 bottom: 10 left: 10 right: 10);
			margin: (BlInsets
				top: self spaceGap
				left: 2 * self spaceGap
				bottom: 2 * self spaceGap
				right: 2 * self spaceGap);
			size: 325 @ 150;
			addChild: (GtGemStoneSessionsCardWidget new
				matchParent;
				constraintsDo: [ :c | 
					c frame horizontal alignLeft.
					c frame vertical alignCenter ])]
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> gtBook2CardSection [
	"This example relies on this class being a subclass of
	GtHomeMultiCardSection and defining its cards in methods
	with the <gtSectionCard> pragma."

	<gtExample>
	<noTest>
	| section |
	section := self.
	self assert: section cards size equals: 3.
	^ section
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> gtBookCard [
	<gtSectionCard>
	<gtExample>
	<noTest>
	^ GtHomeCard page
		title: 'Glamorous Toolkit Book';
		description: 'Read the Glamorous Toolkit book';
		priority: 10;
		page: (LeDatabase gtBook pageNamed: 'Glamorous Toolkit');
		yourself
]

{ #category : #accessing }
GtHomeMultiCardSectionExamples >> sectionTitle [
	^ 'Learn Glamorous Toolkit'
]
