Class {
	#name : #GtWorldElementStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'steps - checks' }
GtWorldElementStep >> assertTabAtIndex: anIndex hasLabel: aString [
	| step |
	
	step := self
		substeps2: ('World tab title at index {1} is {2}' format: {anIndex asString . aString})
		do: [ :aSubStep | 
			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert minimum number of tabs';
				satisfies: [ :aTabsElement | aTabsElement tabs size >= anIndex ].
			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert tab model label at index';
				value: [ :aTabsElement | 
						(aTabsElement tabs at: anIndex) tabLabel text asString ]
					equals: aString.
			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert tab widget label at index';
				value: [ :aTabsElement | 
						(aTabsElement tabs at: anIndex) widget label asString ]
					equals: aString. ].
	
	step
		referenceSender;
		onSpaceRoot;
		// GtWorldTabGroupId.
		
	^ step
]

{ #category : #'steps - checks' }
GtWorldElementStep >> assertTabHasToolAndContentIconAtIndex: anIndex [ 
	| step |
	
	step := self
		substeps2: ('World tab title at index {1} has tool and content icon' format: {anIndex asString })
		do: [ :aSubStep | 
			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert minimum number of tabs';
				satisfies: [ :aTabsElement | aTabsElement tabs size >= anIndex ].
				
			aSubStep check
				label: 'Assert tool icon exists';
				exists;
				onParentStepTarget: aSubStep;
				// #tabbar;
				// BrTab;
				@ anIndex;
				// #toolIcon.
				
			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert content icon exists';
				exists;
				// #tabbar;
				// BrTab;
				@ anIndex;
				// #contentIcon ].
	
	step
		referenceSender;
		onSpaceRoot;
		// GtWorldTabGroupId.
		
	^ step
]

{ #category : #'steps - checks' }
GtWorldElementStep >> assertTabKeepsLabelAfterFocusAtIndex: anIndex [
	| step |

	step := self
		substeps2: ('World tab title at index {1} does not change when the tool gets focus' format: { anIndex asString })
		do: [ :aSubStep | 
			aSubStep do
				onParentStepTarget: aSubStep;
				label: 'Store the tab label and notify the tool title as on focus';
				block: [ :aTabsElement | 
					| aTabModel |
					aTabModel := aTabsElement tabs at: anIndex.
					aTabModel widget userData
						at: #labelBeforeFocus
						put: aTabModel widget label asString.
					self notifyToolTitleInTabModel: aTabModel ].

			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert the tab label did not change';
				satisfies: [ :aTabsElement | 
					| aTabWidget |
					aTabWidget := (aTabsElement tabs at: anIndex) widget.
					aTabWidget label asString = (aTabWidget userData at: #labelBeforeFocus) ]
				description: [ :aTabsElement | 
					| aTabWidget |
					aTabWidget := (aTabsElement tabs at: anIndex) widget.
					'Tab label changed from {1} to {2} after focus'
						format: { (aTabWidget userData at: #labelBeforeFocus) printString. aTabWidget label asString printString } ] ].

	step
		referenceSender;
		onSpaceRoot;
		// GtWorldTabGroupId.

	^ step
]

{ #category : #'steps - checks' }
GtWorldElementStep >> assertTabKeepsLabelAndIconAfterFocusAtIndex: anIndex [
	| step |

	step := self
		substeps2: ('World tab title and icon at index {1} do not change when the tool gets focus' format: { anIndex asString })
		do: [ :aSubStep | 
			aSubStep do
				onParentStepTarget: aSubStep;
				label: 'Store the tab label and icon and notify the tool title as on focus';
				block: [ :aTabsElement | 
					| aTabModel |
					aTabModel := aTabsElement tabs at: anIndex.
					aTabModel widget userData
						at: #labelBeforeFocus put: aTabModel widget label asString;
						at: #iconBeforeFocus put: (self tabIconSignatureOf: aTabModel widget).
					self notifyToolTitleInTabModel: aTabModel ].

			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert the tab label did not change';
				satisfies: [ :aTabsElement | 
					| aTabWidget |
					aTabWidget := (aTabsElement tabs at: anIndex) widget.
					aTabWidget label asString = (aTabWidget userData at: #labelBeforeFocus) ]
				description: [ :aTabsElement | 
					| aTabWidget |
					aTabWidget := (aTabsElement tabs at: anIndex) widget.
					'Tab label changed from {1} to {2} after focus'
						format: { (aTabWidget userData at: #labelBeforeFocus) printString. aTabWidget label asString printString } ].

			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert the tab icon did not change';
				satisfies: [ :aTabsElement | 
					| aTabWidget |
					aTabWidget := (aTabsElement tabs at: anIndex) widget.
					(self tabIconSignatureOf: aTabWidget) = (aTabWidget userData at: #iconBeforeFocus) ]
				description: [ 'Tab icon changed after focus' ] ].

	step
		referenceSender;
		onSpaceRoot;
		// GtWorldTabGroupId.

	^ step
]

{ #category : #private }
GtWorldElementStep >> notifyToolTitleInTabModel: aTabModel [
	"Not every tool element can take focus, so we trigger what the title notifier does on focus"

	| aNotifier |

	aTabModel model root
		allChildrenBreadthFirstDetect: [ :eachElement | 
			aNotifier := eachElement eventDispatcher handlers
					detect: [ :eachHandler | eachHandler isKindOf: GtPhlowTitleNotifier ]
					ifNone: [ nil ].
			aNotifier isNotNil ]
		ifFound: [ :anElement | anElement ]
		ifNone: [ nil ].

	self
		assert: aNotifier isNotNil
		description: [ 'The tab content must have an element with a title notifier' ].

	aNotifier notify
]

{ #category : #'steps - interactions' }
GtWorldElementStep >> showInNewTabObject: anObject [
	^ self do
		label: 'Spawn object into a new world tab';
		block: [ :anElement |
			anElement phlow showObject: anObject ];
		onSpaceRoot;
		// GtWorldElement
]

{ #category : #private }
GtWorldElementStep >> tabIconSignatureOf: aTabWidget [
	^ Array streamContents: [ :aStream | 
		aTabWidget allChildrenBreadthFirstDo: [ :eachElement | 
			(eachElement geometry isKindOf: BlSvgPath) ifTrue: [ 
				aStream nextPut: { 
					(eachElement geometry instVarNamed: #segments) printString.
					eachElement border width.
					eachElement border paint printString.
					eachElement background printString } ] ] ]
]
