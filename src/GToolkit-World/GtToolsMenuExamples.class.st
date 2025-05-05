Class {
	#name : #GtToolsMenuExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #examples }
GtToolsMenuExamples >> gtWorld [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new.
	aScripter element: (GtWorldElement new knowledgeBase: LeDatabase new).
	^ aScripter
]

{ #category : #examples }
GtToolsMenuExamples >> newPageCreatedWithReturn [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spotterWithFocusOnPageDropdown.

	aScripter keyPress
		label: 'Press return key';
		key: BlKeyboardKey return;
		play.

	aScripter assert
		label: 'Assert Tools Menu is not part of scene graph anymore';
		satisfies: [ :aWorldElement | 
			aWorldElement children
				noneSatisfy: [ :anElement | anElement isKindOf: BrMenuSteppedElement ] ];
		play.
	^ aScripter
]

{ #category : #examples }
GtToolsMenuExamples >> spotterChangeFocus [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spotterWithFocus.

	aScripter keyPress
		label: 'Press right arrow';
		key: BlKeyboardKey arrowRight;
		play.

	aScripter assert
		label: 'Assert First button has focus';
		satisfies: [ :aWorldElement | 
			| dropdownContainer |
			dropdownContainer := aWorldElement deepestFocusedChild parent.
			dropdownContainer children second hasFocus ];
		play.
	^ aScripter
]

{ #category : #examples }
GtToolsMenuExamples >> spotterChangeFocusAndPressReturn [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spotterChangeFocus.

	aScripter keyPress
		label: 'Press return';
		key: BlKeyboardKey return;
		play.

	aScripter assert
		label: 'Assert Tools Menu is not part of scene graph anymore';
		notExists;
		onSpaceRoot;
		// GtToolsMenu;
		play.

	aScripter assert
		label: 'Assert Tab with focus is a knowledge base tool';
		satisfies: [ :aWorldElement | 
			| tabs |
			tabs := (aWorldElement query // #tabbar) result first.
			self assert: tabs children size = 2.
			(tabs children last query // BlAttributedTextElement) result first text
				asString = 'Knowledge bases' ];
		play.

	^ aScripter
]

{ #category : #examples }
GtToolsMenuExamples >> spotterWithFocus [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self gtWorld.

	aScripter shortcut
		label: 'Press shortcut that spawns Tool''s Menu';
		combination: BlKeyCombination builder primary t build;
		play.

	aScripter assert
		label: 'Assert Tools Menu is added to scene graph';
		exists;
		onSpaceRoot;
		// GtToolsMenu;
		play.

	aScripter assert
		label: 'Assert First button has focus';
		satisfies: [ :aWorldElement | 
			| dropdownContainer |
			dropdownContainer := aWorldElement deepestFocusedChild parent.
			self assert: dropdownContainer children first hasFocus.
			dropdownContainer isKindOf: GtToolsMenu ];
		play.
	^ aScripter
]

{ #category : #examples }
GtToolsMenuExamples >> spotterWithFocusOnPageDropdown [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spotterWithFocus.

	aScripter keyPress
		label: 'Press return key';
		key: BlKeyboardKey return;
		play.

	aScripter assert
		label: 'Assert Second dropdown has focus';
		satisfies: [ :aWorldElement | 
			aWorldElement deepestFocusedChild anchor aptitude actors
				anySatisfy: [ :anAptitude | anAptitude isKindOf: BrWithExplicitPopoverAptitude ] ];
		play.
	^ aScripter
]

{ #category : #examples }
GtToolsMenuExamples >> spotterWithFocusOnPageDropdown_escape [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spotterWithFocusOnPageDropdown.

	aScripter keyPress
		label: 'Press return key';
		key: BlKeyboardKey escape;
		play.

	aScripter assert
		label: 'Assert Second dropdown has focus';
		satisfies: [ :aWorldElement | 
			aWorldElement deepestFocusedChild anchor aptitude actors
				anySatisfy: [ :anAptitude | anAptitude isKindOf: BrWithExplicitPopoverAptitude ] ];
		play.
	^ aScripter
]
