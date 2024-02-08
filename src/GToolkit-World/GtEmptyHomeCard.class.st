"
I am an empty card that displays nothing. Like an empty view or action, I can be useful if a card should only be conditionally displayed.
"
Class {
	#name : #GtEmptyHomeCard,
	#superclass : #GtHomeCard,
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtEmptyHomeCard >> create [
	"Do nothing"

]

{ #category : #testing }
GtEmptyHomeCard >> isEmpty [
	^ true
]
