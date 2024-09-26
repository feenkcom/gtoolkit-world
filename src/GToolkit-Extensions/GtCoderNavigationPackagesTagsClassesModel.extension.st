Extension { #name : #GtCoderNavigationPackagesTagsClassesModel }

{ #category : #'*GToolkit-Extensions' }
GtCoderNavigationPackagesTagsClassesModel >> gtCurrentStateFor: aView [
	<gtView>

	^ aView explicit
		title: 'Current state';
		priority: 1;
		actionUpdateButton;
		stencil: [
			| titleStencil listRowStencil packagesToShow classesToShow protocolsToShow methodsToShow |
			
			titleStencil := [
				BrLabel new
					hMatchParent;
					beSmallSize;
					margin: (BlInsets bottom: 5);
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ] asStencil.
			
			listRowStencil := [ BrLabel new
					hMatchParent;
					beSmallSize;
					aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude ] asStencil.
			
			packagesToShow := BrSimpleList new
				matchParent;
				itemStencil: listRowStencil;
				itemDataBinder: [ :eachLabel :eachPackage | 
					eachLabel text: eachPackage name ];
				items: self packagesToShow asArray.

			self selectedPackage ifNotNil: [ :aPackage |
				| aPackageIndex |
				
				aPackageIndex := packagesToShow items indexOf: aPackage.
				
				packagesToShow selectOne: aPackageIndex.
				packagesToShow scrollToIndex: aPackageIndex ].

			classesToShow := BrSimpleList new
				matchParent;
				itemStencil: listRowStencil;
				itemDataBinder: [ :eachLabel :eachClass | 
					eachLabel text: eachClass name ];
				items: (self classesToShow asArray sorted: #name asSortFunction).
				
			self selectedClass ifNotNil: [ :aClass |
				| aClassIndex |
				
				aClassIndex := classesToShow items indexOf: aClass.
				
				classesToShow selectOne: aClassIndex.
				classesToShow scrollToIndex: aClassIndex ].
				
			protocolsToShow := BrSimpleList new
				matchParent;
				itemStencil: listRowStencil;
				itemDataBinder: [ :eachLabel :eachProtocol | 
					eachLabel text: eachProtocol name ];
				items: (self protocolsToShow asArray sorted: #name asSortFunction).
				
			self selectedProtocol ifNotNil: [ :aProtocol |
				| aProtocolIndex |
				
				aProtocolIndex := protocolsToShow items indexOf: aProtocol.
				
				protocolsToShow selectOne: aProtocolIndex.
				protocolsToShow scrollToIndex: aProtocolIndex ].
				
			methodsToShow := BrSimpleList new
				matchParent;
				itemStencil: listRowStencil;
				itemDataBinder: [ :eachLabel :eachMethod | 
					eachLabel text: eachMethod selector ];
				items: (self methodsToShow asArray sorted: #selector asSortFunction).

			self selectedMethod ifNotNil: [ :aMethod |
				| aMethodIndex |
				
				aMethodIndex := methodsToShow items indexOf: aMethod.
				
				protocolsToShow selectOne: aMethodIndex.
				protocolsToShow scrollToIndex: aMethodIndex ].
			
			BrHorizontalPane new
				matchParent;
				preventMeAndChildrenMouseEvents;
				padding: (BlInsets all: 10);
				addChild: (BrVerticalPane new
					matchParent;
					addChild: (titleStencil asElement text: 'Packages to show');
					addChild: packagesToShow);
				addChild: (BrVerticalPane new
					matchParent;
					addChild: (titleStencil asElement text: 'Classes to show');
					addChild: classesToShow);
				addChild: (BrVerticalPane new
					matchParent;
					addChild: (titleStencil asElement text: 'Protocols to show');
					addChild: protocolsToShow);
				addChild: (BrVerticalPane new
					matchParent;
					addChild: (titleStencil asElement text: 'Methods to show');
					addChild: methodsToShow)
		]
]

{ #category : #'*GToolkit-Extensions' }
GtCoderNavigationPackagesTagsClassesModel >> gtLiveFor: aView [
	<gtView>
	coder ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 2;
		object: [ coder ];
		view: #gtLiveFor:
]
