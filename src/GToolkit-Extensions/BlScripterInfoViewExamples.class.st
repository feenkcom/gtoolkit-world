"
I exemplify the `Info` phlow view of ${class:BlScripter}$ and its ${method:BlScripter>>#gtSpaceElementsCount}$ helper.

The view reports the state that makes asynchronous editor examples hard to reason about: whether the space still has a pulse requested, whether its task queue holds definite term tasks, and how many elements the space currently holds.
"
Class {
	#name : #BlScripterInfoViewExamples,
	#superclass : #Object,
	#instVars : [
		'scripterExamples'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #examples }
BlScripterInfoViewExamples >> elementsCountRow [
	<gtExample>
	<return: #GtPhlowDetailsRow>
	| aScripter aRow aValue |
	aScripter := self scripterWithElement.
	aRow := (aScripter gtInfoFor: GtPhlowView empty) phlowDetailRows third.
	self assert: aRow name equals: 'Elements count'.
	aValue := aRow valueComputation value.
	self assert: aValue == aScripter space.
	self
		assert: (aRow textComputation value: aValue)
		equals: aScripter gtSpaceElementsCount printString.
	^ aRow
]

{ #category : #examples }
BlScripterInfoViewExamples >> emptyInfoViewWithoutSpace [
	<gtExample>
	<return: #GtPhlowEmptyView>
	| aScripter aView |
	"A scripter always initializes its space, so the space has to be removed explicitly
	to exercise the defensive branch of the view. A scripter is built here rather than
	reused from another example, so that no shared instance is left without its space."
	aScripter := BlScripter new.
	aScripter instVarNamed: #space put: nil.
	aView := aScripter gtInfoFor: GtPhlowView empty.
	self assert: aView class equals: GtPhlowEmptyView.
	^ aView
]

{ #category : #examples }
BlScripterInfoViewExamples >> hasDefiniteTermTasksRow [
	<gtExample>
	<return: #GtPhlowDetailsRow>
	| aScripter aRow aValue |
	aScripter := self scripterWithElement.
	aRow := (aScripter gtInfoFor: GtPhlowView empty) phlowDetailRows second.
	self assert: aRow name equals: 'Has definite term tasks'.
	aValue := aRow valueComputation value.
	self assert: aValue == aScripter space taskQueue.
	self assert: (aRow textComputation value: aValue) equals: 'false'.
	^ aRow
]

{ #category : #examples }
BlScripterInfoViewExamples >> infoView [
	<gtExample>
	<return: #GtPhlowDetailsView>
	| aView |
	aView := self scripterWithElement gtInfoFor: GtPhlowView empty.
	self assert: aView class equals: GtPhlowDetailsView.
	self assert: aView title equals: 'Info'.
	self
		assert: (aView phlowDetailRows collect: [ :eachRow | eachRow name ]) asArray
		equals: #('Pulse requested' 'Has definite term tasks' 'Elements count' 'Space task events' 'Leaves steps').
	^ aView
]

{ #category : #initialization }
BlScripterInfoViewExamples >> initialize [
	super initialize.
	scripterExamples := BlScripterExamples new
]

{ #category : #examples }
BlScripterInfoViewExamples >> leavesStepsCount [
	<gtExample>
	<return: #Number>
	| aScripter aCount |
	aScripter := self scripterWithTwoClicks.
	aCount := aScripter gtLeavesStepsCount.
	"One leave step per played click."
	self assert: aCount equals: 2.
	^ aCount
]

{ #category : #examples }
BlScripterInfoViewExamples >> leavesStepsRow [
	<gtExample>
	<return: #GtPhlowDetailsRow>
	| aScripter aRow aValue |
	aScripter := self scripterWithTwoClicks.
	aRow := (aScripter gtInfoFor: GtPhlowView empty) phlowDetailRows fifth.
	self assert: aRow name equals: 'Leaves steps'.
	aValue := aRow valueComputation value.
	self assert: aValue isRootStep.
	self assert: (aRow textComputation value: aValue) equals: '2'.
	^ aRow
]

{ #category : #examples }
BlScripterInfoViewExamples >> pulseRequestedRow [
	<gtExample>
	<return: #GtPhlowDetailsRow>
	| aScripter aRow aValue |
	aScripter := self scripterWithElement.
	aRow := (aScripter gtInfoFor: GtPhlowView empty) phlowDetailRows first.
	self assert: aRow name equals: 'Pulse requested'.
	aValue := aRow valueComputation value.
	self assert: aValue == aScripter space.
	self assert: (aRow textComputation value: aValue) equals: 'false'.
	^ aRow
]

{ #category : #examples }
BlScripterInfoViewExamples >> scripterWithElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := scripterExamples scripterWithElement.
	self assert: aScripter space isNotNil.
	^ aScripter
]

{ #category : #examples }
BlScripterInfoViewExamples >> scripterWithTwoClicks [
	"A scripter that played two click steps on an element that repaints itself on every click,
	so that the step tree holds more than one leave step."
	<gtExample>
	<return: #BlScripter>
	| anElement aScripter |
	anElement := BlElement new
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ];
		background: Color blue;
		when: BlClickEvent do: [ :anEvent | anEvent currentTarget background: Color random ];
		yourself.
	aScripter := BlScripter new element: anElement.
	aScripter click play.
	aScripter click play.
	self assert: aScripter space isNotNil.
	^ aScripter
]

{ #category : #examples }
BlScripterInfoViewExamples >> spaceElementsCount [
	<gtExample>
	<return: #Number>
	| aScripter aCount |
	aScripter := self scripterWithElement.
	aCount := aScripter gtSpaceElementsCount.
	"The space root, the container, and the rectangle the container holds."
	self assert: aCount equals: 3.
	^ aCount
]

{ #category : #examples }
BlScripterInfoViewExamples >> spaceTaskEventsRow [
	<gtExample>
	<return: #GtPhlowDetailsRow>
	| aScripter aRow aValue |
	aScripter := self scripterWithTwoClicks.
	aRow := (aScripter gtInfoFor: GtPhlowView empty) phlowDetailRows fourth.
	self assert: aRow name equals: 'Space task events'.
	aValue := aRow valueComputation value.
	self assert: aValue asArray equals: aScripter spaceTaskEvents asArray.
	self assert: (aRow textComputation value: aValue) equals: aScripter spaceTaskEvents size printString.
	^ aRow
]
