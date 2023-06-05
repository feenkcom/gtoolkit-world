Class {
	#name : #GtIdentity,
	#superclass : #Object,
	#category : #GtIdentity
}

{ #category : #accessing }
GtIdentity class >> forIdentityName: anIdentityName [
	^ self allSubclasses
		detect: [ :anIdentity | anIdentity identityName = anIdentityName ]
		ifNone: [ self error: 'Unknown identity ' , anIdentityName ]
]

{ #category : #'instance creation' }
GtIdentity class >> fromCredentials: rawData [
	| anInstance |
	anInstance := self new.

	self jsonProperties
		keysAndValuesDo: [ :aKey :aValue | 
			(rawData includesKey: aKey)
				ifTrue: [ anInstance perform: aValue , ':' withArguments: {rawData at: aKey} ] ].

	^ anInstance
]

{ #category : #'instance creation' }
GtIdentity class >> identityName [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtIdentity class >> jsonProperties [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtIdentity >> saveDictionary [
	| aSaveDictionary |
	aSaveDictionary := Dictionary new.

	self class jsonProperties
		keysAndValuesDo: [ :aKey :aValue | aSaveDictionary at: aKey put: (self perform: aValue) ].

	^ aSaveDictionary
]
