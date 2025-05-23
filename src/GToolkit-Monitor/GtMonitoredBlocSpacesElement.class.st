Class {
	#name : #GtMonitoredBlocSpacesElement,
	#superclass : #BlElement,
	#instVars : [
		'spacesList'
	],
	#category : #'GToolkit-Monitor-Bloc Spaces'
}

{ #category : #'instance creation' }
GtMonitoredBlocSpacesElement class >> open [
	<script: 'self open'>
	GtInspector openOn: self new title: 'Monitor'
]

{ #category : #initialization }
GtMonitoredBlocSpacesElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	spacesList := BrColumnedList new.
	spacesList addEventHandler: (GtPhlowListToSelectHandler new).
	spacesList rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new
		cellSpacing: 10;
		padding: (BlInsets top: 4 bottom: 4)).

	spacesList column
		title: 'Space';
		stencil: [ :aMonitoredSpace |
			| aTitle |
			
			aTitle := aMonitoredSpace exists
				ifTrue: [ aMonitoredSpace title trimmed ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			aTitle size isZero ifTrue: [ aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aTitle;
				hMatchParent ].

	spacesList column
		title: 'Opened';
		stencil: [ :aMonitoredSpace |
			| isOpened |

			isOpened := aMonitoredSpace exists
				ifTrue: [ aMonitoredSpace isRunning
					ifTrue: [ 'Running' asRopedText bold ]
					ifFalse: [
						aMonitoredSpace isRunningAsSubSpace
							ifTrue: [ 'Running' asRopedText bold, ' (sub-space)' asRopedText ]
							ifFalse: [ 'Dead' asRopedText foreground: Color red darker; bold ] ] ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].

			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: isOpened;
				hMatchParent ].

	spacesList column
		title: 'Shutsdown GT';
		stencil: [ :aMonitoredSpace |
			| shouldShutdown |

			shouldShutdown := aMonitoredSpace shouldShutdownOnClose
				ifTrue: [ 'Shuts down on close' asRopedText bold ]
				ifFalse: [ '' asRopedText ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: shouldShutdown;
				hMatchParent ].
		
	self addChild: spacesList.
	
	self updateList
]

{ #category : #updating }
GtMonitoredBlocSpacesElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedFutureAction new
				name: '[Monitor] Bloc spaces';
				futureConfiguration: GtMonitorConfiguration defaultFutureConfiguration;
				element: self;
				action: [ | allSpaces |
					allSpaces := BlSpace allSubInstances
						sorted: [ :a :b | a title < b title ].
					allSpaces := allSpaces sorted: [ :a :b | a isOpened ].
					allSpaces := allSpaces
						collect: [ :eachSpace | GtMonitoredBlocSpace new space: eachSpace ].
					allSpaces ];
				onFailureEnqueueAction: [ 'Failed to update Spaces list' traceCr ];
				onSuccessEnqueueAction: [ :theSpaces | 
					spacesList items: theSpaces.
					self
						enqueueTask:
							(BlDelayedTaskAction new
								delay: 5 seconds;
								action: [ self updateList ]) ])
]
