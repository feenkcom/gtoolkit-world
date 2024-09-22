Extension { #name : #TAsyncSink }

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtCompositionChildren [
	^ #()
]

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('parentSink=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (parentSink printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtCompositionFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Composition';
		items: [ {self} ];
		children: #gtCompositionChildren;
		expandAll;
		column: 'Name' text: #gtCompositionDescription;
		actionUpdateButtonTooltip: 'Update composition tree'
]

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtParentSinks [
	^ Array streamContents: [ :aStream | 
		aStream nextPut: self.
		self gtParentSinksInto: aStream ]
]

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtParentSinksFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Parent sinks';
		priority: 60;
		items: [ self gtParentSinks ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Name' text: #gtCompositionDescription;
		actionUpdateButtonTooltip: 'Update parent sinks list'
]

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtParentSinksInto: aStream [
	parentSink ifNil: [ ^ self ].
	aStream nextPut: parentSink.
	parentSink isAsyncSink ifFalse: [ ^ self ].
	parentSink gtParentSinksInto: aStream
]
