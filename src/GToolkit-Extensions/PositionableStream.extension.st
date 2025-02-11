Extension { #name : #PositionableStream }

{ #category : #'*GToolkit-Extensions' }
PositionableStream >> gtStreamStateByteArrayFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	(collection isKindOf: ByteArray) ifFalse: [ ^ aView empty ].
	
	^ aView textEditor
		title: 'Bytes';
		glamorousMonospace;
		text: [ 
			| aMaxBytes aDisplayStream aDisplayRopeText aShiftOne aShiftTwo aLineSize |
			aMaxBytes := 10000.
			aDisplayStream := (String new: aMaxBytes * 5) writeStream.
			collection hexDumpOn: aDisplayStream max: aMaxBytes.
			aDisplayRopeText := aDisplayStream contents asString asRopedText .
			
			aShiftOne := 11.
			aShiftTwo := 62.
			aLineSize := 79.
			1 to: self position by: 1 do: [ :anIndex | 
				| aLine aStartOne aStartTwo |
				aLine := anIndex - 1 // 16.
				aStartOne := aShiftOne + (aLine * aLineSize) + (anIndex - 1 \\ 16 * 3).
				aStartTwo := aShiftTwo + (aLine * aLineSize) + (anIndex - 1 \\ 16).
				
				(aDisplayRopeText 
					from: aStartOne
					to: aStartOne + 1)
					underlineColor: BrGlamorousColors errorBackgroundColor.
				
				(aDisplayRopeText 
					from: aStartTwo
					to: aStartTwo) 
					underlineColor: BrGlamorousColors errorBackgroundColor.
					
			].
			aDisplayRopeText ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
PositionableStream >> gtStreamStateFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Contents';
		priority: 15;
		stencil: [ | container list editor contents text |
			container := BrHorizontalPane new
					matchParent;
					margin: (BlInsets top: 10 bottom: 10);
					cellSpacing: 10.
			contents := self contents.
			text := contents asRopedText glamorousCodeFont.
			(text from: 1 to: self position)
				highlight: BrGlamorousColors textHighlightColor.
			editor := BrEditor new
					matchParent;
					constraintsDo: [ :c | c linear weight: 4 ];
					editor: (BrTextEditorModel new
							text: text;
							when: BrTextEditorCursorMovedEvent
								do: [ :e | 
									list selectOne: (e newIndex max: 1).
									list children first scrollToPosition: (e newIndex max: 1) ];
							when: BrTextEditorCursorAddedEvent
								do: [ :e | 
									list selectOne: (e cursor position max: 1).
									list children first scrollToPosition: (e cursor position max: 1) ]).
			container addChild: editor.

			list := BrColumnedList new
					rowStencil: BrGlamorousColumnedListSelectableRowElementStencilBuilder new;
					matchParent;
					items: (contents asOrderedCollection collectWithIndex: [ :char :index | char -> index ]);
					when: BrSelectionChanged
						do: [ :event | 
							event selectedInterval
								ifNotNil: [ editor editor text
										clearAttributes: [ :each | each isKindOf: GtPlaygroundEvaluatedCodeButtonAttribute ].
									(editor editor text
										from: event selectedInterval first
										to: event selectedInterval last)
										attribute: (GtPlaygroundEvaluatedCodeButtonAttribute new beAppend
												result: (editor editor text at: event selectedInterval first))	"(editor scrollToPosition: event selectedInterval first)." ] ].
			list column
				title: 'Index';
				stencil: [ :assoc | 
					| cellLabel |
					cellLabel := BrColumnCellLabelStencil new
						text: (assoc value asString asRopedText
								glamorousRegularFont;
								foreground: Color gray;
								glamorousRegularSmallSize);
						asElement.
					assoc value <= self position ifTrue: [ cellLabel background: BrGlamorousColors textHighlightColor ].
					cellLabel ].
			list column
				title: 'Char';
				stencil: [ :assoc | 
					BrColumnCellLabelStencil new
						text: ((assoc key printString gtRemovePrefix: 'Character ') asRopedText
								glamorousRegularFont;
								glamorousRegularSmallSize) ].
			list column
				title: 'ASCII';
				stencil: [ :assoc | 
					BrColumnCellLabelStencil new
						text: (([assoc key asciiValue] on: Error do: [ '' ]) asString asRopedText
								glamorousRegularFont;
								glamorousRegularSmallSize) ].
			container addChild: list.

			container ]
]
