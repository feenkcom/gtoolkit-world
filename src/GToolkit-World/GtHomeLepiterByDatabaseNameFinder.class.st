Class {
	#name : #GtHomeLepiterByDatabaseNameFinder,
	#superclass : #Object,
	#traits : 'TGtHomeLepiterKnowledgeBaseFinder',
	#classTraits : 'TGtHomeLepiterKnowledgeBaseFinder classTrait',
	#instVars : [
		'databaseName'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeLepiterByDatabaseNameFinder >> database [
	<return: #LeDatabase>
	^ self registry databaseNamed: self databaseName
]

{ #category : #accessing }
GtHomeLepiterByDatabaseNameFinder >> databaseName [
	^ databaseName
]

{ #category : #accessing }
GtHomeLepiterByDatabaseNameFinder >> databaseName: aLeDatabaseName [
	databaseName := aLeDatabaseName
]
