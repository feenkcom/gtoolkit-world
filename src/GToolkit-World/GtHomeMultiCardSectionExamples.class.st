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
	^ GtHomeMultiCardSectionExamples new
		sectionTitle: 'Glamorous Toolkit book pages';
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
		page: (LeDatabase gtBook pageNamed: 'Glamorous Toolkit');
		yourself
]
