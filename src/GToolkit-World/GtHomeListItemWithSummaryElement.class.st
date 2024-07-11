Class {
	#name : #GtHomeListItemWithSummaryElement,
	#superclass : #GtHomeListItemElement,
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeListItemWithSummaryElement >> newCandidateLabel [
	^ LePageTitleAndSummaryElement new
		hMatchParent;
		vFitContent;
		addAptitude: GtHomeLepiterCardListItemAptitude;
		margin: (BlInsets all: 0)
]

{ #category : #accessing }
GtHomeListItemWithSummaryElement >> onItemChanged [
	label contentViewModel: self item asContentUIModel
]
