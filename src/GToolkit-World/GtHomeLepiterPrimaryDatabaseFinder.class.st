Class {
	#name : #GtHomeLepiterPrimaryDatabaseFinder,
	#superclass : #Object,
	#traits : 'TGtHomeLepiterKnowledgeBaseFinder',
	#classTraits : 'TGtHomeLepiterKnowledgeBaseFinder classTrait',
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeLepiterPrimaryDatabaseFinder >> database [
	<return: #LeDatabase>
	^ self registry primaryDB
]
