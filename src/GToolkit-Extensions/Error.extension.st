Extension { #name : #Error }

{ #category : #'*GToolkit-Extensions' }
Error >> gtScripterPreviewFor: aView [
	<gtView>
	<gtExceptionView>
	| aScripter |
	
	self gtHasStack ifFalse: [ ^ aView empty ].
	aScripter := self gtScripter.
	aScripter ifNil: [
		^ aView empty ].

	^ aView forward
		title: 'Scripter preview';
		priority: 0;
		object: [ aScripter ];
		view: #gtSpaceFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Scripter'
			tooltip: 'Inspect Scripter'
			action: [ :anElement | anElement phlow spawnObject: aScripter ]
]

{ #category : #'*GToolkit-Extensions' }
Error >> gtScripterStepsFor: aView [
	<gtView>
	<gtExceptionView>
	| aScripter |
	self gtHasStack ifFalse: [ ^ aView empty ].
	aScripter := self gtScripter.
	aScripter ifNil: [ ^ aView empty ].

	^ (aScripter gtStepsMondrianTreeFor: aView)
		title: 'Scripter steps';
		priority: -1;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Scripter'
			tooltip: 'Inspect Scripter'
			action: [ :anElement | anElement phlow spawnObject: aScripter ]
]
