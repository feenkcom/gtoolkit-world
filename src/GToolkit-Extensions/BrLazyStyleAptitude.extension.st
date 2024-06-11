Extension { #name : #BrLazyStyleAptitude }

{ #category : #'*GToolkit-Extensions' }
BrLazyStyleAptitude >> gtStylesFor: aView [
	<gtView>
	^ aView forward
		title: 'Styles';
		object: [ styles ifNil: [ #() ] ];
		view: #gtStylesFor:
]
