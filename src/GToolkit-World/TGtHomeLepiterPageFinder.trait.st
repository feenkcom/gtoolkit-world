Trait {
	#name : #TGtHomeLepiterPageFinder,
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
TGtHomeLepiterPageFinder >> pageIn: aLeDatabase [
	<return: #LePage or: nil>
	^ self explicitRequirement
]
