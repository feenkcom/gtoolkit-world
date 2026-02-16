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
	<noTest>
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
GtHomeMultiCardGetStartedSection >> gemStoneSessionsCard [
	"<gtSectionCard>"

	<gtExample>
	<return: #GtExplicitHomeCard>
	^ GtHomeCard explicit
		priority: 50;
		stencil: [ BrFrame new
				background: Color white;
				aptitude: BrShadowAptitude new beLarge;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
				padding: (BlInsets
						top: 0
						bottom: 10
						left: 10
						right: 10);
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
							c frame vertical alignCenter ]) ]
]

{ #category : #example }
GtHomeMultiCardGetStartedSection >> gtBookCard [
	<gtSectionCard>
	<gtExample>
	<noTest>
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
			'The book is expressed as a knowledge base and documents the environment in '
				, somePages size asString , ' pages containing '
				, snippets size asString , ' snippets of '
				, (snippets groupedBy: #class) size asString , ' different kinds.' ]
				yourself
]

{ #category : #example }
GtHomeMultiCardGetStartedSection >> gtBookCardSection [
	<gtExample>
	<noTest>
	^ self
]

{ #category : #example }
GtHomeMultiCardGetStartedSection >> gtTourCard [
	<gtExample>
	<return: #GtJobHomeCard>
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
	<noTest>
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
