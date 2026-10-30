"
Examples of discovering local GemStone development versions using an in-memory filesystem.
"
Class {
	#name : #GtImageSetupExamples,
	#superclass : #Object,
	#category : #'GToolkit-Setup-Examples'
}

{ #category : #examples }
GtImageSetupExamples >> highestGemStoneDevVersion [
	<gtExample>
	| directory version |
	directory := FileSystem memory root / 'remote-gemstone'.
	directory ensureCreateDirectory.
	#('2.99.99' '3.7.6' '3.7.10' '3.10.0' '4.0.0' '4.10.2' '4.9.99' '5.0.0' 'v4.99.0' '4.99.0-extra' 'not-a-version' '4.99' 'prefix4.99.0')
		do: [ :name | (directory / name) ensureCreateDirectory ].
	(directory / '4.99.0') ensureCreateFile.
	(directory / 'not-a-version' / '4.100.0') ensureCreateDirectory.
	version := GtImageSetup currentGemStoneDevVersionIn: directory.
	self assert: version equals: (GtGemStoneSemanticVersionNumber major: 4 minor: 10 patch: 2).
	^ version
]

{ #category : #examples }
GtImageSetupExamples >> highestMajorThreeGemStoneDevVersion [
	<gtExample>
	| directory version |
	directory := FileSystem memory root / 'remote-gemstone'.
	directory ensureCreateDirectory.
	#('3.7.6' '3.7.10' '3.10.0' '2.99.99' '5.0.0')
		do: [ :name | (directory / name) ensureCreateDirectory ].
	version := GtImageSetup currentGemStoneDevVersionIn: directory.
	self assert: version equals: (GtGemStoneSemanticVersionNumber major: 3 minor: 10 patch: 0).
	^ version
]

{ #category : #examples }
GtImageSetupExamples >> noGemStoneDevVersion [
	<gtExample>
	| directory |
	directory := FileSystem memory root / 'remote-gemstone'.
	self assert: (GtImageSetup currentGemStoneDevVersionIn: directory) isNil.
	directory ensureCreateDirectory.
	self assert: (GtImageSetup currentGemStoneDevVersionIn: directory) isNil.
	#('2.99.99' '5.0.0' 'invalid')
		do: [ :name | (directory / name) ensureCreateDirectory ].
	self assert: (GtImageSetup currentGemStoneDevVersionIn: directory) isNil.
	^ directory
]
