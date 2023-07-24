Class {
	#name : #GtHomeSectionsCollector,
	#superclass : #GtPhlowCollector,
	#category : #'GToolkit-World-Utilities'
}

{ #category : #accessing }
GtHomeSectionsCollector class >> defaultHomeSectionPragmaName [
	^ #gtHomeSection
]

{ #category : #accessing }
GtHomeSectionsCollector class >> homeSectionCollectorAnnotation [
	<classAnnotation>
	
	^ GtHomeSectionCollectorClassAnnotation new 
		priority: 55
]

{ #category : #actions }
GtHomeSectionsCollector >> collect [
	<return: #Array of: #GtPhlowView>
	<gtCollector>
	| sectionStencils |
	sectionStencils := self collectPragmas
		flatCollect: [ :eachPragma | 
			"Add error handling"
			(thisContext
				object: self object
				perform: eachPragma methodSelector
				withArguments: {}
				inClass: self object class) asCollection ].
	self sortByPriority: sectionStencils.
	^ sectionStencils
]

{ #category : #initialization }
GtHomeSectionsCollector >> initializePragmaNames [
	pragmaNames := { self class defaultHomeSectionPragmaName }
]
