Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtBasicSourceFor: aView [
	^ aView explicit
		title: 'Source';
		priority: 0;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self compiledMethod) ];
		stencil: [ 
			 ((((GtPharoMethodCoder forMethod: self) 
				subscribeToSystem) asCoderViewModel expanded: true)
				asElement) ].
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtImplementorsFor: aView [
	<gtView>
	^ aView forward
		title: 'Implementors';
		priority: 23;
		object: [ 
			| searchContext |
			searchContext := nil.
			self isDefined ifTrue: [
				searchContext := GtSearchMethodCoderFilterContext new 
					behavior: self methodClass;
					selectorInPosition: self selector ].
			self selector gtImplementors
				requesterContext: searchContext ];
		view: #gtItemsFor: 
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtSendersFor: aView [
	<gtView>
	^ aView forward
		title: 'Senders';
		priority: 22;
		object: [ 
			| searchContext |
			searchContext := nil.
			self isDefined ifTrue: [
				searchContext := GtSearchMethodCoderFilterContext new 
					behavior: self methodClass;
					nodeInPosition: self method ast;
					selectorInPosition: self selector ].
			self selector gtSenders
				requesterContext: searchContext ];
		view: #gtItemsFor: 
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> isClassSide [
	"For compatibility with CompiledMethod"
	^self isMetaSide
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> isGtSlide [
	^ self method isGtSlide
]
