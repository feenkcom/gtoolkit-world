Extension { #name : #BrMenuItemGroup }

{ #category : #'*GToolkit-Extensions' }
BrMenuItemGroup >> gtItemLabel [
	^ 'Group: ', self id asString
]

{ #category : #'*GToolkit-Extensions' }
BrMenuItemGroup >> gtItemSelection [
	^ ''
]
