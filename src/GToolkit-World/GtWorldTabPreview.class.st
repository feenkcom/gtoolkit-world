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
								aptitude: (BrStyleCommonAptitude new
										default: [ :f | f border: Color transparent ];
										hovered: [ :f | f border: BrGlamorousColors primaryBorderColor ]);
								when: BlClickEvent do: [ :e | aPreview select ]) ];
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
