Extension { #name : #String }

{ #category : #'*GToolkit-Extensions' }
String >> firstLineWithEllipsis [
	"If the receiver is multi-line, answer the first line with ellipsis appended, otherwise answer the receiver, removing any trailing newlines.
	Used, e.g. in labels where we don't want to attempt to display the entire multi-line string with ugly boxes."
	| firstLine |

	self linesDo: [ :line |
		firstLine
			ifNil: [ firstLine := line ]
			ifNotNil: [ ^ firstLine, '...' ] ].
	^ firstLine ifNil: [ self ]
]

{ #category : #'*GToolkit-Extensions' }
String >> gtGetUrlFor: aView [
	<gtView>
	self ifEmpty: [ ^ aView empty ].
	((self beginsWith: 'http://') or: [ self beginsWith: 'https://' ])
		ifFalse: [ ^ aView empty ].

	^ aView textEditor
		title: 'Get URL';
		priority: 19;
		text: [ ZnClient new get: self ];
		aptitude: BrGlamorousCodeEditorAptitude
]

{ #category : #'*GToolkit-Extensions' }
String >> gtItemsFor: aView [
	"override"

	^ aView columnedList
		title: 'Items';
		priority: 16;
		items: [ self ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Character'
			stencil: [ :each | 
				BrEditor new
					beReadOnlyWithoutSelection;
					preventMeAndChildrenMouseEvents;
					aptitude: BrGlamorousRegularEditorAptitude new;
					hMatchParent;
					padding: (BlInsets left: 5);
					vExact: 20;
					text: (each gtDisplayString gtRemovePrefix: 'Character ') ]
			width: 100;
		column: 'ASCII'
			text: [ :eachItem | eachItem asciiValue ]
			width: 100;
		column: 'UTF-8 code point'
			text: [ :eachItem | 
				[ eachItem unicodeCharacterData gtCodePointHexString ]
					on: NotFound
					do: [ 'N/A' ] ]
			width: 150;
		column: 'UTF-8 hex'
			text: [ :each | 
				String
					streamContents: [ :out | 
						each asString utf8Encoded
							do: [ :byte | 
								byte
									printOn: out
									base: 16
									nDigits: 2 ]
							separatedBy: [ out space ] ] ]
			width: 100;
		column: 'UTF-8 binary'
			text: [ :each | 
				[ each value unicodeCharacterData asTextWithUtf8EncodedBinary ]
					on: NotFound
					do: [ 'N/A' ] ]
]

{ #category : #'*GToolkit-Extensions' }
String >> gtJSONDataFor: aView context: aContext [

	<gtView>
	self ifEmpty: [ ^ aView empty ].
	((self at: 1) = $[ or: [ (self at: 1) = ${ ]) ifFalse: [ 
		^ aView empty ].

	aContext at: #gtTreeExpansionLevel ifAbsentPut: [ true ].

	^ aView forward
		  title: 'JSON data';
		  priority: 21;
		  object: [ 
			  [ STONJSON fromString: self ]
				  on: Error
				  do: [ :anException | 
					  OrderedDictionary new
						  at: 'error' put: anException;
						  at: 'description' put: 'Could not parse';
						  yourself ] ];
		  view: #gtTreeFor:context:
]

{ #category : #'*GToolkit-Extensions' }
String >> gtJSONFor: aView [

	<gtView>
	self ifEmpty: [ ^ aView empty ].
	((self at: 1) = $[ or: [ (self at: 1) = ${ ]) ifFalse: [ 
		^ aView empty ].

	^ aView textEditor
		  title: 'JSON';
		  priority: 20;
		  text: [ self ];
		  styler: JSONParser gtStyler;
		  aptitude: BrGlamorousCodeEditorAptitude
]

{ #category : #'*GToolkit-Extensions' }
String >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 15;
		stencil: [
		| container list editor |
		container := BlElement new
			constraintsDo: [:c | 
				c vertical matchParent. 
				c horizontal matchParent];
			margin: (BlInsets top: 10 bottom: 10);
			layout: (BlLinearLayout horizontal cellSpacing: 10).
		editor := BrEditorElement new
				constraintsDo: [ :c | 
					c vertical matchParent. 
					c horizontal matchParent.
					c linear weight: 4 ];
				editor: (BrTextEditorModel new
				text: (self asRopedText glamorousCodeFont);
				when: BrTextEditorCursorMovedEvent do: [:e | 
					list selectOne: (e newIndex max: 1).
					list children first scrollToPosition: (e newIndex max: 1) ];
				when: BrTextEditorCursorAddedEvent do: [:e | 
					list selectOne: (e cursor position max: 1).
					list children first scrollToPosition: (e cursor position max: 1) ]).
		container addChild: editor.
		
		list := BrColumnedList new
			rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new);
			constraintsDo: [:c | 
				c vertical matchParent. 
				c horizontal matchParent ];
			
			items: (self asOrderedCollection collectWithIndex: [ :char :index | char -> index ]);
			when: BrSelectionChanged do: [ :event | 
				event selectedInterval ifNotNil: [ 
					editor editor text clearAttributes: [ :each | each isKindOf: BlTextHighlightAttribute ].
					(editor editor text from: event selectedInterval first to: event selectedInterval last)
						attribute: (BlTextHighlightAttribute new paint: BrGlamorousColors textHighlightColor "result: (editor editor text at: event selectedInterval first)")] ].
		list column 
			title: 'Index';
			stencil: [ :assoc | BrColumnCellLabelStencil new text: (assoc value asString asRopedText glamorousRegularFont; foreground: Color gray; fontSize: 12)].
		list column 
			title: 'Char';
			stencil: [ :assoc | BrColumnCellLabelStencil new text: ((assoc key gtDisplayString gtRemovePrefix: 'Character ') asRopedText glamorousRegularFont; fontSize: 12)].
		list column 
			title: 'ASCII';
			stencil: [ :assoc | BrColumnCellLabelStencil new text: ((assoc key asciiValue asString) asRopedText glamorousRegularFont; fontSize: 12)].
		container addChild: list.
		
		container 
		]
]

{ #category : #'*GToolkit-Extensions' }
String >> gtStreamStateFor: aView [
	^ self gtStringFor: aView
]

{ #category : #'*GToolkit-Extensions' }
String >> gtTreeFor: aView context: aContext [
	"override"
	^ aView empty
]

{ #category : #'*GToolkit-Extensions' }
String >> gtWebpageFor: aView [
	<gtView>
	self ifEmpty: [ ^ aView empty ].
	((self beginsWith: 'http://') or: [ self beginsWith: 'https://' ])
		ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Webpage';
		priority: 20;
		object: [ self asZnUrl ];
		view: #gtWebpageFor:
]

{ #category : #'*GToolkit-Extensions' }
String >> gtXMLFor: aView [
	<gtView>
	self ifEmpty: [ ^ aView empty ].
	self size > 1 ifFalse: [ ^ aView empty ].
	((self at: 1) = $< or: [ (self at: 2) = $? ]) ifFalse: [ ^ aView empty ].

	^ aView textEditor
		title: 'XML';
		priority: 20;
		text: [ self ];
		styler: Gt4XMLStyler new;
		actionButtonIcon: BrGlamorousVectorIcons tree
			action: [ :aButton | aButton phlow spawnObject: (XMLDOMParser parse: self) ];
		aptitude: BrGlamorousCodeEditorAptitude;
		actionDropdownButtonIcon: nil
			label: 'XPath'
			content: [ :b | 
				| editor |
				editor := BrEditor new aptitude: BrGlamorousCodeEditorAptitude.
				BlElement new
					constraintsDo: [ :c | 
						c horizontal exact: 200.
						c vertical fitContent ];
					layout: BlLinearLayout horizontal;
					padding: (BlInsets all: 10);
					addChild: editor;
					addChild: (BrButton new
							aptitude: BrGlamorousButtonWithIconAptitude;
							icon: BrGlamorousVectorIcons search;
							label: 'Search with XPath';
							action: [ b phlow
									spawnObject: ((XMLDOMParser parse: self) xpath: editor editor text asString) ]) ]
]

{ #category : #'*Gtoolkit-Extensions' }
String class >> password: aPasswordString [
	"Mark aPasswordString as sensitive data that should be hidden
	by the Pharo styler addOn GtPharoMethodPasswordStyler"
	
	<gtMethodPassword>
	^ aPasswordString
]
