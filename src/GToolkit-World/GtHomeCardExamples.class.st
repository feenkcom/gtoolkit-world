Class {
	#name : #GtHomeCardExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #example }
GtHomeCardExamples >> gtBookCard [
	<gtExample>
	^ GtHomeCard new
		title: 'Glamorous Toolkit Book';
		description: 'Read the Glamorous Toolkit book';
		priority: 10;
		page: (LeDatabase gtBook pageNamed: 'Glamorous Toolkit');
		yourself
]

{ #category : #example }
GtHomeCardExamples >> primaryDbTocCard [
	"A card for the TOC of the user's default database, with default title and tooltip description.
	NB: this will fail for a new installation with an empty primary Lepiter database."

	<gtExample>
	<noTest>
	| toc |
	toc := LeDatabase primaryDB tableOfContents.
	self
		assert: toc notNil
		description: 'This example supposes the primary db has a TOC'.
	^ GtHomeCard new
		page: toc;
		yourself
]
