Extension { #name : #Slot }

{ #category : #'*GToolkit-Extensions' }
Slot >> gtClassCoderFor: aView [
	<gtView>
	self owningClass ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Class coder';
		priority: 10;
		question: 'What is the code of the class that owns this slot?';
		stencil: [ GtCoderElement forClass: self owningClass ]
]

{ #category : #'*GToolkit-Extensions' }
Slot >> gtDisplayOn: aStream [
	self owningClass
		ifNotNil: [ :aClass | 
			aStream
				nextPutAll: aClass name;
				nextPutAll: ' @ ' ].
	super gtDisplayOn: aStream
]

{ #category : #'*GToolkit-Extensions' }
Slot >> gtReferencesFor: aView [
	<gtView>
	self owningClass ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'References';
		priority: 20;
		question: 'Which methods reference this slot?';
		object: [ (self owningClass isInstanceSide
				ifTrue: [ GtSearchInstanceSlotReferenceFilter ]
				ifFalse: [ GtSearchClassSlotReferenceFilter ])
				forClassAndSubclasses: self owningClass
				andVariable: self name ];
		view: #gtItemsFor:
]
