Extension { #name : #BrEditorSearchTextMarkerContext }

{ #category : #'*GToolkit-Extensions' }
BrEditorSearchTextMarkerContext >> gtComputedPatternItemsFor: aView [
	<gtView>
	patternItems ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Computed pattern items';
		items: [ patternItems ifNil: [ #() ] ];
		column: 'Index' text: [ :each :index | index gtDisplayString ];
		column: 'Is selected'
			text: [ :each | 
				each isSelected
					ifTrue: [ 'yes' ]
					ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ];
		column: 'From' text: #absoluteStartIndex;
		column: 'To' text: #absoluteStopIndex;
		column: 'Pattern' text: #subtext
]

{ #category : #'*GToolkit-Extensions' }
BrEditorSearchTextMarkerContext >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Associated element';
			value: self element.
		GtPhlowOverviewItem new
			name: 'Text source';
			value: self textSource.
		GtPhlowOverviewItem new
			name: 'Editor model text';
			value: self editorModelText.
		GtPhlowOverviewItem new
			name: 'Processed text';
			value: text.
		GtPhlowOverviewItem new
			name: 'Visible processed text';
			value: visibleText.
		GtPhlowOverviewItem new
			name: 'Pattern';
			value: self pattern.
		GtPhlowOverviewItem new
			name: 'Selected pattern index';
			value: self selectedIndex.
		GtPhlowOverviewItem new
			name: 'Computed pattern items';
			value: self patternItems.
		GtPhlowOverviewItem new
			name: 'Computed current pattern item';
			value: self selectedPatternItem}
]

{ #category : #'*GToolkit-Extensions' }
BrEditorSearchTextMarkerContext >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		priority: 1;
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Value' text: #description;
		send: #value
]
