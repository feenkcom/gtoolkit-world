Class {
	#name : #BrKeyboardFocusChangeAptitudeExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #examples }
BrKeyboardFocusChangeAptitudeExamples >> fortyTwoButtons [
	<gtExample>
	| grid |
	grid := BrHorizontalGrid new
			columnCount: 7;
			cellSpacing: 5;
			matchParent;
			addChildren: (42
					timesCollect: [ :n | 
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude + BrKeyboardFocusChangeAptitude;
							label: 'Test' , n asString;
							action: [ :aBrButton :aBrButtonModel :aBlClickEvent | 
								aBlClickEvent consumed: true.
								aBrButton phlow spawnObject: n ] ]).
	grid children first requestFocus.
	self assert: grid children size = 42.
	self assert: grid children first hasFocus.
	^ grid
]

{ #category : #examples }
BrKeyboardFocusChangeAptitudeExamples >> fortyTwoButtonsFocusBackOnFirst [
	<gtExample>
	| aScripter |
	aScripter := self fortyTwoButtonsFocusOnLast.
	5
		timesRepeat: [ aScripter keyPress
				label: 'Press up arrow';
				key: BlKeyboardKey arrowUp;
				play.

			aScripter keyPress
				label: 'Press left arrow';
				key: BlKeyboardKey arrowLeft;
				play ].
	aScripter keyPress
		label: 'Press left arrow';
		key: BlKeyboardKey arrowLeft;
		play.
	aScripter assert
		label: 'Assert First button has focus';
		satisfies: [ :aGrid | 
			| button |
			button := aGrid children first.
			self assert: button label asString = 'Test1'.
			button hasFocus ];
		play.
	^ aScripter
]

{ #category : #examples }
BrKeyboardFocusChangeAptitudeExamples >> fortyTwoButtonsFocusOnLast [
	<gtExample>
	| aScripter grid |
	grid := self fortyTwoButtons.
	aScripter := BlScripter new.
	aScripter element: grid.
	5
		timesRepeat: [ aScripter keyPress
				label: 'Press right arrow';
				key: BlKeyboardKey arrowRight;
				play.

			aScripter keyPress
				label: 'Press down arrow';
				key: BlKeyboardKey arrowDown;
				play ].
	aScripter keyPress
		label: 'Press right arrow';
		key: BlKeyboardKey arrowRight;
		play.
	aScripter assert
		label: 'Assert Last button has focus';
		satisfies: [ :aGrid | 
			| button |
			button := aGrid children last.
			self assert: button label asString = 'Test42'.
			button hasFocus ];
		play.
	^ aScripter
]

{ #category : #examples }
BrKeyboardFocusChangeAptitudeExamples >> twoButtons [
	<gtExample>
	| grid |
	grid := BrHorizontalGrid new
			columnCount: 7;
			cellSpacing: 5;
			matchParent;
			addChildren: (2
					timesCollect: [ :n | 
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude + BrKeyboardFocusChangeAptitude;
							label: 'Test' , n asString;
							action: [ :aBrButton :aBrButtonModel :aBlClickEvent | 
								aBlClickEvent consumed: true.
								aBrButton phlow spawnObject: n ] ]).
	grid children first requestFocus.
	self assert: grid children size = 2.
	self assert: grid children first hasFocus.
	^ grid
]

{ #category : #examples }
BrKeyboardFocusChangeAptitudeExamples >> twoButtonsChangeFocus [
	<gtExample>
	| aScripter grid |
	grid := self twoButtons.
	aScripter := BlScripter new.
	aScripter element: grid.

	aScripter keyPress
		label: 'Press right arrow';
		key: BlKeyboardKey arrowRight;
		play.

	aScripter assert
		label: 'Assert Second/Right-most button has focus';
		satisfies: [ :aGrid | aGrid children second hasFocus ];
		play.

	^ aScripter
]

{ #category : #examples }
BrKeyboardFocusChangeAptitudeExamples >> twoButtonsChangeFocusAndPressEnter [
	<gtExample>
	| aScripter |
	aScripter := self twoButtonsChangeFocus.

	aScripter keyPress
		label: 'Press return';
		key: BlKeyboardKey return;
		play.

	aScripter assert
		label: 'Assert button lost focus after action was performed';
		satisfies: [ :aGrid | aGrid children second hasFocus not ];
		play.

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert button action was performed (spawning an object)';
				eventFired: GtPhlowObjectToSpawn ].


	^ aScripter
]

{ #category : #examples }
BrKeyboardFocusChangeAptitudeExamples >> twoButtonsChangeFocusPastLastButton [
	<gtExample>
	| aScripter grid |
	grid := self twoButtons.
	aScripter := BlScripter new.
	aScripter element: grid.

	12
		timesRepeat: [ aScripter keyPress
				label: 'Press right arrow';
				key: BlKeyboardKey arrowRight;
				play ].

	aScripter assert
		label: 'Assert no-op when we reach "edge" and no more buttons can get focus.';
		satisfies: [ :aGrid | aGrid children second hasFocus ];
		play.

	^ aScripter
]
