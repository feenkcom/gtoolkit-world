Extension { #name : #Breakpoint }

{ #category : #'*GToolkit-Extensions' }
Breakpoint class >> gtAllBreakpointsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedTree
		title: 'Breakpoints';
		items: [ self all ];
		actionCollapseAndExpandButtons;
		children: [ :anObject | 
			(anObject isKindOf: Breakpoint)
				ifTrue: [ anObject link ifNotNil: [ :aLink | aLink methods ] ifNil: [ #() ] ]
				ifFalse: [ (anObject isKindOf: CompiledMethod)
						ifTrue: [ Array
								streamContents: [ :aStream | 
									anObject ast
										nodesDo: [ :eachNode | eachNode hasBreakpoint ifTrue: [ aStream nextPut: eachNode ] ] ] ]
						ifFalse: [ #() ] ] ];
		column: 'Name'
			text: [ :anObject | 
				(anObject isKindOf: Breakpoint)
					ifTrue: [ '{1}: {2}'
							format: {anObject targetInstance
										ifNil: [ anObject condition
												ifNil: [ 'Breakpoint' ]
												ifNotNil: [ 'Condition breakpoint' ] ]
										ifNotNil: [ 'Object breakpoint' ].
									anObject node} ]
					ifFalse: [ (anObject isKindOf: CompiledMethod)
							ifTrue: [ 'Method: {1} >> #{2}'
									format: {anObject methodClass.
											anObject selector} ]
							ifFalse: [ 'Node: {1}' format: {anObject} ] ] ];
		column: 'Methods'
			text: [ :anObject | 
				(anObject isKindOf: Breakpoint)
					ifTrue: [ anObject link ifNotNil: [ :aLink | aLink methods size ] ifNil: [ '' ] ]
					ifFalse: [ '' ] ]
			width: 80;
		column: 'Is enabled'
			text: [ :anObject | 
				(anObject isKindOf: Breakpoint)
					ifTrue: [ (GtPhlowOverviewItem new boolean: anObject isEnabled) description ]
					ifFalse: [ '' ] ]
			width: 80;
		contextItemLabel: 'Remove breakpoint'
			action: [ :anElement :aTreeNode | 
				aTreeNode value remove.
				anElement phlow fireViewUpdateWish ]
			if: [ :aTreeNode | aTreeNode value isKindOf: Breakpoint ];
		contextItemLabel: 'Inspect target instance'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value targetInstance ]
			if: [ :aTreeNode | 
				(aTreeNode value isKindOf: Breakpoint)
					and: [ aTreeNode value targetInstance isNotNil ] ];
		contextItemLabel: 'Inspect condition'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value condition ]
			if: [ :aTreeNode | 
				(aTreeNode value isKindOf: Breakpoint)
					and: [ aTreeNode value condition isNotNil ] ];
		contextItemLabel: 'Inspect original method'
			action: [ :anElement :aTreeNode | 
				anElement phlow
					spawnObject: (aTreeNode value methodClass superclass
							compiledMethodAt: aTreeNode value selector) ]
			if: [ :aTreeNode | 
				(aTreeNode value isKindOf: CompiledMethod)
					and: [ aTreeNode value methodClass isAnonymous ] ]
]
