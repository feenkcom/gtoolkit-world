"
Many things to do here — add a debug button etc
"
Class {
	#name : #GtHomeErrorCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'targetError'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeErrorCard >> cardLabelAptitude [
	^ super cardLabelAptitude foreground: BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
GtHomeErrorCard >> defaultAction [
	^ [ :aButton :aModel :anEvent | 
		self targetError ifNotNil: [ 
			self spawnObject: self targetError from: aButton ] ]
]

{ #category : #accessing }
GtHomeErrorCard >> defaultTitle [
	^ self targetError description
]

{ #category : #accessing }
GtHomeErrorCard >> targetError [
	^ targetError
]

{ #category : #accessing }
GtHomeErrorCard >> targetError: anObject [
	targetError := anObject
]
