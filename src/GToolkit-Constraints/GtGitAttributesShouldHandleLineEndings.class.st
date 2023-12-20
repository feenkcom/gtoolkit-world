Class {
	#name : #GtGitAttributesShouldHandleLineEndings,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGitAttributesShouldHandleLineEndings class >> instance [
	<gtExample>
	^ self new
]

{ #category : #accessing }
GtGitAttributesShouldHandleLineEndings >> description [
	^ 'The .gitattributes file should ensure unix line endings for all commits'
]

{ #category : #accessing }
GtGitAttributesShouldHandleLineEndings >> handlesLinesEndings: aGitAttributesFile [
	 ^ ({'*.st eol=lf' . '*.sh eol=lf'}  intersection: (aGitAttributesFile contents lines collect: [ :aLine | 
	 	aLine trimBoth])) size = 2
]

{ #category : #accessing }
GtGitAttributesShouldHandleLineEndings >> issues [
	| project directories toSkip |
	project := GtGhGToolkitProject default.
	directories := (project ownedRepositories, project forkedRepositories) 
		collect: [ :aRepository | 
			aRepository baselineRepository icebergRepository workingCopy fileSystem ].
	toSkip := self skippedRepositories.
	^ (directories 
		select: [ :aDirectory | 
			(aDirectory / '.gitattributes') exists and: [
				(self handlesLinesEndings: aDirectory / '.gitattributes') not ] ])
		reject: [ : each | toSkip includes: each basename ]
]

{ #category : #accessing }
GtGitAttributesShouldHandleLineEndings >> name [ 
	^ 'The .gitattributes file should ensure unix line endings for all commits'
]

{ #category : #accessing }
GtGitAttributesShouldHandleLineEndings >> skippedRepositories [
	^ { }
]
