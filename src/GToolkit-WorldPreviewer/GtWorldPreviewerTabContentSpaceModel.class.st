Class {
	#name : #GtWorldPreviewerTabContentSpaceModel,
	#superclass : #GtWorldPreviewerTabContentModel,
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #'api - converting' }
GtWorldPreviewerTabContentSpaceModel >> asElement [
	| aPreviewElement |

	aPreviewElement := BrElementAsFormPreview
		forElement: tabModelWithSpace model root
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
GtWorldPreviewerTabContentSpaceModel >> pageIndex [
	^ 0
]

{ #category : #accessing }
GtWorldPreviewerTabContentSpaceModel >> select [
	tabModelWithSpace select
]
