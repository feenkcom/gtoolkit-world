Extension { #name : #BlSvgSAXParser }

{ #category : #'*GToolkit-Extensions' }
BlSvgSAXParser >> gtInstructionsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Instructions';
		stencil: [ (GtPharoSnippetCoder new
				forSource: self instructionString;
				subscribeToSystem;
				asExpandedOnlyElement) vFitContentLimited ]
]
