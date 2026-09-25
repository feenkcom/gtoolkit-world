Extension { #name : #SettingTree }

{ #category : #'*GToolkit-Extensions' }
SettingTree class >> gtNodeListFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'Settings';
		object: [ SettingTree new acceptableKeywords: SettingBrowser settingsKeywords ];
		view: #gtNodeListFor:
]

{ #category : #'*GToolkit-Extensions' }
SettingTree >> gtNodeListFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Settings';
		items: [ self settingTreeRoots ];
		children: [ :aNode | aNode contents ];
		column: 'Name'
			text: [ :aNode | 
				| aText |
				aText := aNode settingDeclaration label asRopedText.

				aNode settingDeclaration hasValue
					ifTrue: [ aText
							appendString: ': ';
							append: aNode realValue gtDisplayText italic ].

				aText ];
		column: 'Description' text: [ :aNode | aNode description ]
]
