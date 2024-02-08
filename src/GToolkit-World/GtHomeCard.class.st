"
I am a model for a home card. See {{gtClass:name=GtHomeCardExamples}}.
"
Class {
	#name : #GtHomeCard,
	#superclass : #Object,
	#instVars : [
		'title',
		'description',
		'action',
		'priority',
		'definingMethod'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeCard class >> empty [
	^ GtEmptyHomeCard new
		definingMethod: (GtPhlowDefiningMethodsCollector new
				stack: thisContext stack;
				collect)
]

{ #category : #accessing }
GtHomeCard class >> errorCard [
	^ GtHomeErrorCard new
		definingMethod: (GtPhlowDefiningMethodsCollector new
				stack: thisContext stack;
				collect)
]

{ #category : #accessing }
GtHomeCard class >> jobs [
	^ GtJobHomeCard new
		definingMethod: (GtPhlowDefiningMethodsCollector new
				stack: thisContext stack;
				collect)
]

{ #category : #accessing }
GtHomeCard class >> lazy [
	^ GtLazyHomeCard new
		definingMethod: (GtPhlowDefiningMethodsCollector new
				stack: thisContext stack;
				collect)
]

{ #category : #example }
GtHomeCard class >> page [
	^ GtHomePageCard new
		definingMethod: (GtPhlowDefiningMethodsCollector new
				stack: thisContext stack;
				collect)
]

{ #category : #accessing }
GtHomeCard >> action [
	^ action ifNil: [ self defaultAction ]
]

{ #category : #accessing }
GtHomeCard >> action: aBlock [
	action := aBlock
]

{ #category : #accessing }
GtHomeCard >> asElement [
	^ self create
]

{ #category : #'view creation' }
GtHomeCard >> cardButton [
	| container |
	container := BrButton new
			size: self cardSize;
			layout: BlLinearLayout vertical;
			aptitude: (BrGlamorousButtonExteriorAptitude new
					backgroundPaint: Color white;
					borderPaint: Color transparent)
					+ BrGlamorousButtonWithLabelTooltipAptitude new
					+ BrShadowAptitude new beLarge;
			label: self description;
			padding: (BlInsets all: 1);
			margin: (BlInsets
					top: self spaceGap
					left: 2 * self spaceGap
					bottom: 2 * self spaceGap
					right: 2 * self spaceGap);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
			action: self action.
	container addAptitude: (GtPhlowBrowseDefinitionAptitude new
		definition: [ self definingMethod ]).

	^ container addChild: self cardLabel asScalableElement preventMeAndChildrenMouseEvents
]

{ #category : #'view creation' }
GtHomeCard >> cardLabel [
	^ BrLabel new
		text: self title;
		aptitude: self cardLabelAptitude;
		padding: (BlInsets all: 20)
]

{ #category : #'view creation' }
GtHomeCard >> cardLabelAptitude [
	^ BrGlamorousLabelAptitude new bold
]

{ #category : #'view creation' }
GtHomeCard >> cardSize [
	^ 200 @ 150
]

{ #category : #'view creation' }
GtHomeCard >> create [
	^ self cardButton
]

{ #category : #accessing }
GtHomeCard >> defaultAction [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtHomeCard >> defaultDescription [
	^ 'A description'
]

{ #category : #accessing }
GtHomeCard >> defaultTitle [
	^ 'A Home Card'
]

{ #category : #accessing }
GtHomeCard >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtHomeCard >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #accessing }
GtHomeCard >> description [
	"For tooltip"

	^ description ifNil: [ self defaultDescription ]
]

{ #category : #accessing }
GtHomeCard >> description: aString [
	description := aString
]

{ #category : #accessing }
GtHomeCard >> gtDisplayOn: stream [
	stream nextPutAll: self title
]

{ #category : #accessing }
GtHomeCard >> gtLiveFor: aView [
	<gtView>
	self isEmpty ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Live';
		priority: 10;
		stencil: [ self asElement ]
]

{ #category : #testing }
GtHomeCard >> isEmpty [
	^ false
]

{ #category : #obsolete }
GtHomeCard >> obsoleteInitializeDefiningMethod [
	"NB: skip this method and the initialize method!
	The first heuristic of looking just up the stack above
		new -> initialize -> this method
	seems to always work.
	If it doesn't we can look for methods with the gtSectionCard
	or methods that refer to GtHomeCard or one of its subclasses."

	
	| stack |
	
	self deprecated: 'We are using the GtPhlowDefiningMethodsCollector instead. See GtHomeCard class>>#page'.

	stack := thisContext stack copyFrom: 3 to: 10.	"Probably overkill."
	(stack at: 1) method selector = #new
		ifTrue: [ ^ definingMethod := stack at: 2 ].	"Usually we are done here.
	The rest is fallback."

	stack
		detect: [ :each | each method hasPragmaNamed: 'gtSectionCard' ]
		ifFound: [ :m | ^ definingMethod := m ].

	"stack
		detect: [ :each | 
			each method isCompiledMethod
				and: [ each method referencedClasses includes: GtHomeCard ] ]
		ifFound: [ :m | ^ definingMethod := m ]."
	
	stack
		detect: [ :each | 
			each method isCompiledMethod
				and: [ (each method referencedClasses
						select: [ :class | class inheritsFrom: GtHomeCard ]) isNotEmpty ] ]
		ifFound: [ :m | ^ definingMethod := m ].

	definingMethod := nil
]

{ #category : #accessing }
GtHomeCard >> priority [
	^ priority ifNil: [ 0 ]
]

{ #category : #accessing }
GtHomeCard >> priority: anObject [
	priority := anObject
]

{ #category : #utility }
GtHomeCard >> repoIsPresent: aRepoName [
	^ IceRepository registry
		detect: [ :aRepository | aRepository name = aRepoName ]
		ifFound: [ :aRepository | true ]
		ifNone: [ false ]
]

{ #category : #'view creation' }
GtHomeCard >> spaceGap [
	^ 10
]

{ #category : #utility }
GtHomeCard >> spawnObject: anObject from: aButton [
	"If we are in a pager, spawn the page in the current phlow, else create a new pager."

	^ aButton
		allParentsDetect: [ :aParent | aParent isKindOf: GtPager ]
		ifFound: [ :aParent | aButton phlow spawnObject: anObject ]
		ifNone: [ GtWorldUtility showObject: anObject from: aButton ]
]

{ #category : #utility }
GtHomeCard >> spawnPage: aPage from: aButton [
	"If we are in a pager, spawn the page in the current phlow, else create a new pager."

	^ aButton
		allParentsDetect: [ :aParent | aParent isKindOf: GtPager ]
		ifFound: [ :aParent | aButton phlow spawnTool: aPage asPhlowTool ]
		ifNone: [ GtWorldUtility
				showSpaceWithTitle: aPage title
				inPagerWith: [ aPage asLepiterPagePhlowTool asElementDo: [ :e | e ] ]
						asStencil
				from: aButton ]
]

{ #category : #accessing }
GtHomeCard >> title [
	"Title to display on the card"
	^ title ifNil: [ self defaultTitle ]
]

{ #category : #accessing }
GtHomeCard >> title: aString [
	title := aString
]
