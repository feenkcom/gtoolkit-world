Class {
	#name : #GtHomePageCard,
	#superclass : #GtHomeCard,
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomePageCard >> defaultAction [
	^ [ :aButton :aModel :anEvent | self page ifNotNil: [ self spawnPage: self page from: aButton ] ]
]

{ #category : #accessing }
GtHomePageCard >> defaultDescription [
	^ page ifNil: [ super defaultDescription ] ifNotNil: [ page title ]
]

{ #category : #accessing }
GtHomePageCard >> defaultTitle [
	^ page ifNil: [ super defaultTitle ] ifNotNil: [ page title ]
]

{ #category : #accessing }
GtHomePageCard >> page [
	"NB: Could be nil"

	^ page
]

{ #category : #accessing }
GtHomePageCard >> page: aLePage [
	page := aLePage
]
