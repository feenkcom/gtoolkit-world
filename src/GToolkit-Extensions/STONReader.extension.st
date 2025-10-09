Extension { #name : #STONReader }

{ #category : #'*GToolkit-Extensions' }
STONReader >> gtReadStreamContentsFor: aView [
	<gtView>
	^ aView forward
		title: 'Read stream contents';
		object: [ readStream ];
		view: #gtStreamStateFor:
]
