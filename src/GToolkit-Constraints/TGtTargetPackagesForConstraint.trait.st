Trait {
	#name : #TGtTargetPackagesForConstraint,
	#instVars : [
		'targetPackages'
	],
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
TGtTargetPackagesForConstraint >> defaultTargetPackages [
	^ BaselineOfGToolkit gtRlAllValidRPackages 
]

{ #category : #accessing }
TGtTargetPackagesForConstraint >> targetPackages [
	^ targetPackages ifNil: [
		targetPackages := self defaultTargetPackages ]
]

{ #category : #accessing }
TGtTargetPackagesForConstraint >> targetPackages: anObject [
	targetPackages := anObject
]
