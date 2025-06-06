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
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		addAptitude: BrShadowAptitude new beLarge;
		margin: (BlInsets all: 100);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	container
		addChild: (BrLabel new
				text: 'Preview of all tabs and pager pages. Select to navigate.';
				margin: (BlInsets
						top: 10
						left: 20
						bottom: 10
						right: 10);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray)).
	list := BrSimpleList vertical matchParent
			itemStencil: [ BrVerticalPane new
					margin: (BlInsets
							top: 20
							left: 10
							bottom: 10
							right: 10);
					hMatchParent;
					vFitContentLimited ];
			itemDataBinder: [ :anElement :aPreview :anIndex | 
				anElement
					removeChildren;
					addChild: (BrHorizontalPane new
							fitContent;
							alignCenter;
							addChild: (BrLabel new
									text: 'Tab: ' , aPreview tabLabel;
									margin: (BlInsets left: 10);
									aptitude: BrGlamorousLabelAptitude new);
							addChild: (BrButton new
									beTinySize;
									margin: (BlInsets left: 10);
									aptitude: BrGlamorousButtonWithLabelAptitude new;
									label: 'Screenshot';
									withAsyncFutureDo: [ :anElementFuture |
										anElementFuture 
											whenPending: [ :theButton | theButton disable ];
											whenError: [ :theButton :anError | 
												| aCopyError |
												aCopyError := GtSystemUtility freeze: anError.
												theButton 
													enable; 
													background: theButton theme status errorBackgroundColor;
													action: [ :aButton | aButton phlow spawnObject: aCopyError ] ];
											whenSuccess: [ :theButton :aData | theButton enable ] ];
									action: [ :theButton |
										| screenshot |
										theButton asyncFuture future: [
											screenshot := BrHorizontalPane new fitContent cellSpacing: 20; background: Color white.
											aPreview pagerPagePreviews
												do: [ :each | 
													screenshot
														addChild: ((each asElementScaled: 1)
																margin: (BlInsets all: 20);
																addAptitude: BrShadowAptitude new beLarge) ].
											(BlScripter new
												maxPulseElapsedTime: 30 seconds;
												element: screenshot) element exportAsPNG ] ]));
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
