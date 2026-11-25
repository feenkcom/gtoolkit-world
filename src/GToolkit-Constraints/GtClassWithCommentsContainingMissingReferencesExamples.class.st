Class {
	#name : #GtClassWithCommentsContainingMissingReferencesExamples,
	#superclass : #Object,
	#category : #'GToolkit-Constraints-Examples'
}

{ #category : #examples }
GtClassWithCommentsContainingMissingReferencesExamples >> packagesToAnalyseLeaveOutMagritteModel [
	"The constraint does not analyse Magritte-Model (package names are Symbols)"

	<gtExample>
	<return: #OrderedCollection>
	| packages |
	packages := GtClassWithCommentsContainingMissingReferences new packagesToAnalyse.
	self assert: packages notEmpty.
	self assert: (packages noneSatisfy: [ :each | each name sameContentAs: 'Magritte-Model' ]).
	^ packages
]
