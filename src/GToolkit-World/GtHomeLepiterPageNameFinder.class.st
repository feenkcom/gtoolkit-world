Class {
	#name : #GtHomeLepiterPageNameFinder,
	#superclass : #Object,
	#traits : 'TGtHomeLepiterPageFinder',
	#classTraits : 'TGtHomeLepiterPageFinder classTrait',
	#instVars : [
		'pageName'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeLepiterPageNameFinder >> pageIn: aLeDatabase [
	<return: #LePage>
	^ aLeDatabase pageNamed: self pageName
]

{ #category : #accessing }
GtHomeLepiterPageNameFinder >> pageName [
	^ pageName
]

{ #category : #accessing }
GtHomeLepiterPageNameFinder >> pageName: anObject [
	pageName := anObject
]
