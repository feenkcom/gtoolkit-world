Extension { #name : #SettingNode }

{ #category : #'*GToolkit-Extensions' }
SettingNode >> gtPragmaSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		object: [ pragma ];
		view: #gtSourceFor:
]
