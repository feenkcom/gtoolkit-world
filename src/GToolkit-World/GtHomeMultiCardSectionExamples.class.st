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
GtHomeMultiCardSectionExamples >> emptyCard [
	"This card should not appear in the section."

	<gtSectionCard>
	<gtExample>
	<notest>
	^ GtHomeCard empty
		priority: 30;
		yourself
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> gtBook2CardSection [
	"This example relies on this class being a subclass of
	GtHomeMultiCardSection and defining its cards in methods
	with the <gtSectionCard> pragma."

	<gtExample>
	<notest>
	| section |
	section := self.
	self assert: section cards size equals: 2.
	^ section
]

{ #category : #example }
GtHomeMultiCardSectionExamples >> gtBookCard [
	<gtSectionCard>
	<gtExample>
	<notest>
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
