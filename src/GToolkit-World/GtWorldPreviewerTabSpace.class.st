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
	| aPreviewElement |

	aPreviewElement := BrElementAsFormPreview
		forElement: tabSpace model root
		preferredScale: 0.3.

	^ aPreviewElement
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
