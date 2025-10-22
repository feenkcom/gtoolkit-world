Extension { #name : #Breakpoint }

{ #category : #'*GToolkit-Extensions' }
Breakpoint class >> gtAllBreakpointsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Breakpoints';
		items: [ self all ];
		column: 'Node'
			text: [ :aBreakpoint | aBreakpoint node ];
		column: 'Is enabled'
			text: [ :aBreakpoint | (GtPhlowOverviewItem new boolean: aBreakpoint isEnabled) description ]
			width: 100
]
