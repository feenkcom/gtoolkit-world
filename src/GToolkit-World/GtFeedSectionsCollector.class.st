Class {
	#name : #GtFeedSectionsCollector,
	#superclass : #GtHomeSectionsCollector,
	#category : #'GToolkit-World-Utilities'
}

{ #category : #accessing }
GtFeedSectionsCollector class >> defaultHomeSectionPragmaName [
	^ #gtFeedSection
]

{ #category : #accessing }
GtFeedSectionsCollector class >> homeSectionCollectorAnnotation [
	<classAnnotation>
	
	^ GtHomeSectionCollectorClassAnnotation new 
		disableAnnotation
]
