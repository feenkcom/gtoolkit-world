Class {
	#name : #GtWorldElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #accessing }
GtWorldElementExamples >> shortcutsHaveExplicitName [
	<gtExample>
	<return: #GtWorldElement>
	| worldElement |
	worldElement := GtWorldElement new.
	worldElement shortcuts do: [ :each | self assert: each name notNil ].
	^ worldElement
]

{ #category : #accessing }
GtWorldElementExamples >> takeScreenshotShortcut [
	<gtExample>
	<return: #BlShortcutWithAction>
	| worldRoot shortcut |
	worldRoot := GtWorld new root.
	shortcut := worldRoot shortcuts
			detect: [ :each | each name = 'Take screenshot' ]
			ifNone: [ self assert: false description: 'The shortcut should exist' ].
	^ shortcut
]
