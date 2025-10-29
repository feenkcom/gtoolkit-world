Class {
	#name : #GtWorldPreviewerTabModel,
	#superclass : #Object,
	#instVars : [
		'tabModelWithSpace',
		'tabContent'
	],
	#classVars : [
		'IsTreePagerEnabled'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #settings }
GtWorldPreviewerTabModel class >> disableTreePager [
	IsTreePagerEnabled := false
]

{ #category : #settings }
GtWorldPreviewerTabModel class >> enableTreePager [
	IsTreePagerEnabled := true
]

{ #category : #settings }
GtWorldPreviewerTabModel class >> isTreePagerEnabled [
	^ IsTreePagerEnabled ifNil: [ IsTreePagerEnabled := false ]
]

{ #category : #accessing }
GtWorldPreviewerTabModel >> asElement [
	^ GtWorldPreviewerTabElement new tabModel: self
]

{ #category : #accessing }
GtWorldPreviewerTabModel >> asElementOld [
	| pagers |
	pagers := tabModelWithSpace model root query // GtPager.
	^ pagers isNotEmpty
		ifTrue: [ | pagePreviews pager |
			pager := pagers anyOne.
			pagePreviews := pager pages
					collectWithIndex: [ :each :index | 
						GtWorldPreviewerPagerPageModel new
							page: each;
							tabSpace: tabModelWithSpace;
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
			tabSpacePreview := GtWorldPreviewerTabContentSpaceModel new tabModelWithSpace: tabModelWithSpace.
			container
				enqueueTask: (BlTaskAction new action: [ container addChild: tabSpacePreview asElement ]) ]
]

{ #category : #initialization }
GtWorldPreviewerTabModel >> createTabContent [
	self queries
		do: [ :eachQuery | 
			(eachQuery tabItemForTabModel: tabModelWithSpace)
				ifNotNil: [ :aTabContent | ^ aTabContent ] ].

	^ GtWorldPreviewerTabContentSpaceModel new tabModelWithSpace: tabModelWithSpace
]

{ #category : #accessing }
GtWorldPreviewerTabModel >> gtDisplayOn: stream [
	stream nextPutAll: self tabLabel storeString
]

{ #category : #views }
GtWorldPreviewerTabModel >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]

{ #category : #views }
GtWorldPreviewerTabModel >> gtPagePreviewsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Page previews';
		priority: 10;
		items: [ self pagerPagePreviews ];
		column: 'Value' text: [ :each | each gtDisplayString ];
		column: 'Page index' text: [:each | each pageIndex ]
]

{ #category : #queries }
GtWorldPreviewerTabModel >> linearPagerQuery [
	<gtPreviewerQuery>
	^ GtWorldPreviewerTabExplicitQuery new
		elementClass: GtPager;
		stencil: [ :aTabModelWithSpace :aPager | 
			GtWorldPreviewerTabContentPagerModel new
				tabModelWithSpace: aTabModelWithSpace;
				pagerElement: aPager ]
]

{ #category : #'api - content' }
GtWorldPreviewerTabModel >> pagerPagePreviews [
	| pagers |
	pagers := tabModelWithSpace model root query // GtPager.
	^ pagers isNotEmpty
		ifTrue: [ | pagePreviews pager |
			pager := pagers anyOne.
			pagePreviews := pager pages
					collectWithIndex: [ :each :index | 
						GtWorldPreviewerPagerPageModel new
							page: each;
							tabModelWithSpace: tabModelWithSpace;
							pager: pager;
							pageIndex: index ] ]
		ifFalse: [ {GtWorldPreviewerTabContentSpaceModel new tabModelWithSpace: tabModelWithSpace} ]
]

{ #category : #queries }
GtWorldPreviewerTabModel >> queries [
	| somePragmas someQueries |
	somePragmas := Pragma
			allNamed: #gtPreviewerQuery
			from: self class
			to: GtWorldPreviewerTabModel.

	someQueries := somePragmas
			collect: [ :eachPragma | self perform: eachPragma methodSelector ]
			thenReject: #isNil.

	^ someQueries
]

{ #category : #'api - content' }
GtWorldPreviewerTabModel >> tabContent [
	<return: #GtWorldPreviewerTabContentModel>
	^ tabContent ifNil: [ tabContent := self createTabContent ]
]

{ #category : #accessing }
GtWorldPreviewerTabModel >> tabLabel [
	^ tabModelWithSpace tabLabel text asString
]

{ #category : #accessing }
GtWorldPreviewerTabModel >> tabSpace: aTabSpace [
	"Set a BrTabModel with a space as a model"

	self assert: [ aTabSpace isKindOf: BrTabModel ].
	self assert: [ aTabSpace model isKindOf: BlSpace ].

	tabModelWithSpace := aTabSpace.
	tabContent := nil
]

{ #category : #queries }
GtWorldPreviewerTabModel >> treePagerQuery [
	<gtPreviewerQuery>
	self class isTreePagerEnabled ifFalse: [ ^ nil ].
	
	^ GtWorldPreviewerTabExplicitQuery new
		elementClass: GtTreePagerFlowPanesElement;
		stencil: [ :aTabModelWithSpace :aPager | 
			GtWorldPreviewerTabContentTreePagerModel new
				tabModelWithSpace: aTabModelWithSpace;
				treePagerElement: aPager ]
]
