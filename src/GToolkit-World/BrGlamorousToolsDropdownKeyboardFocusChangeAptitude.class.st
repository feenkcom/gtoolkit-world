Class {
	#name : #BrGlamorousToolsDropdownKeyboardFocusChangeAptitude,
	#superclass : #BrKeyboardFocusChangeAptitude,
	#category : #'GToolkit-World-UI'
}

{ #category : #initialization }
BrGlamorousToolsDropdownKeyboardFocusChangeAptitude >> initialize [
	super initialize.
	self rootValuable: [ :anElement | anElement parent parent ]
]
