Class {
	#name : #GtHomeLepiterKnowledgeBaseSpotterStart,
	#superclass : #Object,
	#instVars : [
		'databaseProvider'
	],
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
GtHomeLepiterKnowledgeBaseSpotterStart >> database [
	<return: #LeDatabase>
	^ self databaseProvider database
]

{ #category : #accessing }
GtHomeLepiterKnowledgeBaseSpotterStart >> databaseProvider [
	^ databaseProvider
]

{ #category : #accessing }
GtHomeLepiterKnowledgeBaseSpotterStart >> databaseProvider: anObject [
	"Database provider is an object that understand #database"

	databaseProvider := anObject
]

{ #category : #searching }
GtHomeLepiterKnowledgeBaseSpotterStart >> gtSpotterForPagesByContentFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 23;
		title: 'Page contents';
		search: [ :aContext | self database asyncPagesContainingText: aContext searchQuery ];
		itemName: #spotterItemName
]

{ #category : #searching }
GtHomeLepiterKnowledgeBaseSpotterStart >> gtSpotterForPagesFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		title: 'Named pages';
		priority: 1;
		search: [ :aContext | self database asyncPagesForWord: aContext searchQuery ];
		itemName: #title;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #printing }
GtHomeLepiterKnowledgeBaseSpotterStart >> printOn: aStream [
	aStream nextPutAll: 'Spotter'
]
