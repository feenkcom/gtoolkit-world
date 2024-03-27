Extension { #name : #ExceptionSignal }

{ #category : #'*GToolkit-Extensions' }
ExceptionSignal >> gtInspectorStackIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite fastTable
		title: 'Stack';
		display: [ self stack ];
		column: 'Class' text: [:each | each parents first methodClass ];
		column: 'Method' text: [:each | each parents first selector];
		column: 'Code' text: [:each | each formattedCode]
]
