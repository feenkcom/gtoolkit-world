Class {
	#name : #GtWorldUtility,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-World-Utilities'
}

{ #category : #'instance creation' }
GtWorldUtility class >> showObject: anObject from: anotherElement [
	self 
		showSpaceWithTitle:  (GtPhlowTitleLabelBuilder longLabel: [
			anObject gtInspectorTitleString ]) build
		inPagerWith: [ 
			anObject gtDefaultInspectorTool asElementDo: [ :e | e ] ] asStencil
		from: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithIcon: anIcon title: aString with: aStencil from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace icon: anIcon.
	aSpace extent: 1200@600.
	aSpace root background: Color transparent.
	aSpace addChild: aStencil asElement.
	aSpace withHalos.
	
	anotherElement 
		ifNil: [ aSpace show ] 
		ifNotNil: [
			anotherElement showSpace: aSpace.
			anotherElement fireEvent: BrDropdownHideWish new ].
	
	^ aSpace
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon inPager: aPagerConfiguration with: aStencil from: anotherElement [
	| anElement aPager |
	anElement := aStencil asElement.
	aPager := GtPager createWrappedOn: anElement.
	aPager maximized.
	aPagerConfiguration applyOn: aPager.
	^ self showSpaceWithTitle: aString with: aPager from: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon inPagerWith: aStencil from: anotherElement [
	^ self 
		showSpaceWithTitle: aString 
		icon: anIcon
		inPager: GtWorldPagerConfiguration new
		with: aStencil 
		from: anotherElement
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon with: aStencil from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	anIcon ifNotNil: [
		aSpace icon: anIcon ].
	aSpace extent: 1200@600.
	aSpace root background: Color transparent.
	aSpace addChild: aStencil asElement.
	aSpace withHalos.
	
	anotherElement 
		ifNil: [ aSpace show ] 
		ifNotNil: [ anotherElement showSpace: aSpace ].
	
	^ aSpace
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString inPager: aPagerConfiguration with: aStencil from: anotherElement [
	^ self showSpaceWithTitle: aString icon: nil inPager: aPagerConfiguration with: aStencil from: anotherElement
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString inPagerWith: aStencil from: anotherElement [
	^ self 
		showSpaceWithTitle: aString 
		inPager: GtWorldPagerConfiguration new
		with: aStencil 
		from: anotherElement
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString with: aStencil from: anotherElement [
	^ self showSpaceWithTitle: aString icon: nil with: aStencil from: anotherElement
]
