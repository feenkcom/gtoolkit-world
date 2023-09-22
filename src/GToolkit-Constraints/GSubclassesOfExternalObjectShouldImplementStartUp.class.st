Class {
	#name : #GSubclassesOfExternalObjectShouldImplementStartUp,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GSubclassesOfExternalObjectShouldImplementStartUp >> computeIssues [
	^ (ExternalObject allSubclasses
		select: [ :each | SessionManager default hasRegistered: each name ])
			select: [ :each | (each class includesSelector: #startUp:) not ]
]

{ #category : #accessing }
GSubclassesOfExternalObjectShouldImplementStartUp >> description [
	^ 'If #startUp: is not implemented and a class is registered in a SessionManager, then ExteralObject>>#startUp: will be called multiple times nulling all external addresses.'
]

{ #category : #accessing }
GSubclassesOfExternalObjectShouldImplementStartUp >> excludedClasses [
	^ {FT2Handle}
]

{ #category : #accessing }
GSubclassesOfExternalObjectShouldImplementStartUp >> issues [	
	^ self computeIssues 
		copyWithoutAll: self excludedClasses
]

{ #category : #accessing }
GSubclassesOfExternalObjectShouldImplementStartUp >> name [
	^ 'Subclasses of ExternalObject must implement #startUp:'
]
