Extension { #name : #IceLogVersion }

{ #category : #'*GToolkit-Extensions' }
IceLogVersion >> gtViewDiffWithInImageVersionFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff (with in-image version)';
		priority: 19;
		stencil: [ 
			| aCompiledMethod aLocalSource |
			
			aCompiledMethod := self definition  compiledMethod.
			
			aLocalSource := String streamContents: [ :stream | 
		stream 
				<< '"protocol: ' << aCompiledMethod protocolName << '"'; cr;
				<< aCompiledMethod sourceCode ].
		
		
			GtDiffElementWithLabelStencil new
				fromLabelText: 'Repository:';
				toLabelText: 'Working Copy (in-image version):';
				change: (GtDiffBuilder
					computeDifferencesFrom: self source
					to: aLocalSource
					using: GtSmaCCDiffSplitter forPharo);
				styler: GtPharoParser gtStyler ]
]
