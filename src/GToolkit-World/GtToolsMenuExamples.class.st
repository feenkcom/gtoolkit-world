Class {
	#name : #GtToolsMenuExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #examples }
GtToolsMenuExamples >> gtWorld [
	<gtExample>
	| aScripter |
	aScripter := BlScripter new.
	aScripter element: GtWorldElement new.
	^ aScripter
]

{ #category : #examples }
GtToolsMenuExamples >> newPageCreatedWithReturn [
	<gtExample>
	| aScripter |
	aScripter := self spotterWithFocusOnPageDropdown.

	aScripter keyPress
		label: 'Press return key';
		key: BlKeyboardKey return;
		play.

	self flag: #TODO.	"Scripter behaving differently than in reality. Page not created/spawned yet page creation dropdown dissapears"
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
	| aScripter |
	aScripter := self spotterChangeFocus.

	aScripter keyPress
		label: 'Press return';
		key: BlKeyboardKey return;
		play.

	aScripter assert
		label: 'Assert Tools Menu is not part of scene graph anymore';
		satisfies: [ :aWorldElement | 
			aWorldElement children
				noneSatisfy: [ :anElement | anElement isKindOf: BrMenuSteppedElement ] ];
		play.

	self flag: #TODO.	"Test is flaky because Tool is being spawned in a different window sometimes"
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
	| aScripter |
	aScripter := self gtWorld.

	aScripter shortcut
		label: 'Press shortcut that spawns Tool''s Menu';
		combination: BlKeyCombination builder control t build;
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
				anySatisfy: [ :anAptitude | anAptitude isKindOf: BrWithExplicitMenuAptitude ] ];
		play.
	^ aScripter
]
