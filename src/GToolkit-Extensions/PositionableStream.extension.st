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
	^ aView textEditor
		title: 'Contents';
		text: [ 
			| aText |
			aText := self contents asRopedText.
			(aText from: 1 to: self position) underlineColor: BrGlamorousColors errorBackgroundColor.
			aText ];
		actionUpdateButton
]
