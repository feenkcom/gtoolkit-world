Extension { #name : #FileReference }

{ #category : #'*GToolkit-Extensions' }
FileReference >> gtOpenWebBrowserActionFor: anAction [
	<gtAction>
	(self isDirectory and: [ (self filesMatching: 'index.html;index.htm') size isZero not ])
		ifFalse: [ ^ anAction noAction ].

	^ anAction button
		tooltip: 'Open in web browser';
		icon: BrGlamorousVectorIcons link;
		action: [ :aButton :aTab | 
			| someFiles |
			someFiles := self filesMatching: 'index.html;index.htm'.
			someFiles ifNotEmpty: [ 
				WebBrowser openOn: someFiles anyOne asZnUrl ] ]
]
