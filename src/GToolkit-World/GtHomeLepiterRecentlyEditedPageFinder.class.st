Class {
	#name : #GtHomeLepiterRecentlyEditedPageFinder,
	#superclass : #Object,
	#traits : 'TGtHomeLepiterPageFinder',
	#classTraits : 'TGtHomeLepiterPageFinder classTrait',
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeLepiterRecentlyEditedPageFinder >> pageIn: aLeDatabase [
	<return: #LePage>
	^ aLeDatabase dailyNotesGroup first children first
]
