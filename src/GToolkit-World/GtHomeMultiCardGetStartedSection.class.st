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
	^ GtHomeCard lepiterBaseWithTableOfContents
		title: 'Glamorous Toolkit Book';
		description: 'Read the extensive book';
		priority: 10;
		pageName: 'Glamorous Toolkit';
		databaseName: self gtBookName;
		readMoreToolbar;
		details: [ :db | 
			| snippets somePages |
			somePages := db pages select: #shouldAppearInIndexOrDailyNotes.
			snippets := somePages flatCollect: #allChildrenDepthFirst.
			'The book is expressed as a knowledge base. It documents the environment in '
				, somePages size asString , ' lovely pages containing '
				, snippets size asString , ' snippets of '
				, (snippets groupedBy: #class) size asString , ' different kinds.' ]
				yourself
]

{ #category : #example }
GtHomeMultiCardGetStartedSection >> gtBookCardSection [
	<gtExample>
	<notest>
	^ self
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

{ #category : #example }
GtHomeMultiCardGetStartedSection >> gtUsedKnowledgeBaseCard [
	<gtSectionCard>
	<gtExample>
	<notest>
	^ GtHomeCard lepiterBaseWithTableOfContents
		title: 'Local knowledge base';
		description: 'Explore your local knowledge base';
		priority: 1;
		primaryKnowledgebase;
		recentlyEditedPage;
		editableToolbar;
		details: [ :db | 
			| snippets somePages |
			somePages := db pages select: #shouldAppearInIndexOrDailyNotes.
			snippets := somePages flatCollect: #allChildrenDepthFirst.
			'Your local knowledge base includes '
				, somePages size asString , ' pages containing '
				, snippets size asString , ' snippets of '
				, (snippets groupedBy: #class) size asString , ' different kinds.' ]
				yourself
]

{ #category : #accessing }
GtHomeMultiCardGetStartedSection >> sectionTitle [
	^ 'Start'
]
