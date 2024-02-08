Class {
	#name : #GtJobHomeCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'block'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #running }
GtJobHomeCard >> action [
	^ [ :aButton :aModel :anEvent | 
	[ [ :job | 
	job title: self title.
	self block value ] asJob run ] fork ]
]

{ #category : #accessing }
GtJobHomeCard >> block [
	^ block
]

{ #category : #accessing }
GtJobHomeCard >> block: anObject [
	block := anObject
]
