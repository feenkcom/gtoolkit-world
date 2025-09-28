Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Extensions' }
AbstractFileReference >> contentsUtf8Lossy [
	"Answer the receiver's contents assuming UTF-8 encoding, but allowing for invalid characters	(substituting in the unicode replacement character)"
	| stream |

	^ [ (stream := self readStreamEncoded: #utf8lossy) contents ]
		ensure: [ stream close ]
]

{ #category : #'*GToolkit-Extensions' }
AbstractFileReference >> gtLepiterDuplicateJsonFor: aView [
	<gtView>
	(self isFile and: [ self extension = 'duplicate' ]) ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'Lepiter duplicate';
		priority: 1;
		actionButtonIcon: BrGlamorousVectorIcons tree
			label: 'JSON'
			tooltip: 'Parse with a JSON parse'
			action: [ :aButton | aButton phlow spawnObject: (STONJSON fromString: self contents) ];
		actionButtonIcon: BrGlamorousVectorIcons tree
			label: 'Lepiter'
			tooltip: 'Parse with a Lepiter parser'
			action: [ :aButton | 
				aButton phlow
					spawnObject: (self
							readStreamEncoded: #utf8
							do: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ]) ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ STONJSON toStringPretty: (STONJSON fromString: self contents) ]
]

{ #category : #'*GToolkit-Extensions' }
AbstractFileReference >> gtStyledCodeFor: aView [
	<gtView>
	| parser styler |
	(self isFile
		and: [ (parser := SmaCCParser allSubclasses
					detect: [ :each | each fileExtensions includes: '.' , self extension ]
					ifNone: [  ]) notNil and: [ (styler := parser gtStyler) notNil ] ])
		ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Code';
		priority: 10;
		stencil: [ | pane |
			pane := self gtEditorView.
			pane
				childNamed: #editor
				ifFound: [ :editor | 
					editor aptitude: BrGlamorousCodeEditorAptitude.
					editor editor styler: styler ].
			pane ];
		actionDropdownButtonIcon: BrGlamorousVectorIcons hamburger
			content: [ :aButton :aBrTab | 
				| parsers menuItems |
				parsers := SmaCCParser allSubclasses
						select: [ :each | each fileExtensions includes: '.' , self extension ].
				menuItems := parsers
						collect: [ :each | 
							('Parse with ' , each name)
								-> [ :anElement | aButton phlow spawnObject: (self smaCCParseUsing: each) ] ].

				BrGlamorousSimpleContextMenuContent new
					items: menuItems;
					hMatchParent;
					vMatchParent ]
]
