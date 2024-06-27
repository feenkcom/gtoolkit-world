Class {
	#name : #GtHomeLepiterRecentlyEditedPageFinder,
	#superclass : #Object,
	#traits : 'TGtHomeLepiterPageFinder',
	#classTraits : 'TGtHomeLepiterPageFinder classTrait',
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeLepiterRecentlyEditedPageFinder >> pageIn: aLeDatabase [
	<return: #LePage or: nil>
	^ aLeDatabase dailyNotesGroup
		ifNotEmpty: [ :aCollection | aCollection first children first ]
		ifEmpty: [ nil ]
]
