Class {
	#name : #GtGitRepositoryWithoutJenkinsFile,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile class >> instance [
	<gtExample>
	^ self new
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> allowedRepositoryNamesWithoutJenkinsFiles [
	^ { }
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> description [
	^ 'A repository in the Feenk organisation should specify the Jenkins file to trigger a build for Glamorous Toolkit'
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> issues [
	| project directories allowedFailures |
	project := GtGhGToolkitProject default.
	directories := (project ownedRepositories, project forkedRepositories) 
		collect: [ :aRepository | 
			aRepository baselineRepository icebergRepository workingCopy fileSystem ].
	allowedFailures := self allowedRepositoryNamesWithoutJenkinsFiles.
	^ (directories 
		select: [ :aDirectory | (aDirectory / 'Jenkinsfile') exists not ])
		reject: [ :aDirectory | allowedFailures includes: aDirectory basename ]
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> name [ 
	^ 'Git repositories from feenkcom should specify a Jenkinsfile'
]
