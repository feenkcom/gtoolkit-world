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
		ifFalse: [ | container tabSpacePreview |
			container := BrVerticalPane new
					fitContent;
					margin: (BlInsets all: 10);
					background: Color white;
					addAptitude: BrShadowAptitude.
			tabSpacePreview := GtWorldPreviewerTabSpace new tabSpace: tabSpace.
			container
				enqueueTask: (BlTaskAction new action: [ container addChild: tabSpacePreview asElement ]) ]
]

{ #category : #accessing }
GtWorldPreviewerTab >> gtDisplayOn: stream [
	stream nextPutAll: self tabLabel storeString
]

{ #category : #views }
GtWorldPreviewerTab >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]

{ #category : #views }
GtWorldPreviewerTab >> gtPagePreviewsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Page previews';
		priority: 10;
		items: [ self pagerPagePreviews ];
		column: 'Value' text: [ :each | each gtDisplayString ];
		column: 'Page index' text: [:each | each pageIndex ]
]

{ #category : #accessing }
GtWorldPreviewerTab >> pagerPagePreviews [
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
							pageIndex: index ] ]
		ifFalse: [ {GtWorldPreviewerTabSpace new tabSpace: tabSpace} ]
]

{ #category : #accessing }
GtWorldPreviewerTab >> tabLabel [
	^ tabSpace tabLabel text asString
]

{ #category : #accessing }
GtWorldPreviewerTab >> tabSpace: eachTabSpace [ 
	tabSpace := eachTabSpace
]
