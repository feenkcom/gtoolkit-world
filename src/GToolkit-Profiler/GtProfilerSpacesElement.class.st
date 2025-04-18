"
I display a list of running {{gtClass:BlSpace}} that can be profiled. I exclude the profiler space itself

"
Class {
	#name : #GtProfilerSpacesElement,
	#superclass : #BlElement,
	#instVars : [
		'spacesList'
	],
	#category : #'GToolkit-Profiler'
}

{ #category : #'instance creation' }
GtProfilerSpacesElement class >> open [
	<script: 'self open'>
	GtInspector openOn: self new title: 'Monitor'
]

{ #category : #accessing }
GtProfilerSpacesElement >> allOpenedSpaces [
	| openedSpaces |

	openedSpaces := BlSpace allSubInstances
		select: [ :eachSpace | eachSpace isOpened and: [ eachSpace ~~ self space ] ].

	openedSpaces := openedSpaces sorted: [ :a :b | a title < b title ].
	openedSpaces := openedSpaces collect: [ :eachSpace | GtProfilerSpace new space: eachSpace ].
	
	^ openedSpaces
]

{ #category : #initialization }
GtProfilerSpacesElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	spacesList := BrColumnedList new.
	spacesList beInSingleCompositionLayer. 
	spacesList addEventHandler: (GtPhlowListToSelectHandler new).
	spacesList rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new
		cellSpacing: 10;
		padding: (BlInsets top: 4 bottom: 4)).

	spacesList column
		title: 'Space';
		stencil: [ :aMonitoredSpace |
			| aTitle |
			
			aTitle := aMonitoredSpace title trimmed.
			aTitle ifEmpty: [ aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aTitle;
				hMatchParent ].

	spacesList column
		title: 'Opened';
		stencil: [ :aMonitoredSpace |
			| isOpened |

			isOpened := aMonitoredSpace isRunning
				ifTrue: [ 'Running' asRopedText bold ]
				ifFalse: [ 'Dead' asRopedText foreground: Color red darker; bold ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: isOpened;
				hMatchParent ].
		
	self addChild: spacesList.
	
	self updateList
]

{ #category : #updating }
GtProfilerSpacesElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedFutureAction new
				name: '[Monitor] Bloc spaces';
				futureConfiguration: GtMonitorConfiguration defaultFutureConfiguration;
				element: self;
				action: [ self allOpenedSpaces ];
				onFailureEnqueueAction: [ 'Failed to update Spaces list' traceCr ];
				onSuccessEnqueueAction: [ :theSpaces | 
					spacesList items: theSpaces.
					spacesList selectedIndices
						ifEmpty: [ theSpaces ifNotEmpty: [ spacesList selectOne: 1 ] ].
					self
						enqueueTask:
							(BlDelayedTaskAction new
								delay: 2 seconds;
								action: [ self updateList ]) ])
]
