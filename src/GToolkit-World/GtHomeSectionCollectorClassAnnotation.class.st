"
I am annotation for registering section collectors for the home screen.
"
Class {
	#name : #GtHomeSectionCollectorClassAnnotation,
	#superclass : #ClassAnnotation,
	#instVars : [
		'shouldDisableAnnotation'
	],
	#category : #'GToolkit-World-Utilities'
}

{ #category : #accessing }
GtHomeSectionCollectorClassAnnotation class >> currentCollectorAnnotation [
	| collectorAnnotations |
	collectorAnnotations := GtHomeSectionCollectorClassAnnotation registeredInstances.
	collectorAnnotations ifEmpty: [ ^ GtHomeSectionsCollector new ].
	
	^ (collectorAnnotations sorted: [ :annotation | 
		annotation priority ] ascending) first
]

{ #category : #accessing }
GtHomeSectionCollectorClassAnnotation >> disableAnnotation [
	shouldDisableAnnotation := true
]

{ #category : #testing }
GtHomeSectionCollectorClassAnnotation >> isForbidden [
	^ shouldDisableAnnotation ifNil: [ false ]
]
