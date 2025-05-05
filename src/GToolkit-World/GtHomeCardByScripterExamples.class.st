Class {
	#name : #GtHomeCardByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-World-Examples'
}

{ #category : #examples }
GtHomeCardByScripterExamples >> displayTooltip [
	<gtExample>
	<return: #BlScripter>
	| aScripter aCard aLoggerStep |
	aScripter := self
			scripterWithElement: [ aCard := GtHomeCardExamples new jobCard.
				aCard asElement ].

	aScripter memoryLogger
		runFor: BlElementNamedChildNotFoundSignal , ExceptionSignal
		during: [ :aStep | 
			aLoggerStep := aStep.
			aStep mouseMoveOver
				label: 'Open tooltip';
				play ].

	aScripter assert
		label: 'Assert tooltip text';
		value: [ :aLabel | aLabel text asString ] equals: [ aCard description ];
		onSpaceRoot;
		onDropdown: true;
		// #'menu--label';
		play.

	aScripter assert
		label: 'Assert no Beacon signals';
		satisfies: [ aLoggerStep recordings isEmpty ]
			description: [ 'There must be zero Beacon signals, but received {1} signals: {2}'
					format: {aLoggerStep recordings size.
							aLoggerStep recordings} ];
		play.

	^ aScripter
]
