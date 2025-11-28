Extension { #name : #GtPhlowActionNotProvidedError }

{ #category : #'*GToolkit-Extensions' }
GtPhlowActionNotProvidedError >> createAnnotatedCoderElement [
	| coder returnsStyler coderViewModel coderElement |
	coder := GtPharoMethodCoder forMethod: self actionMethod asRingDefinition.

	returnsStyler := GtPhlowReturnExplanationLinkStyler new.

	coder addOns addStyler: returnsStyler.

	coderViewModel := coder asCoderViewModel.
	coderViewModel expanded: true.

	coderElement := coderViewModel asElement.	"asExpandedOnlyElement vFitContentLimited"
	coderElement margin: (BlInsets all: 10).

	^ coderElement
]

{ #category : #'*GToolkit-Extensions' }
GtPhlowActionNotProvidedError >> createExplanationText [
	^ 'The Phlow action created by the method ' asRopedText
			,(self actionMethod printString asRopedText italic)
			,' returned a ' asRopedText
			, (self returnedObject class gtDisplayText glamorousExplanationFor: #ReturnNode)
			, ' kind of object. A phlow action is expected.' asRopedText
]

{ #category : #'*GToolkit-Extensions' }
GtPhlowActionNotProvidedError >> createExplanationWithCoderElement [
	| container |
	container := BrVerticalPane new
		matchParent.
				
	container addChild: (BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		text: self createExplanationText;
		margin: (BlInsets all: 10);
		hMatchParent;
		vFitContent).
				
	container addChild: self createAnnotatedCoderElement.
				
	container explainer isExplanationHolder: true.
	^ container
]

{ #category : #'*GToolkit-Extensions' }
GtPhlowActionNotProvidedError >> gtViewViewCodeWithExplanationFor: aView inContext: aPhlowContext [
	<gtView>
	<gtExceptionView>
	^ aView explicit
		title: 'View code';
		priority: 0;
		stencil: [ self createExplanationWithCoderElement ];
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: (GtMethodCoderTool compiledMethod: self actionMethod) ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect returned object'
			action: [ :aButton | aButton phlow spawnObject: self returnedObject ]
]
