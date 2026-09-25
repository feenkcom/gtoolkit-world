Extension { #name : #LePage }

{ #category : #'*GToolkit-Extensions' }
LePage >> gtLePageGitButtonFor: anAction [
	<gtAction>
	
	self database monitor ifNil: [ ^ anAction noAction ].
	(self database monitor isLocalStore not or: [ self icebergRepo isNil ]) ifTrue: 
		[ ^ anAction empty ].
	^ anAction button
		tooltip: 'Go to repository';
		priority: 72;
		icon: BrGlamorousVectorIcons branching;
		id: GtCoderGitButtonId;
		action: [ :aButton | 
			aButton phlow
				spawnTool: (GtGitPhlowTool new
						repository: (GtGitRepository fromIcebergRepository: self icebergRepo)) ]
]

{ #category : #'*GToolkit-Extensions' }
LePage >> icebergRepo [
	^ IceRepository registry
		detect: [ :repo | 
			repo location
				ifNil: [ false ]
				ifNotNil: [ self pageFileReference 
					ifNil: [ false ]
					ifNotNil: [:aPageReference | repo location contains: aPageReference ] ] ]
		ifNone: [ nil ]
]
