Extension { #name : #Rectangle }

{ #category : #'*GToolkit-Extensions' }
Rectangle >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Origin';
			value: self origin.
		GtPhlowOverviewItem new
			name: 'Corner';
			value: self corner.
		GtPhlowOverviewItem new
			name: 'Extent';
			value: self extent.
		GtPhlowOverviewItem new
			name: 'Height';
			value: self height.
		GtPhlowOverviewItem new
			name: 'Width';
			value: self width.
		GtPhlowOverviewItem new
			name: 'Left';
			value: self left.
		GtPhlowOverviewItem new
			name: 'Right';
			value: self right.
		GtPhlowOverviewItem new
			name: 'Top';
			value: self top.
		GtPhlowOverviewItem new
			name: 'Bottom';
			value: self bottom.
		GtPhlowOverviewItem new
			name: 'Center';
			value: self center.
		GtPhlowOverviewItem new
			name: 'Float center';
			value: self floatCenter.
		GtPhlowOverviewItem new
			name: 'Area';
			value: self area.
		GtPhlowOverviewItem new
			name: 'Half perimeter';
			value: self halfPerimeter.
		GtPhlowOverviewItem new
			name: 'Perimeter';
			value: self halfPerimeter * 2.
		GtPhlowOverviewItem new
			name: 'Ceiling';
			value: self ceiling.
		GtPhlowOverviewItem new
			name: 'Compressed';
			value: self compressed.
		GtPhlowOverviewItem new
			name: 'Expanded';
			value: self expanded.
		GtPhlowOverviewItem new
			name: 'Floor';
			value: self floor.
		GtPhlowOverviewItem new
			name: 'Rounded';
			value: self rounded.
		GtPhlowOverviewItem new
			name: 'Has positive extent';
			boolean: self hasPositiveExtent.
		GtPhlowOverviewItem new
			name: 'Is tall';
			boolean: self isTall.
		GtPhlowOverviewItem new
			name: 'Is wide';
			boolean: self isWide.
		GtPhlowOverviewItem new
			name: 'Is zero';
			value: self isZero.
		GtPhlowOverviewItem new
			name: 'Is integer rectangle';
			boolean: self isIntegerRectangle.
		GtPhlowOverviewItem new
			name: 'Corners';
			value: self corners.
		GtPhlowOverviewItem new
			name: 'Inner corners';
			value: self innerCorners}
]

{ #category : #'*GToolkit-Extensions' }
Rectangle >> gtOverviewFor: aView [
	<gtView>
	origin ifNil: [ ^ aView empty ].
	corner ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Overview';
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Value' text: #description weight: 3;
		send: #value
]
