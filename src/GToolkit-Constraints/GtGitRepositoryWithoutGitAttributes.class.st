Class {
	#name : #GtGitRepositoryWithoutGitAttributes,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes class >> instance [
	<gtExample>
	^ self new
]

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes >> description [
	^ 'All repositories in the Feenk organisation that contain smalltalk code should include a .gitattributes file that ensure unix line endings for all commits'
]

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes >> issues [
	| project directories toSkip |
	project := GtGhGToolkitProject default.
	directories := (project ownedRepositories, project forkedRepositories) 
		collect: [ :aRepository | 
			aRepository baselineRepository icebergRepository workingCopy fileSystem ].
	toSkip := self skippedRepositories.
	^ (directories select: [ :aDirectory | 
		(aDirectory / '.gitattributes') exists not and:
			[ (aDirectory / 'src') exists and:
			[ ((aDirectory / 'src') allChildrenMatching: '*.st') isNotEmpty ] ] ])
			reject: [ : each | toSkip includes: each basename ]
]

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes >> name [ 
	^ 'Git repositories from feenkcom with smalltalk code should include .gitattributes'
]

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes >> skippedRepositories [

	^ { }
]
