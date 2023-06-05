Class {
	#name : #BaselineOfGtoolkitWorld,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtoolkitWorld
}

{ #category : #baseline }
BaselineOfGtoolkitWorld >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtIdentity'
		]
]
