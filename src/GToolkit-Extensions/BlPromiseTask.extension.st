Extension { #name : #BlPromiseTask }

{ #category : #'*GToolkit-Extensions' }
BlPromiseTask >> gtInspectPromiseActionFor: anAction [
	<gtAction>
	self promise ifNil: [ ^ anAction noAction ].
	
	^ anAction button
		icon: BrGlamorousVectorIcons inspect;
		label: 'Promise';
		action: [ :aButton | aButton phlow spawnObject: self promise ]
]

{ #category : #'*GToolkit-Extensions' }
BlPromiseTask >> gtPromiseCompositionFor: aView [
	<gtView>
	 self promise ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Promise composition';
		object: [ self promise ];
		view: #gtCompositionFor:
]

{ #category : #'*GToolkit-Extensions' }
BlPromiseTask >> gtPromiseFor: aView [
	<gtView>
	self promise ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Promise';
		object: [ self promise ];
		view: #gtPromiseFor:
]
