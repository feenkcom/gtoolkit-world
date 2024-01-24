Extension { #name : #TelemetrySignal }

{ #category : #'*GToolkit-Profiler' }
TelemetrySignal >> gtElementUpdatesFor: aView [
	<gtView>
	| spaceSnapshot spaceExtent layoutRequestedSignals repaintRequestedSignals |
	
	spaceSnapshot := data
		at: #spaceSnapshot
		ifAbsent: [ ^ aView empty ].
		
	spaceExtent := spaceSnapshot value.
	spaceSnapshot := spaceSnapshot key.
	
	layoutRequestedSignals := data at: #beacon
		ifPresent: [ :signals | signals select: [ :each | each isKindOf: BlRequestLayoutSignal ] ]
		ifAbsent: [ #() ].
	
	layoutRequestedSignals := layoutRequestedSignals groupedBy: [ :each | each element ].
	
	repaintRequestedSignals := data at: #beacon
		ifPresent: [ :signals | signals select: [ :each | each isKindOf: BlMarkElementNeedsPaintSignal ] ]
		ifAbsent: [ #() ].

	repaintRequestedSignals := repaintRequestedSignals groupedBy: [ :each | each element ].
	
	^ aView explicit
		title: 'Element updates';
		priority: 7;
		stencil: [
			| areasRequestingLayout areasRequestingRepaint |
			
			areasRequestingLayout := layoutRequestedSignals keys
				collect: [ :eachElement |
					| eachBounds |
					
					eachBounds := (layoutRequestedSignals at: eachElement) anyOne boundsInSpace insetBy: 0.5.
					
					BlElement new
						relocate: eachBounds origin;
						size:eachBounds extent;
						background: (Color blue alpha: 0.15);
						outskirts: (BlOutskirts inside);
						border: (BlBorder paint: (Color blue alpha: 0.5) width: 1) ].
						
			areasRequestingRepaint := repaintRequestedSignals keys
				collect: [ :eachElement |
					| eachBounds |
					
					eachBounds := (repaintRequestedSignals at: eachElement) anyOne boundsInSpace insetBy: 0.5.
					
					BlElement new
						relocate: eachBounds origin;
						size:eachBounds extent;
						background: (Color red alpha: 0.15);
						outskirts: (BlOutskirts inside);
						border: (BlBorder paint: (Color red alpha: 0.5) width: 1);
						when: BlClickEvent do: [ :e |
							e consumed: true.
							e currentTarget phlow spawnObject: (repaintRequestedSignals at: eachElement) ] ].
			BrVerticalPane new
				fitContent;
				alignCenter;
				addChild: (BlElement new
					size: spaceExtent;
					addChild: spaceSnapshot asElement asScalableElement;
					addChildren: areasRequestingLayout;
					addChildren: areasRequestingRepaint);
				
				addChild: (BrHorizontalPane new
					fitContent;
					cellSpacing: 20;
					addChild: (BrHorizontalPane new
						fitContent;
						alignCenter;
						margin: (BlInsets top: 10);
						addChildren: {
							BlElement new
								size: 20@20;
								background: (Color blue alpha: 0.15);
								border: (BlBorder paint: (Color blue alpha: 0.5) width: 1).
							BrLabel new
								text: ' - requested layout';
								aptitude: BrGlamorousLabelAptitude
						});
					addChild: (BrHorizontalPane new
						fitContent;
						alignCenter;
						margin: (BlInsets top: 10);
						addChildren: {
							BlElement new
								size: 20@20;
								background: (Color red alpha: 0.15);
								border: (BlBorder paint: (Color red alpha: 0.5) width: 1).
							BrLabel new
								text: ' - requested repaint';
								aptitude: BrGlamorousLabelAptitude
						}));
				asScalableElement ]
]

{ #category : #'*GToolkit-Profiler' }
TelemetrySignal >> gtOneLineFor: aView [
	^ aView empty
]

{ #category : #'*GToolkit-Profiler' }
TelemetrySignal >> gtSignals: aView [
	<gtView>
	
	data at: #beacon
		ifPresent: [ :signals | signals ifEmpty: [ ^ aView empty ] ]
		ifAbsent: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Signals';
		priority: 8;
		items: [ data at: #beacon ];
		column: 'Time' text: [ :each |
			(each timestamp asTime print24 asRopedText glamorousCodeSmallSize foreground: Color gray),
			'.' asRopedText,
			(each timestamp nanoSecond // 1000000) asString asRopedText ] width: 100;
		column: 'Type' text: [ :each | each class name ] width: 300;
		column: 'Signal' text: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Grouped by type'
			tooltip: 'Inspect signals grouped by type'
			action: [ :aButton | aButton phlow spawnObject: (data at: #beacon
				ifPresent: [ :signals | signals groupedBy: [ :each | each class ] ]
				ifAbsent: [ #() ] ) ]
]

{ #category : #'*GToolkit-Profiler' }
TelemetrySignal >> gtViewsFor: aView inContext: aContext [
	| pingView myView allViews |
	
	myView := super gtViewsFor: aView inContext: aContext.
	pingView := task gtViewsFor: aView inContext: aContext.
	
	allViews := myView originalView views.
	allViews addAll: (pingView originalView views reject: [ :each | allViews anySatisfy: [ :v | v title = each title ] ]).
	allViews := allViews sorted: [ :a :b | a priority < b priority ].
	myView originalView views: allViews.
	
	^ myView
]
