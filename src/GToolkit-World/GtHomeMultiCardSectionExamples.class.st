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
	<notest>
	^ GtHomeCard new
		priority: 20;
		page: (LeDatabase gtBook pageNamed: 'About this book');
		yourself
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> gtBook2CardSectionWithSubclassing [
	"This example relies on this class being a subclass of
	GtHomeMultiCardSection and defining its cards in methods
	with the <gtSectionCard> pragma."

	<gtExample>
	<notest>
	^ self
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> gtBook2CardSectionWithoutSubclassing [
	"This example directly instantiates and configures
	GtHomeMultiCardSection without relying on the
	<gtSectionCard> pragma."

	<gtExample>
	<notest>
	^ GtHomeMultiCardSection new
		sectionTitle: 'Glamorous Toolkit book pages';
		addCard: self gtBookCard;
		addCard: self aboutThisBookCard;
		yourself
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> gtBookCard [
	<gtSectionCard>
	<gtExample>
	<notest>
	^ GtHomeCard new
		title: 'Glamorous Toolkit Book';
		description: 'Read the Glamorous Toolkit book';
		priority: 10;
		page: (LeDatabase gtBook pageNamed: 'Glamorous Toolkit');
		yourself
]

{ #category : #accessing }
GtHomeMultiCardSectionExamples >> sectionTitle [
	^ 'Glamorous Toolkit book pages'
]
