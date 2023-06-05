Class {
	#name : #GtIdentityRegistry,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'credentials',
		'keyFolder',
		'preferencesFolder'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #GtIdentity
}

{ #category : #accessing }
GtIdentityRegistry class >> registry [
	^ self uniqueInstance
]

{ #category : #accessing }
GtIdentityRegistry >> addCredential: aCredential [
	self credentials add: aCredential
]

{ #category : #accessing }
GtIdentityRegistry >> addCredential: aCredential named: aKey [
	self credentials at: (aKey -> aCredential class identityName) put: aCredential
]

{ #category : #accessing }
GtIdentityRegistry >> credentials [
	^ credentials
]

{ #category : #accessing }
GtIdentityRegistry >> credentials: anObject [
	credentials := anObject
]

{ #category : #accessing }
GtIdentityRegistry >> defaultKeysFolderLocator [
	^ FileLocator home / '.lepiter'
]

{ #category : #default }
GtIdentityRegistry >> defaultPreferencesFolder [
	^ FileLocator preferences / 'pharo'
]

{ #category : #accessing }
GtIdentityRegistry >> gtViewCredentialsFor: aView [
	<gtView>
	^ aView list
		title: 'Credentials';
		priority: 1;
		items: [ self credentials ]
]

{ #category : #accessing }
GtIdentityRegistry >> gtViewIdentitiesFor: aView [
	<gtView>
	^ aView list
		title: 'Identities';
		priority: 2;
		items: [ self identities ];
		itemText: #identityName
]

{ #category : #accessing }
GtIdentityRegistry >> identities [
	^ GtIdentity allSubclasses
]

{ #category : #accessing }
GtIdentityRegistry >> identitiesFile [
	^ self preferencesFolder / 'com.glamoroustoolkit.identities.v1.ston'
]

{ #category : #accessing }
GtIdentityRegistry >> initialize [
	super initialize.
	
	self credentials: OrderedCollection new.
	self preferencesFolder: self defaultPreferencesFolder.
	self keyFolder: self keyFolder.
	
	self loadCredentials
]

{ #category : #accessing }
GtIdentityRegistry >> keyFolder [
	^ keyFolder
]

{ #category : #accessing }
GtIdentityRegistry >> keyFolder: anObject [
	keyFolder := anObject
]

{ #category : #accessing }
GtIdentityRegistry >> loadCredentials [
	| rawData |
	self identitiesFile exists ifFalse: [ ^ self ].

	rawData := self identitiesFile
			readStreamDo: [ :aReadStream | STONJSON fromStream: aReadStream ].
	rawData isArray ifFalse: [ ^ self ].

	rawData
		do: [ :anObject | 
			| anIdentity |
			anIdentity := GtIdentity forIdentityName: (anObject at: #identityName).
			self credentials
				add: (anIdentity fromCredentials: (anObject at: #credential)) ]
]

{ #category : #accessing }
GtIdentityRegistry >> preferencesFolder [
	^ preferencesFolder
]

{ #category : #accessing }
GtIdentityRegistry >> preferencesFolder: anObject [
	preferencesFolder := anObject
]

{ #category : #accessing }
GtIdentityRegistry >> removeCredential: aCredential [
	self credentials remove: aCredential ifAbsent: []
]

{ #category : #accessing }
GtIdentityRegistry >> saveCredentials [
	| data |
	data := OrderedCollection new.
	self credentials
		do: [ :aCredential | 
			data
				add: {#identityName -> aCredential class identityName.
						#credential -> aCredential saveDictionary} asDictionary ].

	self identitiesFile
		ensureDelete;
		writeStreamDo: [ :aPreferenceStream | 
			STONJSON
				put: data asArray
				onStreamPretty: (ZnCharacterWriteStream on: aPreferenceStream encoding: 'utf8') ]
]
