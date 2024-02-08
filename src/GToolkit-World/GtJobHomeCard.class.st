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
		withIndexDo: [ :aBlock :index | 
			job
				progress: index / self jobs size;
				title: aBlock printString.
			aBlock value ] ] asJob run ] fork ]
]

{ #category : #accessing }
GtJobHomeCard >> job: aBlock [
	self jobs: {aBlock}
]

{ #category : #accessing }
GtJobHomeCard >> jobs [
	^ jobs
]

{ #category : #accessing }
GtJobHomeCard >> jobs: aBlockArray [
	jobs := aBlockArray
]
