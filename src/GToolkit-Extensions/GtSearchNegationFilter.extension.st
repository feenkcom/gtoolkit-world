Extension { #name : #GtSearchNegationFilter }

{ #category : #'*GToolkit-Extensions' }
GtSearchNegationFilter >> children [
	^ Array with: self originalFilter
]

{ #category : #'*GToolkit-Extensions' }
GtSearchNegationFilter >> gtAreAllGtSearchMethodsFilterKind [
	^ self originalFilter gtAreAllGtSearchMethodsFilterKind
]
