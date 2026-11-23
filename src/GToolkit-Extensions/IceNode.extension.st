Extension { #name : #IceNode }

{ #category : #'*GToolkit-Extensions' }
IceNode >> gtViewClassBlueprintFor: aView [
	<gtView>
	| classDefinition |
	(self value isKindOf: IceOperation) ifFalse: [ ^ aView empty ].
	classDefinition := self definition.
	(classDefinition isClassDefinition and: [ classDefinition canBeBrowsed ])
		ifFalse: [ ^ aView empty ].
	(classDefinition actualClass respondsTo: #gtInitializerMethods)
		ifFalse: [ ^ aView empty ].
	^ aView canvassable
		title: 'Class Blueprint';
		priority: 22;
		question: 'What changed in this class?';
		stencil: [ GtClassBlueprintDiff on: self ]
]
