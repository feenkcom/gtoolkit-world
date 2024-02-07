Class {
	#name : #GtJobHomeCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'jobs'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #running }
GtJobHomeCard >> action [
	^ [ :aButton :aModel :anEvent | 
	[ [ :job | 
	job title: self title.
	self jobs
		withIndexDo: [ :assoc :index | 
			job
				progress: index / self jobs size;
				title: assoc key.
			assoc value value ] ] asJob run ] fork ]
]

{ #category : #accessing }
GtJobHomeCard >> jobs [
	^ jobs
]

{ #category : #accessing }
GtJobHomeCard >> jobs: anAssociationList [
	"Should have the form:
		{ 'description' -> [ ... ] .
			...
		}
	"

	jobs := anAssociationList
]
