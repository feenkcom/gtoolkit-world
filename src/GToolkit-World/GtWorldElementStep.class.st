Class {
	#name : #GtWorldElementStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'as yet unclassified' }
GtWorldElementStep >> assertTabAtIndex: anIdex hasLabel: aString [
	| step |
	
	step := self
		substeps2: ('World tab title at index {1} is {2}' format: {anIdex asString . aString})
		do: [ :aSubStep | 
			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert minimum number of tabs';
				satisfies: [ :aTabsElement | aTabsElement tabs size >= anIdex ].
			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert tab model label at index';
				value: [ :aTabsElement | 
						(aTabsElement tabs at: anIdex) tabLabel text asString ]
					equals: aString.
			aSubStep check
				onParentStepTarget: aSubStep;
				label: 'Assert tab widget label at index';
				value: [ :aTabsElement | 
						(aTabsElement tabs at: anIdex) widget label asString ]
					equals: aString. ].
	
	step
		referenceSender;
		onSpaceRoot;
		// GtWorldTabGroupId.
		
	^ step
]

{ #category : #'as yet unclassified' }
GtWorldElementStep >> showInNewTabObject: anObject [
	^ self do
		label: 'Spawn object into a new world tab';
		block: [ :anElement |
			anElement phlow showObject: anObject ];
		onSpaceRoot;
		// GtWorldElement
]
