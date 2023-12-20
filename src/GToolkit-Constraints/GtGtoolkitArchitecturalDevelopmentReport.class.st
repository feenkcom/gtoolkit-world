"
A specific Architectural report for Glamorous Toolkit that should be used in an image manually built from sources. 

This add to {{gtClass:GtGtoolkitArchitecturalReport}} constraints that need the list of repositories to be present.

"
Class {
	#name : #GtGtoolkitArchitecturalDevelopmentReport,
	#superclass : #GtGtoolkitArchitecturalReport,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGtoolkitArchitecturalDevelopmentReport class >> yourself [
	<gtExample>
	^ self new
]

{ #category : #accessing }
GtGtoolkitArchitecturalDevelopmentReport >> build: aComposite [
	super build: aComposite.
	
	aComposite 
		addConstraint: GtGitRepositoryWithoutJenkinsFile new;
		addConstraint: GtGitRepositoryWithoutGitAttributes new;
		addConstraint: GtGitAttributesShouldHandleLineEndings new
]
