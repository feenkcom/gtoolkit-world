Trait {
	#name : #TGtWorldWithTabModelWithSpace,
	#instVars : [
		'tabModelWithSpace'
	],
	#category : #'GToolkit-WorldPreviewer-Model'
}

{ #category : #accessing }
TGtWorldWithTabModelWithSpace >> tabModelWithSpace [
	"Get a BrTabModel with a space as a model"

	<return: #BrTabModel>
	^ tabModelWithSpace
]

{ #category : #accessing }
TGtWorldWithTabModelWithSpace >> tabModelWithSpace: aTabSpace [
	"Set a BrTabModel with a space as a model"

	self assert: [ aTabSpace isKindOf: BrTabModel ].
	self assert: [ aTabSpace model isKindOf: BlSpace ].

	tabModelWithSpace := aTabSpace
]
