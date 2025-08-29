Extension { #name : #BrCountdownGeometryAptitude }

{ #category : #'*GToolkit-Extensions' }
BrCountdownGeometryAptitude >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Animation';
			value: animation.
		GtPhlowOverviewItem new
			name: 'State';
			value: state.
		GtPhlowOverviewItem new
			name: 'Geometry stencil';
			value: geometryStencil.
		GtPhlowOverviewItem new
			name: 'Animation stencil builder';
			value: animationStencil.
		GtPhlowOverviewItem new
			name: 'On finished action';
			value: finishedAction.
		GtPhlowOverviewItem new
			name: 'Widget';
			value: widget}
]

{ #category : #'*GToolkit-Extensions' }
BrCountdownGeometryAptitude >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Value' text: #description;
		send: #value
]
