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
String >> gtJSONFor: aView context: aContext [

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
String >> gtXMLFor: aView [
	<gtView>
	self ifEmpty: [ ^ aView empty ].
	((self at: 1) = $< or: [ (self at: 2) = $? ]) ifFalse: [ ^ aView empty ].

	^ aView textEditor
		title: 'XML';
		priority: 20;
		text: [ self ];
		styler: Gt4XMLStyler new;
		actionButtonIcon: BrGlamorousIcons tree
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
