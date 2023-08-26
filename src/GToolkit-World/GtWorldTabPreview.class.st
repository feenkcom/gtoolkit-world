Class {
	#name : #GtWorldTabPreview,
	#superclass : #Object,
	#instVars : [
		'tabSpace'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldTabPreview >> asElement [
	| pagers |
	pagers := tabSpace model root query // GtPager.
	^ pagers isNotEmpty
		ifTrue: [ | pagePreviews pager |
			pager := pagers anyOne.
			pagePreviews := pager pages
					collectWithIndex: [ :each :index | 
						GtWorldPagerPagePreview new
							page: each;
							tabSpace: tabSpace;
							pager: pager;
							pageIndex: index ].
			BrSimpleList horizontal
				hMatchParent;
				vFitContent;
				itemStencil: [ BrVerticalPane new
						padding: (BlInsets all: 10);
						hFitContent;
						vFitContentLimited ];
				itemDataBinder: [ :anElement :aPreview :anIndex | 
					anElement
						removeChildren;
						addChild: ((aPreview pagePreviewScaled: 0.3) asElement
								when: BlClickEvent
								do: [ :e | 
									e target phlow spawnObject: aPreview.
									aPreview select ]) ];
				items: pagePreviews ]
		ifFalse: [  ]
]

{ #category : #accessing }
GtWorldTabPreview >> tabLabel [
	^ tabSpace tabLabel text asString
]

{ #category : #accessing }
GtWorldTabPreview >> tabSpace: eachTabSpace [ 
	tabSpace := eachTabSpace
]
