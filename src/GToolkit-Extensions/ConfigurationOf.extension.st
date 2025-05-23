Extension { #name : #ConfigurationOf }

{ #category : #'*GToolkit-Extensions' }
ConfigurationOf class >> gtMapFor: aView [
	<gtView>
	<gtClassView>
	^ self 
		gtMapFor: aView 
		selectRelationsThat: [ :aBaselineA :aBaselineB | true ]
		nameDisplayedAs: [ :aRopedText | aRopedText ]
]

{ #category : #'*GToolkit-Extensions' }
ConfigurationOf class >> gtMapFor: aView selectRelationsThat: aTwoArgBlock nameDisplayedAs: anOneArgBlock [
	| standardEdge |
	standardEdge := BlBorder paint: Color veryVeryLightGray.
	^ aView mondrian
		title: 'Map';
		priority: 10;
		painting: [ :mondrian | 
			| projects |
			projects := Set new.
			self project version
				withDeep: [ :each | each projects collect: #version ]
				relationDo: [ :a :b | 
					(aTwoArgBlock value: a value: b)
						ifTrue: [ projects
								add: a;
								add: b ] ].
			mondrian nodes
				shape: [ :each | 
					| text element |
					text := [ | displayString |
						displayString := ((each gtDisplayString
								copyReplaceAll: 'BaselineOf'
								with: '') copyReplaceAll: 'ConfigurationOf' with: '')
								copyReplaceAll: 'GToolkit'
								with: 'GT '.
						(anOneArgBlock value: displayString) asRopedText glamorousRegularFont ]
							on: Error
							do: [ :e | e asString asRopedText foreground: BrGlamorousColors linkWithErrorColor ].
					element := BlTextElement new.
					element
						text: text;
						zIndex: 1;
						when: BlClickEvent
							do: [ :e | 
								e consumed: true.
								element phlow
									spawnTool: (GtClassCoderTool forClass: each spec project configuration class realClass) ];
						when: BlMouseEnterEvent
							do: [ :anEvent | 
								anEvent currentTarget graph connectedEdges incoming
									do: [ :inner | 
										inner element border: (BlBorder paint: (Color blue muchLighter) width: 5).
										inner fromElement background: (Color blue muchLighter) ].
								anEvent currentTarget graph connectedEdges outgoing
									do: [ :inner | 
										inner element border: (BlBorder paint: (Color lightRed ) width: 5).
										inner toElement background: (Color lightRed) ] ];
						when: BlMouseLeaveEvent
							do: [ :anEvent | 
								anEvent currentTarget graph connectedEdges
									do: [ :inner | 
										inner element border: standardEdge.
										inner fromElement background: Color transparent.
										inner toElement background: Color transparent ] ] ];
				with: projects.
			mondrian edges
				shape: [ :each | 
					BlManhattanLineElement new
						zIndex: 0;
						beFixedTo;
						fixedDistance: 10;
						cornerRadius: 10;
						border: standardEdge;
						toHead: (BlArrowheadSimpleArrow new
								border: (BlBorder builder
										paint: (Color veryVeryLightGray);
										width: 1;
										build)) ];
				fromRightCenter;
				toLeftCenter;
				connectFrom: #yourself
					toAll: [ :each | 
						| dependedProjects |
						dependedProjects := each projects collect: #version.
						projects
							select: [ :project | dependedProjects anySatisfy: [ :dependedProject | dependedProject = project ] ] ].
			mondrian layout
				custom: (GtGradHorizontalDominanceTreeLayout new
						levelDistance: 10;
						nodeDistance: 10) ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
ConfigurationOf class >> gtPackagesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Packages';
		priority: 50;
		stencil: [ | list |
			list := BrColumnedList new items: [ self project version packages ].
			list addEventHandler: GtPhlowListToSelectHandler new.
			list column
				title: 'Packages';
				stencil: [ :aNode :index | 
					| text textElement |
					text := [ aNode gtDisplayString asRopedText ]
						on: Error
						do: [ aNode errorMessage asRopedText foreground: Color red ].
					textElement := (BrColumnCellLabelStencil matchParent: text)
						asElement.
					textElement
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c padding: (BlInsets left: 10) ] ].
			list ]
]

{ #category : #'*GToolkit-Extensions' }
ConfigurationOf class >> gtPackagesMapFor: aView [
	<gtView>
	<gtClassView>
	^ aView mondrian
		title: 'Packages map';
		priority: 11;
		painting: [ :mondrian | self paintPackagesMapWith: mondrian];
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
ConfigurationOf class >> gtPillarCommentFor: aView [
	^ (super gtPillarCommentFor: aView)
		priority: 0
]

{ #category : #'*GToolkit-Extensions' }
ConfigurationOf class >> gtProjectsFor: aView [
	<gtView>
	^ aView list
		title: 'Projects';
		priority: 10;
		items: [ self project version projects collect: [ :each | each version spec project configuration class ] ]
]

{ #category : #'*GToolkit-Extensions' }
ConfigurationOf class >> paintPackagesMapWith: mondrian [
	| packages projects |
	packages := self project version packages.
	projects := self project version projects.
	mondrian nodes 
		stencil: [ :packageSpec |
			BlTextElement new text: packageSpec name asRopedText ];
		with: packages.
	mondrian nodes 
		stencil: [ :projectSpec |
			| element |
			element := BlTextElement new.
			element 
				when: BlClickEvent do: [ :e | 
					e consumed: true. 
					element phlow spawnObject: (Smalltalk globals at: projectSpec constructClassName asSymbol) ];
				text: (projectSpec name asRopedText foreground: Color gray) ];
		with: projects.
	packages do: [ :p | 
		mondrian edges
			stencil: [ :x | 
				BlManhattanLineElement new 
					zIndex: 0;
					beFixedTo;
					cornerRadius: 10;
					fixedDistance: 10;
					border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
					toHead: (BlArrowheadSimpleArrow new
						border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 2; build)) ]; 
			fromRightCenter;
			toLeftCenter;
			connect: (p requires collect: [ :symbol | 
				packages 
					detect: [:package | package name = symbol ]
					ifNone: [ projects detect: [ :project | project name = symbol ] ] ])
			from:	[ :x | p ]
			to: #yourself ].
	mondrian layout horizontalDominanceTree nodeDistance: 10; levelDistance: 20
]
