Class {
	#name : #GtPackageCodeDependencyNoLongerDepends,
	#superclass : #GtPackageCodeDependencyStatus,
	#instVars : [
		'package',
		'dependencyPackage',
		'dependencies'
	],
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> dependencies [
	^ dependencies
]

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> dependencies: anObject [
	dependencies := anObject
]

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> dependencyPackage [
	^ dependencyPackage
]

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> dependencyPackage: anObject [
	dependencyPackage := anObject
]

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> package [
	^ package
]

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> package: anObject [
	package := anObject
]

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> statusColor [
	^ Color red darker
]

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> statusLabel [
	^ 'No longer depends'
]
