Trait {
	#name : #TGtHomeLepiterKnowledgeBaseFinder,
	#category : #'GToolkit-World-Helpers'
}

{ #category : #accessing }
TGtHomeLepiterKnowledgeBaseFinder >> database [
	<return: #LeDatabase>
	^ self explicitRequirement
]

{ #category : #accessing }
TGtHomeLepiterKnowledgeBaseFinder >> registry [
	<return: #LeLogicalDatabase>
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
]
