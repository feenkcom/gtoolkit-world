Extension { #name : #BrStyleAptitude }

{ #category : #'*GToolkit-Extensions' }
BrStyleAptitude >> gtStylesFor: aView [
	<gtView>
	^ aView forward
		title: 'Styles';
		object: [ styles ifNil: [ #() ] ];
		view: #gtStylesFor:
]
