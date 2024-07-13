Extension { #name : #OpalCompiler }

{ #category : #'*GToolkit-Extensions' }
OpalCompiler >> gtStreamStateFor: aView [
	<gtView>
	source ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source stream';
		priority: 15;
		object: [ source ];
		view: #gtStreamStateFor:
]
