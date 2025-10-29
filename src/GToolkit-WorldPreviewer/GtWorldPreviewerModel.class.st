Class {
	#name : #GtWorldPreviewerModel,
	#superclass : #Object,
	#instVars : [
		'world',
		'worldElement'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #accessing }
GtWorldPreviewerModel >> asElement [
	^ GtWorldPreviewerElement new previewer: self
]

{ #category : #accessing }
GtWorldPreviewerModel >> gtLiveFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Preview';
		stencil: [ self asElement ]
]

{ #category : #accessing }
GtWorldPreviewerModel >> gtTabsFor: aView [
	<gtView>
	^ aView list 
		title: 'Tabs';
		items: [ self worldTabs ]
]

{ #category : #accessing }
GtWorldPreviewerModel >> world: aWorld [
	worldElement := aWorld root children first.
]

{ #category : #accessing }
GtWorldPreviewerModel >> worldElement: aWorldElement [
	worldElement := aWorldElement
]

{ #category : #accessing }
GtWorldPreviewerModel >> worldTabs [
	| tabs |
	tabs := worldElement children first viewModel tabs.
	^ (tabs reject: [ :eachTabSpace | eachTabSpace tabLabel text asString = 'Home' ])
		collect: [ :eachTabSpace | GtWorldPreviewerTabModel new tabSpace: eachTabSpace ]
]
