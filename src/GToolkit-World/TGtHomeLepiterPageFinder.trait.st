Trait {
	#name : #TGtHomeLepiterPageFinder,
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
TGtHomeLepiterPageFinder >> pageIn: aLeDatabase [
	<return: #LePage>
	^ self explicitRequirement
]
