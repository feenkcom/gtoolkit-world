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

{ #category : #'steps - interactions' }
GtWorldElementStep >> showInNewTabObject: anObject [
	^ self do
		label: 'Spawn object into a new world tab';
		block: [ :anElement |
			anElement phlow showObject: anObject ];
		onSpaceRoot;
		// GtWorldElement
]
