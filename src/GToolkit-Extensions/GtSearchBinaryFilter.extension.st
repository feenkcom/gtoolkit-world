Extension { #name : #GtSearchBinaryFilter }

{ #category : #'*GToolkit-Extensions' }
GtSearchBinaryFilter >> children [
	^ { self leftFilter. self rightFilter }
]

{ #category : #'*GToolkit-Extensions' }
GtSearchBinaryFilter >> gtAreAllGtSearchMethodsFilterKind [
	^ self leftFilter gtAreAllGtSearchMethodsFilterKind
		and: [ self rightFilter gtAreAllGtSearchMethodsFilterKind ]
]
