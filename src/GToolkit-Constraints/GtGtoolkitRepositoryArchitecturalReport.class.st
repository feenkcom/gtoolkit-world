Class {
	#name : #GtGtoolkitRepositoryArchitecturalReport,
	#superclass : #GtConstrainerReport,
	#traits : 'TGtTargetPackagesForConstraint',
	#classTraits : 'TGtTargetPackagesForConstraint classTrait',
	#instVars : [
		'repository'
	],
	#category : #'GToolkit-Constraints'
}

{ #category : #'instance creation' }
GtGtoolkitRepositoryArchitecturalReport class >> forRepository: aRepository [
	^ self basicNew 
		initializeWithRepository: aRepository;
		initialize
]

{ #category : #building }
GtGtoolkitRepositoryArchitecturalReport >> build: aComposite [
	aComposite name: self reportName.
	aComposite
		addConstraint: (GtSendersOfHaltSelectorsInGtPackagesConstraint new
			targetPackages: self targetPackages)
]

{ #category : #initialization }
GtGtoolkitRepositoryArchitecturalReport >> initializeWithRepository: aRepository [
	repository := aRepository.
	self updateTargetPackages
]

{ #category : #accessing }
GtGtoolkitRepositoryArchitecturalReport >> reportName [
	^ 'GToolkit Repositort Architectural Report for ', self repositoryName
]

{ #category : #accessing }
GtGtoolkitRepositoryArchitecturalReport >> repository [
	^ repository
]

{ #category : #accessing }
GtGtoolkitRepositoryArchitecturalReport >> repositoryName [
	^ repository name
]

{ #category : #initialization }
GtGtoolkitRepositoryArchitecturalReport >> updateTargetPackages [
	self targetPackages: (repository hasWorkingCopy
		ifTrue: [ (repository icebergWorkingCopy packages
			select: [ :anIcePackage | anIcePackage isLoaded ])
			collect: [ :anIcePackage | anIcePackage packageName asPackage] ]
		ifFalse: [ #() ])
]
