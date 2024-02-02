"
I am a model for a home card. See GtHomeCardExamples.
"
Class {
	#name : #GtHomeCard,
	#superclass : #Object,
	#instVars : [
		'title',
		'description',
		'action',
		'page',
		'priority'
	],
	#category : #'GToolkit-World-Sections'
}

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

	^ container addChild: self cardLabel preventMeAndChildrenMouseEvents
]

{ #category : #'view creation' }
GtHomeCard >> cardLabel [
	^ (BrLabel new
		text: self title;
		aptitude: BrGlamorousLabelAptitude new bold;
		padding: (BlInsets all: 20)) asScalableElement
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
	^ [ :aButton :aModel :anEvent |
		self page ifNotNil: [ self spawnPageFrom: aButton ] ]
]

{ #category : #accessing }
GtHomeCard >> defaultDescription [
	^ page ifNil: [ 'A description' ] ifNotNil: [ page title ]
]

{ #category : #accessing }
GtHomeCard >> defaultTitle [
	^ page ifNil: [ 'A Card' ] ifNotNil: [ page title ]
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
	^ aView explicit
		title: 'Live';
		priority: 10;
		stencil: [ self asElement ]
]

{ #category : #accessing }
GtHomeCard >> page [
	"NB: Could be nil"

	^ page
]

{ #category : #accessing }
GtHomeCard >> page: aLePage [
	page := aLePage
]

{ #category : #accessing }
GtHomeCard >> priority [
	^ priority ifNil: [ 0 ]
]

{ #category : #accessing }
GtHomeCard >> priority: anObject [
	priority := anObject
]

{ #category : #'view creation' }
GtHomeCard >> spaceGap [
	^ 10
]

{ #category : #accessing }
GtHomeCard >> spawnPageFrom: aButton [
	^ GtWorldUtility
		showSpaceWithTitle: self page title
		inPagerWith: [ self page asLepiterPagePhlowTool asElementDo: [ :e | e ] ]
				asStencil
		from: aButton
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
