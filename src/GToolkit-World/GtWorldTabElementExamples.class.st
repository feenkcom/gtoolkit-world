"
I exemplify {{gtClass:GtWorldTabElement}}.

"
Class {
	#name : #GtWorldTabElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new.
	aScripter element: GtWorldTabElement new.

	^ aScripter
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_01_addSpace [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self showSpaceSelectScripter.
	aScripter
		doStep: [ :s | 
			s
				label: 'Show space selected by default';
				action: [ :anActionScripter | 
					anActionScripter element
						showSpace: (BlSpace new
								title: 'Tab 1';
								in: [ :aSpace | anActionScripter model: aSpace id ];
								rootDo: [ :aRoot | aRoot background: Color white ])
						select: true ];
				onScripter ].

	^ aScripter
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_02_moveMouseOverSpaceCloseButton [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self showSpaceSelectScripter_01_addSpace.

	aScripter mouseMove
		by: 10 @ 10;
		play.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Move mouse over the close button';
				id: (GtWorldTabElement tabNameForSpaceId: aScripter model);
				id: GtWorldTabElement spaceCloseButtonName ].

	^ aScripter
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_03_clickSpaceCloseButton [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self showSpaceSelectScripter_02_moveMouseOverSpaceCloseButton.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Mouse click the close button';
				id: (GtWorldTabElement tabNameForSpaceId: aScripter model);
				id: GtWorldTabElement spaceCloseButtonName ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that there is no more space tab';
				value: [ :theTabGroup | theTabGroup tabs size ] equals: 1;
				onChildFromMessage: #tabs ].

	^ aScripter
]

{ #category : #'examples - by scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_04_checkSpaceGarbageCollected [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self showSpaceSelectScripter_03_clickSpaceCloseButton.
	aScripter
		doStep: [ :s | 
			s
				label: 'Clear scripter events and garbage collect';
				action: [ :_ | 
					aScripter events removeAll.
					Smalltalk garbageCollect.
					Smalltalk garbageCollect ] ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that there is no space with the stored id';
				value: [ :aStepScripter | BlSpace spaceWithId: aStepScripter model do: #yourself ]
					equals: nil;
				onScripter ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtWorldTabElementExamples >> showSpaceSelectScripter_05_middleMouseButtonClickClosesTab [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self showSpaceSelectScripter_01_addSpace.

	aScripter
		mouseMoveOverStep: [ :s | 
			s
				label: 'Move mouse over the tab';
				id: (GtWorldTabElement tabNameForSpaceId: aScripter model) ].

	aScripter fire
		referenceSender;
		label: 'Simulate a middle mouse button click at the tab';
		event: (BlMouseDownEvent middle
				position: ((aScripter userData includesKey: #mousePosition)
						ifTrue: [ aScripter userData at: #mousePosition ]
						ifFalse: [ 0.0 @ 0.0 ]));
		id: (GtWorldTabElement tabNameForSpaceId: aScripter model);
		play.

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that there is no more space tab';
				value: [ :theTabGroup | theTabGroup tabs size ] equals: 1;
				onChildFromMessage: #tabs ].

	^ aScripter
]

{ #category : #'examples - show space' }
GtWorldTabElementExamples >> showSpaceSelect_ReleaseSpaceOnSelectedTabCloseAction [
	<gtExample>
	<return: #GtWorldTabElement>
	| aSpace aWorld aTabs |
	aSpace := BlSpace new.
	aWorld := GtWorldTabElement new.
	aWorld showSpace: aSpace select: true.
	aTabs := aWorld tabs.
	aTabs viewModel removeTab: (aTabs viewModel tabs at: 2).
	aSpace := aSpace asWeakReference.
	Smalltalk garbageCollect.
	self assert: (aSpace at: 1) equals: nil.
	^ aWorld
]

{ #category : #'examples - show space' }
GtWorldTabElementExamples >> showSpaceSelect_ReleaseSpaceOnUnselectedTabCloseAction [
	<gtExample>
	<return: #GtWorldTabElement>
	| aSpace aWorld aTabs |
	aSpace := BlSpace new.
	aWorld := GtWorldTabElement new.
	aWorld showSpace: aSpace select: false.
	aTabs := aWorld tabs.
	aTabs viewModel removeTab: (aTabs viewModel tabs at: 2).
	aSpace := aSpace asWeakReference.
	Smalltalk garbageCollect.
	self assert: (aSpace at: 1) equals: nil.
	^ aWorld
]
