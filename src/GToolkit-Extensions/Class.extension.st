Extension { #name : #Class }

{ #category : #'*GToolkit-Extensions' }
Class >> gtAllConfigurationReferencesFor: aView [
	<gtView>
	<gtClassView>

	(self name beginsWith: ConfigurationOf name) ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'References';
		tooltip: 'Class and configuration references';
		priority: 40;
		stencil: [ 
			| aName |
			aName := self name withoutPrefix: ConfigurationOf name.
			self gtReferences
			| (('`@receiver configuration: ''', aName, ''' with: `@arg') gtASTMatches) ]
]

{ #category : #'*GToolkit-Extensions' }
Class >> gtAllReferencesFor: aView [
	<gtView>
	<gtClassView>
	(self name beginsWith: ConfigurationOf name) ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'References';
		tooltip: 'Class references';
		priority: 40;
		object: [ self gtReferences
				requesterContext: (GtSearchMethodCoderFilterContext new behavior: self) ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
Class >> gtExamplesFor: aView context: aPhlowContext [
	<gtView>
	<gtClassView>
	| anExampleViewModel |
	self gtExamplesAll isEmpty ifTrue: [ ^ aView empty ].

	anExampleViewModel := GtPharoCoderUIUtility
			exampleViewModelCachedAs: #exampleViewModelHandler_gtExamplesForContext
			inPhlowContext: aPhlowContext.

	^ aView explicit
		title: 'Examples';
		priority: 20;
		stencil: [ 
			| aCollection aGroup aGroupView anElement |
			
			"If it is an abstract class, collect examples of its subclasses."
			aCollection := self isAbstract
				ifTrue: [ (self allSubclasses reject: #isAbstract)
					flatCollect: #gtExamplesAll ]
				ifFalse: [ self gtExamplesAll ].
				
			aCollection := aCollection collect: #asCachedExampleWithResult.
			
			aGroup := GtExampleGroup withAll: aCollection.
			aGroupView := GtPhlowView empty on: aGroup perform: #gtExamplesFor:.
			anElement := aGroupView asElement.
			anElement userData at: #gtExamplesFor: put: aGroup.
			anExampleViewModel pharoExampleSuite stream: aCollection asAsyncStream.
			anElement ];
		actionStencil: [ :aBrTab | 
			GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionUpdateButtonTooltip: 'Update example list'
]

{ #category : #'*GToolkit-Extensions' }
Class >> gtExamplesMapFor: aView context: aPhlowContext [
	<gtView>
	<gtClassView>
	self gtExamplesAll ifEmpty: [ ^ aView empty ].

	^ aView forward
		title: 'Examples map';
		priority: 11;
		object: [ 
			| aCollection |
			
			"If it is an abstract class, collect examples of its subclasses."
			aCollection := self isAbstract
				ifTrue: [ (self allSubclasses reject: #isAbstract)
					flatCollect: #gtExamplesAll ]
				ifFalse: [ self gtExamplesAll ].
				
			aCollection := aCollection collect: #asCachedExampleWithResult.
		
			GtExampleGroup withAll: aCollection ];
		view: #gtMapFor:
]

{ #category : #'*GToolkit-Extensions' }
Class >> gtReferencesInSnippetsFor: aView [
	<gtView>
	<gtClassView>
	
	(self name beginsWith: ConfigurationOf name) ifTrue: [ ^ aView empty ].
	
	^ aView forward
		title: 'References in snippets';
		tooltip: 'References of the class in knowledge bases';
		priority: 40.1;
		object: [ self leReferences ];
		view: #gtItemsFor:
]
