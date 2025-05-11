Extension { #name : #BrEditorSearchTextContext }

{ #category : #'*GToolkit-Extensions' }
BrEditorSearchTextContext >> gtComputedPatternItemsFor: aView [
	<gtView>
	computedPatternItems ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Computed pattern items';
		items: [ computedPatternItems ifNil: [ #() ] ];
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
BrEditorSearchTextContext >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Associated element';
			value: self element.
		GtPhlowOverviewItem new
			name: 'Editor element';
			value: self editorElement.
		GtPhlowOverviewItem new
			name: 'Editor text';
			value: text.
		GtPhlowOverviewItem new
			name: 'Visible editor text';
			value: visibleText.
		GtPhlowOverviewItem new
			name: 'Pattern';
			value: self pattern.
		GtPhlowOverviewItem new
			name: 'Current index';
			value: self currentIndex.
		GtPhlowOverviewItem new
			name: 'Computed pattern items';
			value: self computedPatternItems.
		GtPhlowOverviewItem new
			name: 'Computed current pattern item';
			value: self computedCurrentPatternItem}
]

{ #category : #'*GToolkit-Extensions' }
BrEditorSearchTextContext >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Value' text: #description;
		send: #value
]
