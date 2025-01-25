Extension { #name : #BrMenuTextLabelModel }

{ #category : #'*GToolkit-Extensions' }
BrMenuTextLabelModel >> gtItemLabel [
	| aText |
	aText := self text asString asRopedText.
	
	self preview ifNotNil: [ :aString | 
		aText appendString: ' '.
		aText append: (aString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
	].
	
	self shortcut ifNotNil: [ :aString | 
		aText append: ((' [', aString, ']') asRopedText foreground: BrGlamorousColors defaultButtonTextColor)
	].
	
	^ aText
]
