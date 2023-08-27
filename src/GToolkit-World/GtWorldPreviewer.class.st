Class {
	#name : #GtWorldPreviewer,
	#superclass : #Object,
	#instVars : [
		'world',
		'worldElement'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreviewer >> asElement [
	| container list |
	container := BrVerticalPane new.
	container
		background: Color white;
		addAptitude: BrShadowAptitude new beLarge;
		margin: (BlInsets all: 100);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	container
		addChild: (BrLabel new
				text: 'Preview of all tabs and pager pages. Select to navigate.';
				margin: (BlInsets all: 20);
				aptitude: (BrGlamorousLabelAptitude new
						fontSize: 20;
						foreground: Color gray)).
	list := BrSimpleList vertical matchParent
			itemStencil: [ BrVerticalPane new
					padding: (BlInsets all: 10);
					hMatchParent;
					vFitContentLimited ];
			itemDataBinder: [ :anElement :aPreview :anIndex | 
				anElement
					removeChildren;
					addChild: (BrLabel new
							text: aPreview tabLabel;
							margin: (BlInsets left: 10);
							aptitude: (BrGlamorousLabelAptitude new foreground: Color gray));
					addChild: aPreview asElement ];
			items: self worldTabs.
	container addChild: list.
	^ container
]

{ #category : #accessing }
GtWorldPreviewer >> gtLiveFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Preview';
		stencil: [ self asElement ]
]

{ #category : #accessing }
GtWorldPreviewer >> gtTabsFor: aView [
	<gtView>
	^ aView list 
		title: 'Tabs';
		items: [ self worldTabs ]
]

{ #category : #accessing }
GtWorldPreviewer >> world: aWorld [
	worldElement := aWorld root children first.
]

{ #category : #accessing }
GtWorldPreviewer >> worldElement: aWorldElement [
	worldElement := aWorldElement
]

{ #category : #accessing }
GtWorldPreviewer >> worldTabs [
	| tabs |
	tabs := worldElement children first viewModel tabs.
	^ (tabs reject: [ :eachTabSpace | eachTabSpace tabLabel text asString = 'Home' ])
		collect: [ :eachTabSpace | GtWorldPreviewerTab new tabSpace: eachTabSpace ]
]
