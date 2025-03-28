Class {
	#name : #BrGlamorousToolsDropdownKeyboardFocusChangeAptitude,
	#superclass : #BrKeyboardFocusChangeAptitude,
	#category : #'GToolkit-World'
}

{ #category : #initialization }
BrGlamorousToolsDropdownKeyboardFocusChangeAptitude >> initialize [
	super initialize.
	self rootValuable: [ :anElement | anElement parent parent ]
]
