Class {
	#name : #GtWorldPreview,
	#superclass : #Object,
	#instVars : [
		'world'
	],
	#category : #'GToolkit-World-UI - Preview'
}

{ #category : #accessing }
GtWorldPreview >> asElement [
	^ BrSimpleList vertical matchParent
		itemStencil: [ BrVerticalPane new
				padding: (BlInsets all: 10);
				hMatchParent;
				vFitContentLimited ];
		itemDataBinder: [ :anElement :aPreview :anIndex | 
			anElement
				removeChildren;
				addChild: (BrLabel new text: aPreview tabLabel; aptitude: (BrGlamorousLabelAptitude new foreground: Color gray));
				addChild: (aPreview asElement
						when: BlClickEvent
						do: [ :e | e target phlow spawnObject: aPreview ]) ];
		items: self worldTabs
]

{ #category : #accessing }
GtWorldPreview >> gtLiveFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Preview';
		stencil: [ self asElement ]
]

{ #category : #accessing }
GtWorldPreview >> gtTabsFor: aView [
	<gtView>
	^ aView list 
		title: 'Tabs';
		items: [ self worldTabs ]
]

{ #category : #accessing }
GtWorldPreview >> world: aWorld [
	world := aWorld
]

{ #category : #accessing }
GtWorldPreview >> worldTabs [
	| tabs |
	tabs := world tabGroup viewModel tabs.
	^ (tabs reject: [ :eachTabSpace | eachTabSpace tabLabel text asString = 'Home' ])
		collect: [ :eachTabSpace | GtWorldTabPreview new tabSpace: eachTabSpace ]
]
