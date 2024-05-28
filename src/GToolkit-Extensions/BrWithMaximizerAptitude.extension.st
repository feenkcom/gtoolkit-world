Extension { #name : #BrWithMaximizerAptitude }

{ #category : #'*GToolkit-Extensions' }
BrWithMaximizerAptitude >> gtOverview [
	^ {
		GtPhlowOverviewItem new
			name: 'Is maximized';
			value: self isMaximized.
		GtPhlowOverviewItem new
			name: 'Query';
			value: targetQuery.
		GtPhlowOverviewItem new
			name: 'Element to maximize';
			secureValue: [ self elementToMaximize ].
		GtPhlowOverviewItem new
			name: 'Possible hosts';
			secureValue: [ self findAllPossibleHostsFor: self elementToMaximize ];
			ifComputedValueDescription: [ :aCollection | 
				'{1} {2}' format: { aCollection size. 'item' asPluralBasedOn: aCollection size } ]
	}
]

{ #category : #'*GToolkit-Extensions' }
BrWithMaximizerAptitude >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Value' text: #description weight: 2;
		send: #value
]

{ #category : #'*GToolkit-Extensions' }
BrWithMaximizerAptitude >> gtPossibleHostsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Possible hosts';
		items: [ | aCollection |
			self
				widgetDo: [ :theWidget | aCollection := self findAllPossibleHostsFor: self elementToMaximize ].
			aCollection ifNil: [ #() ] ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Parent' text: #yourself
]
