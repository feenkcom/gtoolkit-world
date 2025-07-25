Extension { #name : #PackageTag }

{ #category : #'*GToolkit-Extensions' }
PackageTag >> gtClassHierarchyFor: aView [

	<gtView>
	<gtPackageTagView>
	^ aView mondrian
		  title: 'Classes map';
		  priority: 10.5;
		  tooltip: 'Classes: black, Traits: orange';
		  painting: [ :aMondrian | self paintClassHierarchyWith: aMondrian ];
		  actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
PackageTag >> gtTestsFor: aView context: aPhlowConetxt [
	<gtView>
	<gtPackageTagView>
	
	^ (GtPharoCoderUIUtility
		testMethodsPhlowViewFor: aView
		context: aPhlowConetxt
		filter: (GtSearchPackageTagTestSuiteFilter new packageTag: self))
			title: 'Tests';
			priority: 12
]

{ #category : #'*GToolkit-Extensions' }
PackageTag >> paintClassHierarchyWith: aMondrian [

	| aModel |
	aModel := self classes.
	aMondrian nodes
		shape: [ :aClass | 
			BrButton new
				fitContent;
				aptitude: (BrGlamorousLabelAptitude new
						 foreground: (aClass isTrait
								  ifTrue: [ Color orange ]
								  ifFalse: [ Color black ]);
						 glamorousRegularFont;
						 fontSize: 5);
				label: aClass name;
				action: [ :aButton | 
					aButton phlow spawnTool: (GtClassCoderTool forClass: aClass) ] ];
		with: aModel.
	aMondrian edges
		shape: [ :x | 
			BlLineElement new border:
					(BlBorder paint: (Color orange alpha: 0.5) width: 1) ];
		connect: (aModel select: #isTrait)
		from: [ :aTrait | aTrait ]
		toAll: [ :aTrait | aTrait users asOrderedCollection ].

	aMondrian edges
		shape: [ :x | 
			BlLineElement new border:
					(BlBorder paint: (Color black alpha: 0.5) width: 1) ];
		connect: (aModel reject: #isTrait)
		from: [ :aTrait | aTrait ]
		toAll: [ :aTrait | aTrait subclasses asOrderedCollection ].

	aMondrian layout force
		strength: 0.15;
		charge: -250;
		length: 70.
	aMondrian
]
