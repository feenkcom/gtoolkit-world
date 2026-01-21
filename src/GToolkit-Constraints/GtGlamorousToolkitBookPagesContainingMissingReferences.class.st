"
Theis class checks that pages in the GT book not contain missing references to missing classes or methods.
Violations are reported in the *Issues* tab.

*Caveat:* Some pages are tutorials containing references to classes and methods that are only created by the user in the course of the tutorial, *e.g.*, by evaluating *changes* snippets. To prevent these pages from being reported as issues, simply include a link in such pages to the GT book page:
`Pages containing missing references - allowed failures`



"
Class {
	#name : #GtGlamorousToolkitBookPagesContainingMissingReferences,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #analysing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> collectAllowedMissingCodeReferencesInKnowledgeBase: aKnowledgebase into: aResultsGroup [ 
	^ self 
		collectMissingCodeReferencesInKnowledgeBase: aKnowledgebase 
		into: aResultsGroup 
		matchingPage: [ :aPage |
			(self shouldIgnoreMissingCodeReferencesInPage: aPage) not ]
]

{ #category : #analysing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> collectIgnoredMissingCodeReferencesInKnowledgeBase: aKnowledgebase into: aResultsGroup [
	^ self 
		collectMissingCodeReferencesInKnowledgeBase: aKnowledgebase 
		into: aResultsGroup 
		matchingPage: [ :aPage |
			self shouldIgnoreMissingCodeReferencesInPage: aPage ]
]

{ #category : #analysing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> collectMissingCodeReferencesInKnowledgeBase: aKnowledgebase into: aResultsGroup matchingPage: aPageConditionBlock [
	aKnowledgebase pagesDo: [ :aPage |
		| missingCodeReferences |

		missingCodeReferences := self findMissingReferencesInPage: aPage.
		missingCodeReferences isNotEmpty ifTrue: [
			(aPageConditionBlock value: aPage)
				ifTrue: [ 
					aResultsGroup addMissingReferences: missingCodeReferences ] ] ]
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> description [
	^ 'All references to methods and classes from the Glamorous Toolkit Book should be present in the image'
]

{ #category : #visiting }
GtGlamorousToolkitBookPagesContainingMissingReferences >> findMissingReferencesInPage: aPage [
	| visitor missingCodeReferences |
	visitor := LeMissingCodeReferencesModelVisitor new.
			
	missingCodeReferences := visitor missingReferencesInPage: aPage.
	^ missingCodeReferences
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> gtIgnoredItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Ignored issues';
		priority: 5;
		items: [ self ignoredIssues ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' text: [ :eachItem | eachItem gtDisplayText ];
		actionUpdateButton.
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> ignoredIssues [
	| results |
	results := LePageValidatorMissingReferencesGroup new.
	self knowledgebasesToAnalyse do: [ :aKnowledgebase |  
		self 
			collectIgnoredMissingCodeReferencesInKnowledgeBase: aKnowledgebase 
			into: results  ].
	^ results
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> issues [
	| results |
	results := LePageValidatorMissingReferencesGroup new.
	self knowledgebasesToAnalyse do: [ :aKnowledgebase |  
		self 
			collectAllowedMissingCodeReferencesInKnowledgeBase: aKnowledgebase 
			into: results ].
	^ results
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> knowledgebasesToAnalyse [
	^ { LeDatabasesRegistry defaultLogicalDatabase databaseNamed: LeDatabase gtBookName }
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> name [
	^ 'Glamorous Toolkit Book Pages Containing Missing References'
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> nameOfPageWithAllowedFailures [
	^ 'Pages containing missing references - allowed failures'
]

{ #category : #testing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> shouldIgnoreMissingCodeReferencesInPage: aPage [
	^ aPage allOutgoingTextualLinks
		anySatisfy: [ :aLink | 
			aLink targetPageTitle = self nameOfPageWithAllowedFailures ]
]
