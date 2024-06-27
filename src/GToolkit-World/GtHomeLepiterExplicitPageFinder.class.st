Class {
	#name : #GtHomeLepiterExplicitPageFinder,
	#superclass : #Object,
	#traits : 'TGtHomeLepiterPageFinder',
	#classTraits : 'TGtHomeLepiterPageFinder classTrait',
	#instVars : [
		'page'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeLepiterExplicitPageFinder >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
GtHomeLepiterExplicitPageFinder >> page: aLePage [
	page := aLePage
]

{ #category : #accessing }
GtHomeLepiterExplicitPageFinder >> pageIn: aLeDatabase [
	<return: #LePage>
	^ page
]
