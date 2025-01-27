Extension { #name : #BrMenuModel }

{ #category : #'*GToolkit-Extensions' }
BrMenuModel >> gtItemLabel [
	^ self gtDisplayString
]

{ #category : #'*GToolkit-Extensions' }
BrMenuModel >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [
			BrFrame new 
				matchParent;
				addChild: (BrFrame new
					matchParent;
					clipChildren: false;
					margin: (BlInsets all: 20);
					addChild: (BrMenuSteppedElement new
						elementBuilder: BrGlamorousMenuElementBuilder new;
						addAptitude: BrMenuContainerAptitude new;
						menuModel: self)) ]
]

{ #category : #'*GToolkit-Extensions' }
BrMenuModel >> gtParentsFor: aView [
	<gtView>
	self parent ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Parents';
		items: [ Array streamContents: [ :aStream | 
			self parentsDo: [ :aParent | aStream nextPut: aParent ] ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Parent' text: #gtItemLabel
]
