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
GtHomeMultiCardSectionExamples >> gtBook2CardSection [
	<gtExample>
	<notest>
	^ self
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
