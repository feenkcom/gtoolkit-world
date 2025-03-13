Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Extensions' }
CompiledMethod >> isGtSlide [
	^ self hasPragmaNamed: #gtSlide
]
