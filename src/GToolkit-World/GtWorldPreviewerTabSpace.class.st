Class {
	#name : #GtWorldPreviewerTabSpace,
	#superclass : #Object,
	#instVars : [
		'tabSpace'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerTabSpace >> asElement [
	^ (BlExporter form
		element: tabSpace model root;
		scaled: 0.3;
		export) asElement
		aptitude: (BrStyleCommonAptitude new
				default: [ :f | f border: Color transparent ];
				hovered: [ :f | f border: BrGlamorousColors primaryBorderColor ]);
		when: BlClickEvent
			do: [ :e | 
				e consumed: true.
				e target
					fireEvent: (GtWorldPreviewerSelectSpaceTabWish new spaceTabPreview: self) ]
]

{ #category : #accessing }
GtWorldPreviewerTabSpace >> select [
	tabSpace select
]

{ #category : #accessing }
GtWorldPreviewerTabSpace >> tabSpace: aTabSpace [ 
	tabSpace := aTabSpace
]
