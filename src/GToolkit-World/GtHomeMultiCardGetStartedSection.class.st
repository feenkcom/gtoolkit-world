"
I illustrate a typical usage of a multi-card home section:
- I subclass {{gtClass:name=GtHomeMultiCardSection}}
- I override (or set)  `sectionTitle`
- I define card methods with the `<gtSectionCard>` pragma
"
Class {
	#name : #GtHomeMultiCardGetStartedSection,
	#superclass : #GtHomeMultiCardSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #example }
GtHomeMultiCardGetStartedSection >> aboutThisBookCard [
	"<gtSectionCard>"
	<gtExample>
	<notest>
	^ GtHomeCard page
		priority: 20;
		pageName: 'About this book';
		databaseName: self gtBookName;
		yourself
]

{ #category : #initialization }
GtHomeMultiCardGetStartedSection >> defaultPriority [
	^ 30
]

{ #category : #example }
GtHomeMultiCardGetStartedSection >> gtBookCard [
	<gtSectionCard>
	<gtExample>
	<notest>
	^ GtHomeCard page
		title: 'Glamorous Toolkit Book';
		description: 'Read the Glamorous Toolkit book';
		priority: 10;
		pageName: 'Glamorous Toolkit';
		databaseName: self gtBookName;
		yourself
]

{ #category : #example }
GtHomeMultiCardGetStartedSection >> gtBookCardSection [
	<gtExample>
	<notest>
	^ self
]

{ #category : #accessing }
GtHomeMultiCardGetStartedSection >> gtBookName [
	^ 'Glamorous Toolkit Book'
]

{ #category : #example }
GtHomeMultiCardGetStartedSection >> gtTourCard [
	<gtExample>
	^ GtHomeCard job
		title: 'GtTour';
		description: 'Open the GtTour slideshow';
		priority: 20;
		block: [ GtPresenterSlideShow openInSpace: GtTour ];
		yourself
]

{ #category : #accessing }
GtHomeMultiCardGetStartedSection >> sectionTitle [
	^ 'Glamorous Toolkit book pages'
]
