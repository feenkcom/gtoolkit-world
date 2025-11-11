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

{ #category : #'api - exporting' }
GtWorldPreviewerTabContentSpaceModel >> computeScreenshot [
	<return: #FileReference>
	^ (BlScripter new
		maxPulseElapsedTime: 30 seconds;
		element: self tabModelWithSpace model root) element exportAsPNG
]

{ #category : #accessing }
GtWorldPreviewerTabContentSpaceModel >> pageIndex [
	^ 0
]

{ #category : #accessing }
GtWorldPreviewerTabContentSpaceModel >> select [
	tabModelWithSpace select
]
