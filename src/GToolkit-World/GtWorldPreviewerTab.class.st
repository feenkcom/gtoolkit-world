Class {
	#name : #GtWorldPreviewerTab,
	#superclass : #Object,
	#instVars : [
		'tabSpace'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewerTab >> asElement [
	| pagers |
	pagers := tabSpace model root query // GtPager.
	^ pagers isNotEmpty
		ifTrue: [ | pagePreviews pager |
			pager := pagers anyOne.
			pagePreviews := pager pages
					collectWithIndex: [ :each :index | 
						GtWorldPreviewerPagerPage new
							page: each;
							tabSpace: tabSpace;
							pager: pager;
							pageIndex: index ].
			BrSimpleList horizontal
				hMatchParent;
				vFitContent;
				itemStencil: [ BrVerticalPane new
						hFitContent;
						vFitContentLimited;
						margin: (BlInsets all: 10);
						background: Color white;
						addAptitude: BrShadowAptitude ];
				itemDataBinder: [ :anElement :aPagePreview :anIndex | 
					anElement
						enqueueTask: (BlTaskAction new
								action: [ anElement
										removeChildren;
										addChild: aPagePreview asElement ]) ];
				items: pagePreviews ]
		ifFalse: [ | container |
			container := BrVerticalPane new
					fitContent;
					margin: (BlInsets all: 10);
					background: Color white;
					addAptitude: BrShadowAptitude.
			container
				enqueueTask: (BlTaskAction new
						action: [ container
								addChild: (BlExporter form
										element: tabSpace model root;
										scaled: 0.3;
										export) asElement ]) ]
]

{ #category : #accessing }
GtWorldPreviewerTab >> tabLabel [
	^ tabSpace tabLabel text asString
]

{ #category : #accessing }
GtWorldPreviewerTab >> tabSpace: eachTabSpace [ 
	tabSpace := eachTabSpace
]
