Class {
	#name : #GtWorldByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples + TGtScripterDebuggerExamples',
	#classTraits : 'TBlDevScripterExamples classTrait + TGtScripterDebuggerExamples classTrait',
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> addCoderIntoTabElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self tabElementInScripter.
	aScripter
		substep: 'Add Coder as a World tab'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Show Coder space';
						block: [ :aTabElement | 
							| aStencil |
							aStencil := self coderStencil.
							BlSpace new
								icon: aStencil icon;
								title: aStencil name;
								addChild: aStencil asElement;
								showFrom: aTabElement ] ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Coder in a new tab';
						value: [ :anElement | anElement tabs tabs size ] equals: 2 ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Coder tab label';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: 'Coder' ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Coder tab selection';
						satisfies: [ :anElement | anElement tabs tabs second isSelected ]
							description: [ 'Coder tab must be selected' ] ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPage50OfDatabaseWithManyPagesOfDifferentCreateTimesIntoTabElementMaximized [
	"Issue https://github.com/feenkcom/gtoolkit/issues/3859"

	<gtExample>
	<return: #BlScripter>
	| aScripter aPageHolder aPage |
	aScripter := self tabElementInScripter.
	aPageHolder := LeModelExamples new
			page50OfDatabaseWithManyPagesOfDifferentCreateTimes.
	aPage := aPageHolder page.
	aScripter model: aPageHolder.

	aScripter memoryLogger
		runFor: LeDatabaseSidebarGroupedListUpdateSelectionSignal
				, LeDatabaseSidebarGroupedListScrolledToIndexSignal
				, LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal
		during: [ :aStep | 
			self
				addLepiterPage: aPageHolder page
				intoTabElementUsingScripter: aStep
				maximized: true ].

	aScripter
		substeps: 'Assert sidebar'
		do: [ :aStep | 
			aStep assert
				label: 'Assert page is visible';
				exists;
				// LeDatabaseSidebarGroupedListElement;
				// LePageTitleAndSummaryElement;
				@ [ :anElement | anElement pageViewModel pageModel == aPage ];
				play.

			aStep assert
				label: 'Assert selected page';
				satisfies: [ :aGroupedList | 
						| aSelection |
						aSelection := aGroupedList selectedItems.
						aSelection size = 1 and: [ aSelection first == aPage ] ]
					description: [ '{1} must be selected' format: {aPage title} ];
				// LeDatabaseSidebarGroupedListElement;
				// BrGroupedList;
				play ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPage50OfDatabaseWithManyPagesOfDifferentCreateTimesIntoTabElementMinimized [
	"Issue https://github.com/feenkcom/gtoolkit/issues/3859"

	<gtExample>
	<return: #BlScripter>
	| aScripter aPageHolder aPage |
	aScripter := self tabElementInScripter.
	aPageHolder := LeModelExamples new
			page50OfDatabaseWithManyPagesOfDifferentCreateTimes.
	aPage := aPageHolder page.
	aScripter model: aPageHolder.

	aScripter memoryLogger
		runFor: LeDatabaseSidebarGroupedListUpdateSelectionSignal
				, LeDatabaseSidebarGroupedListScrolledToIndexSignal
				, LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal
		during: [ :aStep | 
			self
				addLepiterPage: aPageHolder page
				intoTabElementUsingScripter: aStep
				maximized: false ].

	aScripter
		substeps: 'Assert sidebar'
		do: [ :aStep | 
			aStep assert
				label: 'Assert page is visible';
				notExists;
				// LeDatabaseSidebarGroupedListElement;
				// LePageTitleAndSummaryElement;
				@ [ :anElement | anElement pageViewModel pageModel == aPage ];
				play ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPage: aLePage intoTabElementUsingScripter: aScripter maximized: isMaximized [
	<gtExample>
	aScripter
		substep: 'Add lepiter page into a World tab'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Show lepiter page space';
						block: [ :aTabElement | 
							| aTool aPageElement aPager |
							aTool := aLePage asLepiterPagePhlowTool.
							aPageElement := aTool asElementDo: [ :anElement | anElement ].
							aPager := GtPagerSettings usedPager createWrappedOn: aPageElement.
							isMaximized ifTrue: [ aPager maximized ].
							BlSpace new
								icon: aTool icon;
								title: aLePage title;
								addChild: aPager;
								showFrom: aTabElement ] ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check lepiter in a new tab';
						value: [ :anElement | anElement tabs size ] equals: 2;
						// GtWorldTabGroupId ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check lepiter tab label';
						value: [ :anElement | anElement tabs second widget label asString ]
							equals: [ aLePage title asString ];
						// GtWorldTabGroupId ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check lepiter tab selection';
						satisfies: [ :anElement | anElement tabs second isSelected ]
							description: [ 'Lepiter tab must be selected' ];
						// GtWorldTabGroupId ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageHavingPharoSnippetWithNonExistentClassAndMethod [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPageHolder |
	aScripter := self tabElementInScripter.
	aPageHolder := LeModelExamples new
			pageOneHavingPharoSnippetWithNonExistentClassAndMethod.
	aScripter model: aPageHolder.
	self
		addLepiterPage: aPageHolder page
		intoTabElementUsingScripter: aScripter
		maximized: false.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageHavingPharoSnippetWithNonExistentClassAndMethod2 [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPageHolder |
	aScripter := self tabElementInScripter.
	aPageHolder := LeModelExamples new
			pageOneHavingPharoSnippetWithNonExistentClassAndMethod2.
	aScripter model: aPageHolder.
	self
		addLepiterPage: aPageHolder page
		intoTabElementUsingScripter: aScripter
		maximized: false.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageHavingThisSnippetPharoSnippet [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPageHolder |
	aScripter := self tabElementInScripter.
	aPageHolder := LeModelExamples new pageOneWithThisSnippetPharoSnippet.
	aScripter model: aPageHolder.

	self
		addLepiterPage: aPageHolder page
		intoTabElementUsingScripter: aScripter
		maximized: false.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageHavingThisSnippetPharoSnippet_inspectThisSnippet [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self addLepiterPageHavingThisSnippetPharoSnippet.

	aScripter click
		// GtSourceCoderDoItAndGoActionId;
		play.

	aScripter assert
		label: 'Assert there is not a "did not understand" button';
		notExists;
		// BrButton;
		@ [ :eachButton | eachButton label asString includesSubstring: 'did not understand' ];
		play.

	aScripter assert
		label: 'Assert there are two panes with "Pane one" editor';
		exists;
		onPagerPaneWithIndex: 2;
		// GtInspector;
		play.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageHavingWardleyMapSnippet [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPageHolder |
	aScripter := self tabElementInScripter.
	aPageHolder := LeModelExamples new pageOneHavingWardleyMapSnippets.
	aScripter model: aPageHolder.

	self
		addLepiterPage: aPageHolder page
		intoTabElementUsingScripter: aScripter
		maximized: false.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageHavingWardleyMapSnippet_addNodeToPageExplicitLink [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPageOne aPageTwo |
	aScripter := self addLepiterPageHavingWardleyMapSnippet.
	aPageOne := aScripter model page.
	aPageTwo := aPageOne database pageNamed: LeModelExamples new pageTwoTitle.

	aScripter
		substeps: 'Add node-to-page link'
		do: [ :aStep | 
			aStep do
				label: 'Store explicit links count';
				block: [ :theScripter | 
					theScripter userData
						at: #initialExplicitLinks
						put: theScripter model database explicitLinks size ];
				onScripter;
				play.

			aStep secondaryClick
				label: 'Open Node A dropdown';
				// (#node asBlocElementId indexed: 0);
				play.

			aStep doubleClick
				label: 'Enter page link edit mode';
				onSpaceRoot;
				// (GtWardleyMapContextMenuItemId
						definingMethod: GtWardleyMapNodeModel >> #menuItemNodeToLepiterPageLinker);
				play.

			aStep click
				label: 'Extra click to get page link editor focus due to a bug';
				onSpaceRoot;
				// (GtWardleyMapContextMenuItemId
						definingMethod: GtWardleyMapNodeModel >> #menuItemNodeToLepiterPageLinker);
				play.

			aStep type
				label: 'Type page title';
				text: aPageTwo title;
				play.

			aStep keyPress
				label: 'Accept page title';
				key: BlKeyboardKey return;
				play.

			aStep do
				label: 'Store explicit links count';
				block: [ :theScripter | 
					theScripter userData
						at: #afterExplicitLinks
						put: theScripter model database explicitLinks size ];
				onScripter;
				play.

			aStep assert
				label: 'Assert an extra explicit link';
				value: [ :theScripter | theScripter userData at: #afterExplicitLinks ]
					equals: [ :theScripter | (theScripter userData at: #initialExplicitLinks) + 1 ];
				onScripter;
				play ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageHavingWardleyMapSnippet_addNodeToPageExplicitLink_deleteNode [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPageOne aPageTwo |
	aScripter := self
			addLepiterPageHavingWardleyMapSnippet_addNodeToPageExplicitLink.
	aPageOne := aScripter model page.
	aPageTwo := aPageOne database pageNamed: LeModelExamples new pageTwoTitle.

	aScripter
		substeps: 'Delete Node A'
		do: [ :aStep | 
			aStep secondaryClick
				label: 'Open Node A dropdown';
				// (#node asBlocElementId indexed: 0);
				play.

			aStep click
				label: 'Click on delete node button';
				onSpaceRoot;
				// (GtWardleyMapContextMenuItemId
						definingMethod: GtWardleyMapNodeModel >> #menuItemNodeDeleteButton);
				play.

			aStep do
				label: 'Store explicit links count';
				block: [ :theScripter | 
					theScripter userData
						at: #afterDeleteExplicitLinks
						put: theScripter model database explicitLinks size ];
				onScripter;
				play.

			aStep assert
				label: 'Assert deleted explicit link';
				value: [ :theScripter | theScripter userData at: #afterDeleteExplicitLinks ]
					equals: [ :theScripter | theScripter userData at: #initialExplicitLinks ];
				onScripter;
				play ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageWithChangeAndDependentSnippets [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPageHolder |
	aScripter := self tabElementInScripter.
	aPageHolder := LeModelExamples new pageHavingChangeAndDependentSnippets.
	aScripter model: aPageHolder.
	self
		addLepiterPage: aPageHolder page
		intoTabElementUsingScripter: aScripter
		maximized: false.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> addLepiterPageWithPharoSnippetIntoTabElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPageHolder |
	aScripter := self tabElementInScripter.
	aPageHolder := LeModelExamples new pageOneWithOnePharoSnippet.
	aScripter model: aPageHolder.
	self
		addLepiterPage: aPageHolder page
		intoTabElementUsingScripter: aScripter
		maximized: false.

	^ aScripter
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> addPlaygroundIntoTabElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self tabElementInScripter.

	aScripter
		substep: 'Add Playground into a World tab'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Show Playground space';
						block: [ :aTabElement | 
							| aStencil |
							aStencil := self playgroundStencil.
							BlSpace new
								icon: aStencil icon;
								title: aStencil name;
								addChild: aStencil asElement;
								showFrom: aTabElement ] ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Playground in a new tab';
						value: [ :anElement | anElement tabs tabs size ] equals: 2 ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Playground tab label';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: 'Playground' ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Playground tab selection';
						satisfies: [ :anElement | anElement tabs tabs second isSelected ]
							description: [ 'Playground tab must be selected' ] ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> applyEpiceaSnippetChanges [
	<gtExample>
	<return: #BlScripter>
	| aScripter aCreateClassId aClassLinkId aCreateMethodId aMethodLinkId anExampleId |
	self removeOnDemandDummyClass.

	aScripter := self addLepiterPageWithChangeAndDependentSnippets.
	aCreateClassId := aScripter model page children first uid.
	aClassLinkId := aScripter model page children second uid.
	aCreateMethodId := aScripter model page children third uid.
	aMethodLinkId := aScripter model page children fourth uid.
	anExampleId := aScripter model page children fifth uid.

	aScripter do
		label: 'Set space size';
		block: [ :aSpace | aSpace extent: 1200 @ 1200 ];
		onSpace;
		play.

	aScripter click
		label: 'Create class';
		// (LeSnippetId new uid: aCreateClassId);
		// GtEpiceaApplyChangesId;
		play.

	aScripter assert
		label: 'Assert LeOnDemandDummyClass exists';
		satisfies: [ Smalltalk
					at: #LeOnDemandDummyClass
					ifPresent: [ :aClass | true ]
					ifAbsent: [ false ] ]
			description: [ 'LeOnDemandDummyClass does not exist' ];
		play.

	aScripter assert
		label: 'Assert LeOnDemandDummyClass link is clickable';
		exists;
		// (LeSnippetId new uid: aClassLinkId);
		// GtSourceCoderEditorId;
		// (LeTextSnippetAttributeLabelElementId indexed: 1);
		play.

	aScripter click
		label: 'Create method';
		// (LeSnippetId new uid: aCreateMethodId);
		// GtEpiceaApplyChangesId;
		play.

	aScripter assert
		label: 'Assert LeOnDemandDummyClass >> #example exists';
		satisfies: [ Smalltalk
					at: #LeOnDemandDummyClass
					ifPresent: [ :aClass | 
						aClass methodDict
							at: #example
							ifPresent: [ :aMethod | true ]
							ifAbsent: [ false ] ]
					ifAbsent: [ false ] ]
			description: [ 'LeOnDemandDummyClass >> #example does not exist' ];
		play.

	aScripter assert
		label: 'Assert example method link is clickable';
		exists;
		// (LeSnippetId new uid: aMethodLinkId);
		// GtSourceCoderEditorId;
		// (LeTextSnippetAttributeLabelElementId indexed: 1);
		play.

	aScripter assert
		label: 'Assert example includes preview';
		exists;
		// (LeSnippetId new uid: anExampleId);
		// GtPhlowCompositeViewElementId;
		play.

	^ aScripter
]

{ #category : #assertions }
GtWorldByScripterExamples >> assertNoSemanticErrorAndThreePanesForPharo12In: aStep [
	aStep
		assertStep: [ :s | 
			s
				label: 'Assert three panes';
				value: [ :aPager | aPager pages size ] equals: 3;
				onPager ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert no error content dropdown';
				value: [ :aRoot | 
						| aQuery |
						aQuery := aRoot query // GtSourceCoderErrorContentElementId.
						aQuery result size ]
					equals: 0;
				onSpaceRoot ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert fix it attribute in the second pane';
				satisfies: [ :anEditor | (anEditor text attributesAt: 53) anySatisfy: [ :a | a class = GtFixItAttribute ] ];
				onPagerPaneWithIndex: 2;
				// GtSourceCoderEditorId ].

	aStep
		clickStep: [ :s | 
			s
				label: 'Click to navigate to the first pane';
				onPager;
				// GtTreePagerPaneScrollPreviewElement;
				@ 1 ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert fix it attribute in the first pane';
				satisfies: [ :anEditor | 
					anEditor text attributesFinder
						hasAttributeSuchThat: [ :anAttribute | anAttribute class = GtFixItAttribute ] ];
				onPagerPaneWithIndex: 1;
				// GtSourceCoderEditorId ].

	aStep
		clickStep: [ :s | 
			s
				label: 'Click inside of the code';
				onPagerPaneWithIndex: 2;
				// GtSourceCoderEditorId ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert fix it attribute in the second pane';
				exists;
				onPagerPaneWithIndex: 2;
				// GtSourceCoderEditorId;
				// GtFixItButton ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert fix it attribute in the first pane';
				exists;
				onPagerPaneWithIndex: 1;
				// GtSourceCoderEditorId;
				// GtFixItButton ]
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> assertResizeSpotterInScripter: aScripter [
	<gtExample>
	aScripter assert
		label: 'Assert resized event count';
		value: [ (aScripter userData at: #onResizedSpotter:event:) size ] equals: 4;
		play.

	aScripter assert
		label: 'Assert resized event extent';
		value: [ (aScripter userData at: #onResizedSpotter:event:) last value second extent ]
			equals: [ (aScripter userData at: #worldSpotterSize) + (0 @ -200) ];
		play.

	aScripter assert
		label: 'Assert Spotter element extent';
		value: [ (aScripter userData at: #onResizedSpotter:event:) last value first extent ]
			equals: [ (aScripter userData at: #worldSpotterSize) + (0 @ -200) ];
		play.

	aScripter assert
		label: 'Assert default Spotter element extent is not changed';
		value: [ GtWorldElement worldSpotterSize ]
			equals: [ aScripter userData at: #worldSpotterSize ];
		play.
]

{ #category : #assertions }
GtWorldByScripterExamples >> assertSemanticErrorInSecondPaneForPharo11In: aStep [
	aStep
		assertStep: [ :s | 
			s
				label: 'Assert two panes';
				value: [ :aPager | aPager pages size ] equals: 2;
				onPager ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert one error content dropdown';
				value: [ :aRoot | 
						| aQuery |
						aQuery := aRoot query // GtSourceCoderErrorContentElementId.
						aQuery result size ]
					equals: 1;
				onSpaceRoot ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert GtSourceCoderErrorAttribute in the second pane';
				satisfies: [ :anEditor | 
					(anEditor text attributesAt: 49)
						anySatisfy: [ :a | a class = GtSourceCoderErrorAttribute ] ];
				onPagerPaneWithIndex: 2;
				// GtSourceCoderEditorId ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert GtSourceCoderErrorAttribute in the first pane';
				satisfies: [ :anEditor | 
					(anEditor text attributesFinder
						hasAttributeSuchThat: [ :anAttribute | anAttribute class = GtSourceCoderErrorAttribute ])
						not ];
				onPagerPaneWithIndex: 1;
				// GtSourceCoderEditorId ].

	aStep
		clickStep: [ :s | 
			s
				label: 'Click inside of the code';
				onPagerPaneWithIndex: 2;
				// GtSourceCoderEditorId ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert GtSourceCoderErrorAttribute in the second pane';
				exists;
				onPagerPaneWithIndex: 2;
				// GtSourceCoderEditorId;
				// GtSourceCoderErrorButtonElementId ].

	aStep
		assertStep: [ :s | 
			s
				label: 'Assert GtSourceCoderErrorAttribute in the first pane';
				notExists;
				onPagerPaneWithIndex: 1;
				// GtSourceCoderEditorId;
				// GtSourceCoderErrorButtonElementId ]
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> browseImplementorsInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Open implementors in the third pane'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Move cursor to the end';
						block: [ :anEditor | 
							anEditor navigator
								moveTo: anEditor text size;
								apply ];
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].

			aStep
				shortcutStep: [ :s | 
					s
						label: 'Browse implementors';
						combination: BlKeyCombination primaryM;
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId;
						// GtSourceCoderEditorInnerId ].


			aStep
				assertStep: [ :s | 
					s
						label: 'Assert the third result pane';
						value: [ :aPager | aPager pages size ] equals: 3;
						onPager ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> browsePackageInSecondPane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self clickOnPackageEditableName.
	aScripter shortcut
		combination: BlKeyCombination primaryB;
		id: GtPackageCoderPackageNameId;
		play.

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check we have two tools';
				onPager;
				value: [ :anElement | anElement pages size ] equals: [ 2 ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> browseSendersInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Open senders in the third pane'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Move cursor to the end';
						block: [ :anEditor | 
							anEditor navigator
								moveTo: anEditor text size;
								apply ];
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].

			aStep
				shortcutStep: [ :s | 
					s
						label: 'Browse senders';
						combination: BlKeyCombination primaryN;
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId;
						// GtSourceCoderEditorInnerId ].


			aStep
				assertStep: [ :s | 
					s
						label: 'Assert the third result pane';
						value: [ :aPager | aPager pages size ] equals: 3;
						onPager ] ].

	^ aScripter
]

{ #category : #'examples - read-only coders' }
GtWorldByScripterExamples >> cannotClickOnCoderIssue [
	"See [feenkcom/gtoolkit#3200](https://github.com/feenkcom/gtoolkit/issues/3200)"

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self executePlaygroundSnippet.

	aScripter
		substeps: 'Display method coder in Meta'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Select Meta tab';
						onPagerPaneWithIndex: 2;
						// GtInspector;
						// GtPhlowCompositeViewElementId;
						// #tabbar;
						onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Meta' ] ] ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Expand the first method';
						onPagerPaneWithIndex: 2;
						// GtCoderElement;
						// (GtSourceCoderId indexed: 1) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert a method coder is expanded';
						value: [ :anElement | anElement isExpanded ] equals: [ true ];
						onPagerPaneWithIndex: 2;
						// GtCoderElement;
						// (GtSourceCoderId indexed: 1) ] ].

	aScripter
		substeps: 'Display Integer view'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Select Integer tab';
						onPagerPaneWithIndex: 2;
						// GtInspector;
						// GtPhlowCompositeViewElementId;
						// #tabbar;
						onChildFromBlock: [ :aCollection | 
							| aResult |
							aResult := aCollection
									collect: [ :anElement | 
										anElement children
											detect: [ :each | each label asString = 'Integer' ]
											ifNone: [ nil ] ]
									thenReject: #isNil.
							self assert: aResult size equals: 1.
							aResult anyOne ] ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Select an Integer detail';
						flag: 'This is actually a bug. We should be able just do double click';
						onPagerPaneWithIndex: 2;
						// GtInspector;
						// GtPhlowColumnedListId;
						// #scrollable;
						onChildAt: 1 ].

			aStep doubleClick
				label: 'Spawn an Integer detail';
				onPagerPaneWithIndex: 2;
				// GtInspector;
				// GtPhlowColumnedListId;
				// #scrollable;
				onChildAt: 1;
				play ].

	aScripter
		substeps: 'Display again the method coder in Meta'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Select Meta tab';
						onPagerPaneWithIndex: 2;
						// GtInspector;
						// GtPhlowCompositeViewElementId;
						// #tabbar;
						onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Meta' ] ] ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Collapse the first method';
						onPagerPaneWithIndex: 2;
						// GtCoderElement;
						// (GtSourceCoderId indexed: 1);
						// #sidebar ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert a method coder is collapsed';
						value: [ :anElement | anElement isExpanded ] equals: [ false ];
						onPagerPaneWithIndex: 2;
						// GtCoderElement;
						// (GtSourceCoderId indexed: 1) ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickAgainOnPackageEditableNameInTheFirstPane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self selectClassInSecondPane.
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on a package editable name';
				onPagerPaneWithIndex: 1;
				id: GtPackageCoderPackageNameId ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check World tab label with package name';
				value: [ :anElement | anElement tabs tabs second widget label asString ]
					equals: [ aScripter userData at: #tabLabel ] ].

	^ aScripter
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> clickBackOnPlaygroundInTheFirstPane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self clickOnInspectorInTheSecondPane.

	aScripter
		substep: 'Click on Playground'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						onPagerPaneWithIndex: 1;
						onBreadthFirstChildOfClass: GtSourceCoderElement ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Playground tab label';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: 'Playground' ] ].

	^ aScripter
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> clickOnInspectorInTheSecondPane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self executePlaygroundSnippet.

	aScripter
		substep: 'Click on Inspector'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						onPagerPaneWithIndex: 2;
						onBreadthFirstChildOfClass: GtInspector ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Inspector tab label';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: [ GtPhlowLabelBuilder new
									object: 42;
									build ] ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> clickOnLepiterPageTitle: aPage atPagerPaneIndex: anIndex scripter: aScripter [
	<gtExample>
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on a lepiter page editable title';
				onPagerPaneWithIndex: anIndex;
				// LePageEditableTitleElement ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the lepiter page title';
				value: [ :anElement | anElement pageViewModel pageModel title asString ]
					equals: [ aPage title asString ];
				onPagerPaneWithIndex: anIndex;
				// LePageEditableTitleElement ].
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the lepiter page title has focus';
				value: [ :anElement | anElement hasFocus ] equals: [ true ];
				onPagerPaneWithIndex: anIndex;
				// LePageEditableTitleElement ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickOnPackageEditableName [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self selectPackageInCoder.
	aScripter
		clickStep: [ :s | 
			s
				label: 'Click on a package editable name';
				id: GtPackageCoderPackageNameId ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check World tab label';
				id: GtPackageCoderPackageNameId;
				value: [ :anElement | anElement text asString ]
					equals: [ aScripter model name ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickOnPackageEditableNameInSecondPane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self browsePackageInSecondPane.
	aScripter
		substep: 'Select package editable name in the second pane'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on a package editable name';
						onPagerPaneWithIndex: 2;
						id: GtPackageCoderPackageNameId ].

			self
				setupExpectedTabLabel: [ :aNavigationModel | aNavigationModel selectedPackage ]
				at: 2
				step: aStep
				scripter: aScripter.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check World tab label with class name';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: [ aScripter userData at: (self paneTabLabelKeyAt: 2) ] ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> clickOnWorldHomeCoderIcon [
	"<gtExample>"
	| aScripter |
	aScripter := self worldElementInScripter.
	aScripter
		substep: 'Click on World Home Coder button'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on Coder button';
						id: GtHomeCoderButtonId ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Coder in a new tab';
						value: [ :anElement | anElement tabs tabs size ] equals: 2 ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Coder tab label';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: 'Coder' ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Coder tab selection';
						satisfies: [ :anElement | anElement tabs tabs second isSelected ]
							description: [ 'Coder tab must be selected' ] ] ].

	^ aScripter
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> coderStencil [
	<gtExample>
	<return: #GtCoderStencil>
	^ GtCoderStencil new
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> createInstanceTwiceDisplayingTheSecondTab [
	"See https://github.com/feenkcom/gtoolkit/issues/3947"

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self addPlaygroundIntoTabElement.

	aScripter memoryLogger
		runFor: GtInspectorSampleBOneForwardObjectSignal , GtPhlowForwarderFutureElementSignal
				, GtPhlowApplyToolSelectionSignal , GtPhlowStoreToolSelectionSignal
				, GtInspectorSelectTabSignal
		during: [ :aStep | 
			aStep methodCoder
				selectAll;
				type: GtInspectorSampleB name;
				type: ' new';
				playAndInspect;
				play.
			(aStep
				assertSignalsOfKind: GtInspectorSampleBOneForwardObjectSignal
				countIs: 1) play ].
	aScripter treePager
		assertNumberOfPaneElements: 2;
		play.

	aScripter inspectorStep
		clickOnTabWithName: 'Two';
		assertSelectedTabWithName: 'Two';
		onPagerPaneWithIndex: 2;
		play.

	aScripter memoryLogger
		runFor: GtInspectorSampleBOneForwardObjectSignal , GtPhlowForwarderFutureElementSignal
				, GtPhlowApplyToolSelectionSignal , GtPhlowStoreToolSelectionSignal
				, GtInspectorSelectTabSignal
		during: [ :aStep | 
			aStep methodCoder
				playAndInspect;
				play.
			aStep inspectorStep
				assertSelectedTabWithName: 'Two';
				play.
			(aStep
				assertSignalsOfKind: GtInspectorSampleBOneForwardObjectSignal
				countIs: 0) play ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> displayClassHierarchyDropdownInSecondPane [
	"See https://github.com/feenkcom/gtoolkit/issues/4374"

	<gtExample>
	<return: #BlScripter>
	| aScripter aDefiningMethod |
	aScripter := self selectClassInSecondPane.	"The extension was removed. See https://github.com/feenkcom/gtoolkit/issues/4653"
	aDefiningMethod := Behavior >> #gtHierarchyButtonFor:.
	(aDefiningMethod hasPragmaNamed: #gtClassAction) ifFalse: [ ^ aScripter ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: aSpace extent + (200 @ 200) ];
		onSpace;
		play.

	aScripter
		substeps: 'Ensure default dropdown size'
		before: [ | anInitialValue |
			anInitialValue := GtPharoCoderHierarchyDropdownConfiguration
					preferredExtentOrNil.
			GtPharoCoderHierarchyDropdownConfiguration preferredExtent: 600 @ 400.
			anInitialValue ]
		play: [ :aStep | 
			aStep click
				label: 'Click on a class hierarchy button';
				onPagerPaneWithIndex: 2;
				id: GtCoderClassHierarchyButtonId ]
		ensure: [ :anInitialValue | GtPharoCoderHierarchyDropdownConfiguration preferredExtent: anInitialValue ].



	aScripter
		checkStep: [ :s | 
			s
				label: 'Assert menu handle exists';
				exists;
				onSpaceRoot;
				// BrPopoverPinnedHandleId ].

	aScripter mouseMoveOver
		onSpaceRoot;
		// BrPopoverPinnedHandleId;
		play.

	(aScripter mouseDragBy: 20 @ 20)
		onSpaceRoot;
		// BrPopoverPinnedHandleId;
		play.

	aScripter assert
		label: 'Assert dropdown does not exist';
		notExists;
		onSpaceRoot;
		onDropdown: true;
		play.

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> displayClassHierarchyDropdownInSecondPane_SelectAnotherClass [
	"See https://github.com/feenkcom/gtoolkit/issues/4374"

	<gtExample>
	<return: #BlScripter>
	| aScripter aSelectedClass aNewSelectedClass aDefiningMethod |
	aScripter := self displayClassHierarchyDropdownInSecondPane.	"The extension was removed. See https://github.com/feenkcom/gtoolkit/issues/4653"
	aDefiningMethod := Behavior >> #gtHierarchyButtonFor:.
	(aDefiningMethod hasPragmaNamed: #gtClassAction) ifFalse: [ ^ aScripter ].

	aSelectedClass := nil.
	aNewSelectedClass := nil.

	aScripter do
		label: 'Get selected coder class';
		block: [ :aCoder | aCoder navigationModel selectedClassDo: [ :aClass | aSelectedClass := aClass ] ];
		onPagerPaneWithIndex: 2;
		// GtCoderElement;
		play.

	self assert: aSelectedClass isNotNil.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Select new class in the class hierarchy view';
				onSpaceRoot;
				// GtCoderClassesTreeElement;
				// GtCoderClassesTreeItemElement;
				@ [ :eachElement | 
					| aResult |
					aResult := eachElement theClass ~= aSelectedClass.
					(aResult and: [ aNewSelectedClass isNil ])
						ifTrue: [ aNewSelectedClass := eachElement theClass ].
					aResult ];
				@ 1 ].

	self assert: aNewSelectedClass isNotNil.

	aScripter assert
		label: 'Assert new selected coder class';
		value: [ :aCoder | aCoder navigationModel selectedClass ]
			equals: aNewSelectedClass;
		onPagerPaneWithIndex: 2;
		// GtCoderElement;
		play.

	aScripter assert
		label: 'Assert class hierarchy view exists';
		exists;
		onSpaceRoot;
		// GtCoderClassesTreeElement;
		play.

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> displayClassHierarchyDropdownInSecondPane_SelectAnotherClass_closePinnedMenu [
	"See https://github.com/feenkcom/gtoolkit/issues/4374"

	<gtExample>
	<return: #BlScripter>
	| aScripter aDefiningMethod |
	aScripter := self displayClassHierarchyDropdownInSecondPane_SelectAnotherClass.
	
	"The extension was removed. See https://github.com/feenkcom/gtoolkit/issues/4653"
	aDefiningMethod := Behavior >> #gtHierarchyButtonFor:.
	(aDefiningMethod hasPragmaNamed: #gtClassAction) ifFalse: [ ^ aScripter ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Close the class hierarchy view';
				onSpaceRoot;
				// BrPopoverPinnedCloseButtonId ].

	aScripter assert
		label: 'Assert class hierarchy view is closed';
		notExists;
		onSpaceRoot;
		// GtCoderClassesTreeElement;
		play.

	^ aScripter
]

{ #category : #'examples - remote objects' }
GtWorldByScripterExamples >> displayRustObjectDefiningMethodContextMenu [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self inspectRustRemoteObject.

	aScripter menuStep
		label: 'Display Phlow view context menu';
		openContextMenu;
		assertMenuContainerExist;
		onPagerPaneWithIndex: 3;
		// GtPhlowCompositeViewElementId;
		// BrTab;
		@ [ :aTab | aTab label asString = 'Info' ];
		play.

	^ aScripter
]

{ #category : #'examples - remote objects' }
GtWorldByScripterExamples >> displayRustObjectDefiningMethodContextMenu_hoverDefiningMethod [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self displayRustObjectDefiningMethodContextMenu.

	aScripter menuStep
		label: 'Display defining method submenu';
		hoverMenuItemWithId: #'menu--defining-method';
		assertMenuContainerExist;
		play.

	^ aScripter
]

{ #category : #'examples - remote objects' }
GtWorldByScripterExamples >> displayRustObjectDefiningMethodContextMenu_inspectDefiningMethod [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self displayRustObjectDefiningMethodContextMenu.

	aScripter
		substep: 'Inspect defining method'
		do: [ :aStep | 
			aStep menuStep
				clickMenuItemWithId: #'menu--inspect-defining-method';
				play.

			aStep assert
				label: 'Assert pane with rust source code';
				satisfies: [ :anEditor | anEditor text asString includesSubstring: '.title("Info")' caseSensitive: true ]
					description: [ :anEditor | 
						'Editor does not include `.title("Info")` substring: {1}'
							format: {anEditor text asString} ];
				onPagerPaneWithIndex: 4;
				// #editor;
				play ].

	^ aScripter
]

{ #category : #'examples - embedded debugger' }
GtWorldByScripterExamples >> doesNotUnderstandDebugSession [
	"See https://github.com/feenkcom/gtoolkit/issues/3960"

	<gtExample>
	<return: #BlScripter>
	| aScripter aSourceCode aSourceInterval |
	self
		assert: (GtPharoDummyOneObject respondsTo: #nonExistentMethod) not
		description: [ 'Method must not be implemented: {1} >> #{2}'
				format: {GtPharoDummyOneObject class.
						#nonExistentMethod} ].

	aScripter := self addPlaygroundIntoTabElement.

	aScripter do
		block: [ :aSpace | aSpace extent: 600 @ 470 ];
		onSpace;
		play.

	aSourceCode := GtPharoDummyOneObject name , String space , #nonExistentMethod.
	aSourceInterval := 1 to: aSourceCode size.

	aScripter
		substeps: 'Embedded debugger with default extent'
		before: [ | aLink aNode |
			"We need to ensure a specific dropdow extent during the example execution"
			aLink := MetaLink new
					metaObject: [ 400 @ 250 ];
					selector: #value;
					arguments: #();
					control: #instead.
			aNode := (GtCoderEmbeddedDebuggerDropdownConfiguration class >> #userExtent)
					ast.
			aNode link: aLink.
			aLink ]
		play: [ :aStep | 
			aStep methodCoder
				selectAll;
				type: aSourceCode;
				debugSessionWithException: MessageNotUnderstood
					do: [ :aSubStep | 
						aSubStep methodCoder
							assertEmbeddedDebuggerExists;
							assertEmbeddedDebuggerDropdownIsDisplayed;
							assertEmbeddedDebuggerDropdownDebugButtonIsDisplayed ];
				// GtSourceCoderEditorId ]
		ensure: [ :aLink | aLink uninstall ].

	^ aScripter
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> executeInspectorPlaygroundSnippetInTheThirdPage [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self addPlaygroundIntoTabElement.

	aScripter methodCoder
		selectAll;
		type: GtPharoDummyOneObject name;
		type: ' new';
		playAndInspect;
		play.

	aScripter treePager
		assertNumberOfPaneElements: 2;
		clickOnInspectorInspectButtonAtColumn: 2;
		assertNumberOfPaneElements: 3;
		dragInspectorPlaygroundAtPaneColumn: 2
			row: 1
			verticallyBy: -150;
		dragInspectorPlaygroundAtPaneColumn: 3
			row: 1
			verticallyBy: -150;
		play.

	aScripter methodCoder
		click;
		assertHasFocus;
		selectAll;
		type: Object name;
		browseBehavior;
		onPagerPaneWithIndex: 3;
		// #playground;
		// GtSourceCoderEditorId;
		play.

	aScripter treePager
		assertNumberOfPaneElements: 4;
		play.

	^ aScripter
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> executePlaygroundSnippet [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self typeSnippetInPlayground.

	aScripter
		substep: 'Execute Playground snippet'
		do: [ :aStep | 
			aStep shortcut
				combination: BlKeyCombination primaryG;
				id: GtWorldTabGroupId;
				onPagerPaneWithIndex: 1;
				onBreadthFirstChildOfClass: GtSourceCoderElement;
				// GtSourceCoderEditorInnerId;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check we have two tools';
						value: [ :anElement | anElement pages size ] equals: [ 2 ];
						id: GtWorldTabGroupId;
						onPager ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> executeScriptInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Open result in the third pane'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Play and inspect Pharo script';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderDoItAndGoActionId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert the third result pane';
						value: [ :aPager | aPager pages size ] equals: 3;
						onPager ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> expandMethodCoder [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPage |
	aScripter := self addLepiterPageWithPharoSnippetIntoTabElement.
	aPage := aScripter model page.

	aScripter methodCoder
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :imageDirStep | 
				imageDirStep
					assertMethodExpandersCountIs: 1;
					assertSelfObjectIs: FileLocator;
					assertTargetBehaviorIs: FileLocator class;
					assertExplicitProviderClassIs: FileLocator class ];
		onPagerPaneWithIndex: 1;
		id: LeSnippetElementId index: 1;
		play.


	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> formatScriptWithAssignmentInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Open result in the third pane'
		do: [ :aStep | 
			aStep
				typeStep: [ :s | 
					s
						label: 'Type assignment';
						text: 'dir := ';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				shortcutStep: [ :s | 
					s
						label: 'Format script';
						combination: BlKeyCombination primaryShiftF;
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert two panes';
						value: [ :aPager | aPager pages size ] equals: 2;
						onPager ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert no error content dropdown';
						value: [ :aRoot | 
								| aQuery |
								aQuery := aRoot query // GtSourceCoderErrorContentElementId.
								aQuery result size ]
							equals: 0;
						onSpaceRoot ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Click inside of the code';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the first pane';
						satisfies: [ :anEditor | 
							(anEditor text attributesFinder
								hasAttributeSuchThat: [ :anAttribute | anAttribute class = GtSourceCoderErrorAttribute ])
								not ];
						onPagerPaneWithIndex: 1;
						// GtSourceCoderEditorId ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the second pane';
						satisfies: [ :anEditor | 
							(anEditor text attributesFinder
								hasAttributeSuchThat: [ :anAttribute | anAttribute class = GtSourceCoderErrorAttribute ])
								not ];
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the second pane';
						notExists;
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId;
						// GtSourceCoderErrorButtonElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the first pane';
						notExists;
						onPagerPaneWithIndex: 1;
						// GtSourceCoderEditorId;
						// GtSourceCoderErrorButtonElementId ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> formatScriptWithSyntaxErrorInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Open result in the third pane'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Move cursor to the end';
						block: [ :anEditor | 
							anEditor navigator
								moveTo: anEditor text size;
								apply ];
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				typeStep: [ :s | 
					s
						label: 'Type semicolon';
						text: ';';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				shortcutStep: [ :s | 
					s
						label: 'Format script';
						combination: BlKeyCombination primaryShiftF;
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId;
						// GtSourceCoderEditorInnerId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert two panes';
						value: [ :aPager | aPager pages size ] equals: 2;
						onPager ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert one error content dropdown';
						value: [ :aRoot | 
								| aQuery |
								aQuery := aRoot query // GtSourceCoderErrorContentElementId.
								aQuery result size ]
							equals: 1;
						onSpaceRoot ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Click inside of the code';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the first pane';
						satisfies: [ :anEditor | 
							(anEditor text attributesFinder
								hasAttributeSuchThat: [ :anAttribute | anAttribute class = GtSourceCoderErrorAttribute ])
								not ];
						onPagerPaneWithIndex: 1;
						// GtSourceCoderEditorId ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the second pane';
						satisfies: [ :anEditor | 
							(anEditor text attributesAt: 27)
								anySatisfy: [ :a | a class = GtSourceCoderErrorAttribute ] ];
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the second pane';
						exists;
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId;
						// GtSourceCoderErrorButtonElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the first pane';
						notExists;
						onPagerPaneWithIndex: 1;
						// GtSourceCoderEditorId;
						// GtSourceCoderErrorButtonElementId ] ].

	^ aScripter
]

{ #category : #'examples - remote objects' }
GtWorldByScripterExamples >> inspectRustRemoteObject [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self addPlaygroundIntoTabElement.

	aScripter do
		label: 'Set window size';
		block: [ :aSpace | aSpace extent: 1200 @ 800 ];
		onSpace;
		play.

	aScripter
		substep: 'Display text editor'
		do: [ :aStep | 
			aStep do
				label: 'Set snippet code';
				block: [ :anElement | anElement snippetViewModel snippetModel code: self sourceCodeWithEditor ];
				// LeSnippetElementId;
				play.

			aStep assert
				label: 'Assert snippet code';
				onPagerPaneWithIndex: 1;
				id: GtSourceCoderEditorId;
				value: [ :anElement | anElement text asString ]
					equals: self sourceCodeWithEditor;
				play.

			aStep click
				label: 'Inspect result';
				// GtSourceCoderDoItAndGoActionId;
				play ].

	aScripter
		substep: 'Create next snippet'
		do: [ :aStep | 
			aStep shortcut
				label: 'Move cursor to the end of the snippet';
				combination: BlKeyCombination builder primary end build;
				onPagerPaneWithIndex: 1;
				id: GtSourceCoderEditorId;
				// GtSourceCoderEditorInnerId;
				play.

			aStep shortcut
				label: 'Create new snippet';
				combination: BlKeyCombination builder primary return build;
				onPagerPaneWithIndex: 1;
				id: GtSourceCoderEditorId;
				// GtSourceCoderEditorInnerId;
				play ].

	aScripter
		substep: 'Display rust object'
		do: [ :aStep | 
			aStep do
				label: 'Set snippet code';
				block: [ :anElement | 
					anElement snippetViewModel snippetModel
						code: self sourceCodeWInspectingRustObject ];
				// LeSnippetElementId;
				@ 2;
				play.

			aStep click
				label: 'Inspect result';
				// GtSourceCoderDoItAndGoActionId;
				@ 2;
				play.

			aStep click
				label: 'Inspect rust object';
				// #'phlow--inspect-rust-object';
				play ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> lepiterPageCreateNonExistentClass [
	<gtExample>
	<after: #removeNonExistentClass>
	<return: #MessageNotUnderstood>
	| aScripter aPageHolder |
	aScripter := self addLepiterPageHavingPharoSnippetWithNonExistentClassAndMethod.
	aPageHolder := aScripter model.

	aScripter
		substeps: 'Create non-existent class'
		do: [ :aStep | 
			aStep click
				label: 'Click on class fixit button';
				// (GtMethodAdviceElementId indexed: 1);
				play.

			aStep click
				label: 'Click on create class';
				onSpaceRoot;
				// (GtDefineClassFixItActionElementId indexed: 1);
				play.

			aStep click
				label: 'Click on package input field';
				onSpaceRoot;
				// (GtMagritteFieldElementId new
						description: GtCreationForm new packageAndTagDescription);
				// #package;
				play.

			aStep type
				text: self temporaryPackageName;
				play.

			aStep click
				label: 'Accept create class form';
				onSpaceRoot;
				// (GtMagritteActionElementId new
						description: GtCreationForm new magritteAcceptAction);
				play.

			aStep assert
				label: 'Assert class exists';
				satisfies: [ :anObject | self class environment hasClassNamed: LeModelExamples new nonExistentClassName ];
				onModel;
				play ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> lepiterPageCreateNonExistentClass2 [
	<gtExample>
	<after: #removeNonExistentClass>
	<return: #MessageNotUnderstood>
	| aScripter aPageHolder aPage aFirstSnippetId |
	aScripter := self
			addLepiterPageHavingPharoSnippetWithNonExistentClassAndMethod2.
	aPageHolder := aScripter model.
	aPage := aPageHolder page.
	aFirstSnippetId := LeSnippetId new uid: aPage children first uid.

	aScripter
		substeps: 'Create non-existent class'
		do: [ :aStep | 
			aStep click
				label: 'Click on class fixit button';
				// aFirstSnippetId;
				// (GtMethodAdviceElementId indexed: 1);
				play.

			aStep click
				label: 'Click on create class';
				onSpaceRoot;
				// (GtDefineClassFixItActionElementId indexed: 1);
				play.

			aStep click
				label: 'Click on package input field';
				onSpaceRoot;
				// (GtMagritteFieldElementId new
						description: GtCreationForm new packageAndTagDescription);
				// #package;
				play.

			aStep type
				text: self temporaryPackageName;
				play.

			aStep click
				label: 'Accept create class form';
				onSpaceRoot;
				// (GtMagritteActionElementId new
						description: GtCreationForm new magritteAcceptAction);
				play.

			aStep assert
				label: 'Assert class exists';
				satisfies: [ :anObject | self class environment hasClassNamed: LeModelExamples new nonExistentClassName ];
				onModel;
				play ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> lepiterPageCreateNonExistentMethod [
	<gtExample>
	<return: #MessageNotUnderstood>
	| aScripter aPageHolder |
	aScripter := self lepiterPageCreateNonExistentClass.
	aPageHolder := aScripter model.

	aScripter
		substeps: 'Create non-existent method'
		do: [ :aStep | 
			aStep click
				label: 'Click on method fixit button';
				// (GtMethodAdviceElementId indexed: 1);
				play.

			aStep click
				label: 'Click on create method';
				onSpaceRoot;
				// (GtDefineMethodFixItActionElementId indexed: 1);
				play.

			aStep methodCoder
				assertMethodExpandersCountIs: 2;
				methodCoderExpander: 2
					insideDo: [ :insideStep | 
						insideStep
							assertTargetBehaviorIs: self nonExistentClass;
							assertExplicitProviderClassIs: nil;
							assertBinding: #anInteger is: 72;
							assertBinding: #anInteger1 is: 144 ];
				// GtSourceCoderEditorId;
				play ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> lepiterPageCreateNonExistentMethod2 [
	<gtExample>
	<return: #MessageNotUnderstood>
	| aScripter aPageHolder aPage aFirstSnippetId aSecondSnippetId |
	aScripter := self lepiterPageCreateNonExistentClass2.
	aPageHolder := aScripter model.
	aPage := aPageHolder page.
	aFirstSnippetId := LeSnippetId new uid: aPage children first uid.
	aSecondSnippetId := LeSnippetId new uid: aPage children second uid.

	aScripter
		substeps: 'Create non-existent method'
		do: [ :aStep | 
			aStep click
				label: 'Evaluate the first snippet';
				// aFirstSnippetId;
				// GtSourceCoderDoItActionId;
				play.

			aStep click
				label: 'Click on method fixit button';
				// aSecondSnippetId;
				// (GtMethodAdviceElementId indexed: 1);
				play.

			aStep click
				label: 'Click on create method';
				onSpaceRoot;
				// (GtDefineMethodFixItActionElementId indexed: 1);
				play.

			aStep methodCoder
				assertMethodExpandersCountIs: 1;
				methodCoderExpander: 1
					insideDo: [ :insideStep | 
						insideStep
							assertTargetBehaviorIs: self nonExistentClass;
							assertExplicitProviderClassIs: self nonExistentClass;
							assertBinding: #arg1 is: 72;
							assertBinding: #arg2 is: 144 ];
				// aSecondSnippetId;
				// GtSourceCoderEditorId;
				play ].

	aScripter methodCoder
		methodCoderExpander: 1
			insideDo: [ :insideStep | 
				insideStep
					label: 'Print the first method argument value';
					select: 'arg1'
						from: 12
						to: 16;
					printIt;
					assertPrintItString: '72' ];
		// aSecondSnippetId;
		// GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> nonExistentClass [
	^ self class environment classNamed: LeModelExamples new nonExistentClassName
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> openWorldMenu [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self worldElementInScripter.
	aScripter
		substep: 'Open world menu dropdown'
		do: [ :aStep | 
			aStep click
				label: 'Click on menu button';
				id: GtWorldMenuElementId;
				play.

			aStep menuStep
				assertMenuContainerExist;
				play ].

	^ aScripter
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> openWorldMenuTranscript [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self openWorldMenu.
	aScripter
		substep: 'Open transcript tool'
		do: [ :aStep | 
			aStep assert
				label: 'Assert one world tab';
				value: [ :anElement | anElement tabs tabs size ] equals: 1;
				play.

			aStep click
				label: 'Click on transcript button';
				onSpaceRoot;
				onDropdown: true;
				// GtWorldMenuTranscriptElementId;
				play.

			aStep menuStep
				assertClosedMenuContainer;
				play.
			aStep assert
				label: 'Assert two world tabs';
				value: [ :anElement | anElement tabs tabs size ] equals: 2;
				play ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> paneModelKeyAt: aPaneIndex [
	^ 'paneModelAt', aPaneIndex asString
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> paneTabLabelKeyAt: aPaneIndex [
	^ 'paneTabLabelAt', aPaneIndex asString
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> playgroundStencil [
	<gtExample>
	<return: #GtPlaygroundStencil>
	| aDb aStencil |
	aDb := LeLogicalDatabase new primaryDB: LeDatabase new.

	aStencil := GtPlaygroundStencil new knowledgeBase: aDb.

	self assert: aStencil knowledgeBase == aDb.

	^ aStencil
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> printScriptResultInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Print result in the second pane'
		do: [ :aStep | 
			aStep
				shortcutStep: [ :s | 
					s
						label: 'Play and print Pharo script';
						combination: BlKeyCombination primaryP;
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId;
						// GtSourceCoderEditorInnerId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert two panes';
						value: [ :aPager | aPager pages size ] equals: 2;
						onPager ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert print element in the second pane';
						exists;
						onPagerPaneWithIndex: 2;
						// GtCoderPrintStringElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert print element not in the first pane';
						notExists;
						onPagerPaneWithIndex: 1;
						// GtCoderPrintStringElementId ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> profileScriptInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Open profile report in the third pane'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Profile Pharo script';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderProfileActionId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert the third result pane';
						value: [ :aPager | aPager pages size ] equals: 3;
						onPager ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> removeClassAddedByEpiceaSnippet [
	<gtExample>
	<return: #BlScripter>
	| aScripter aCreateClassId aClassLinkId aCreateMethodId aMethodLinkId anExampleId |
	aScripter := self applyEpiceaSnippetChanges.
	aCreateClassId := aScripter model page children first uid.
	aClassLinkId := aScripter model page children second uid.
	aCreateMethodId := aScripter model page children third uid.
	aMethodLinkId := aScripter model page children fourth uid.
	anExampleId := aScripter model page children fifth uid.

	aScripter do
		label: 'Remove LeOnDemandDummyClass';
		block: [ | aClass |
			aClass := Smalltalk at: #LeOnDemandDummyClass.
			aClass removeFromSystem ];
		play.

	aScripter assert
		label: 'Assert LeOnDemandDummyClass does not exist';
		satisfies: [ Smalltalk
					at: #LeOnDemandDummyClass
					ifPresent: [ :aClass | false ]
					ifAbsent: [ true ] ]
			description: [ 'LeOnDemandDummyClass exists' ];
		play.

	aScripter assert
		label: 'Assert LeOnDemandDummyClass link is not clickable';
		notExists;
		// (LeSnippetId new uid: aClassLinkId);
		// GtSourceCoderEditorId;
		// (LeTextSnippetAttributeLabelElementId indexed: 1);
		play.

	aScripter assert
		label: 'Assert example method link is not clickable';
		notExists;
		// (LeSnippetId new uid: aMethodLinkId);
		// GtSourceCoderEditorId;
		// (LeTextSnippetAttributeLabelElementId indexed: 1);
		play.

	aScripter assert
		label: 'Assert example does not include preview';
		notExists;
		// (LeSnippetId new uid: anExampleId);
		// GtPhlowCompositeViewElementId;
		play.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> removeMethodAddedByEpiceaSnippet [
	<gtExample>
	<return: #BlScripter>
	| aScripter aCreateClassId aClassLinkId aCreateMethodId aMethodLinkId anExampleId |
	aScripter := self applyEpiceaSnippetChanges.
	aCreateClassId := aScripter model page children first uid.
	aClassLinkId := aScripter model page children second uid.
	aCreateMethodId := aScripter model page children third uid.
	aMethodLinkId := aScripter model page children fourth uid.
	anExampleId := aScripter model page children fifth uid.

	aScripter do
		label: 'Remove LeOnDemandDummyClass >> #example';
		block: [ | aClass aMethod |
			aClass := Smalltalk at: #LeOnDemandDummyClass.
			aMethod := aClass methodDict at: #example.
			aMethod removeFromSystem ];
		play.

	aScripter assert
		label: 'Assert LeOnDemandDummyClass exists';
		satisfies: [ Smalltalk
					at: #LeOnDemandDummyClass
					ifPresent: [ :aClass | true ]
					ifAbsent: [ false ] ]
			description: [ 'LeOnDemandDummyClass does not exist' ];
		play.

	aScripter assert
		label: 'Assert LeOnDemandDummyClass >> #example does not exist';
		satisfies: [ Smalltalk
					at: #LeOnDemandDummyClass
					ifPresent: [ :aClass | 
						aClass methodDict
							at: #example
							ifPresent: [ :aMethod | false ]
							ifAbsent: [ true ] ]
					ifAbsent: [ false ] ]
			description: [ 'LeOnDemandDummyClass >> #example exists' ];
		play.

	aScripter assert
		label: 'Assert LeOnDemandDummyClass link is clickable';
		exists;
		// (LeSnippetId new uid: aClassLinkId);
		// GtSourceCoderEditorId;
		// (LeTextSnippetAttributeLabelElementId indexed: 1);
		play.

	aScripter assert
		label: 'Assert example method link is not clickable';
		notExists;
		// (LeSnippetId new uid: aMethodLinkId);
		// GtSourceCoderEditorId;
		// (LeTextSnippetAttributeLabelElementId indexed: 1);
		play.

	aScripter assert
		label: 'Assert example does not include preview';
		notExists;
		// (LeSnippetId new uid: anExampleId);
		// GtPhlowCompositeViewElementId;
		play.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> removeNonExistentClass [
	| aClass aPackage |
	aClass := self nonExistentClass.
	aClass ifNil: [ ^ self ].
	aPackage := aClass package.
	aClass removeFromSystem.
	aPackage removeFromSystem
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> removeOnDemandDummyClass [
	Smalltalk globals
		at: #LeOnDemandDummyClass
		ifPresent: [ :aClass | aClass removeFromSystem ]
		ifAbsent: [  ]
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> resizeSpotterInScripter: aScripter [
	<gtExample>
	aScripter
		substeps: 'Resize Spotter'
		before: [ :anElement :aUserData :theScripter | 
			| aCollection aLink aNode |
			self assert: (anElement isKindOf: GtWorldElement).
			aCollection := OrderedCollection new.
			aUserData at: #onResizedSpotter:event: put: aCollection.
			aLink := MetaLink new
					metaObject: [ :aReceiver :anArguments | aCollection add: aReceiver -> anArguments ];
					selector: #value:value:;
					arguments: #(receiver arguments);
					control: #instead.
			aNode := (GtWorldElement >> #onResizedSpotter:event:) ast.
			aNode link: aLink forObject: anElement.
			aLink ]
		play: [ :aStep | 
			aStep mouseMoveOver
				onSpaceRoot;
				// GtStreamingSpotterElement;
				/ BrResizer;
				@ [ :aResizer | aResizer location isKindOf: BrResizerBottomLocation ].
			aStep mouseDown.
			aStep mouseMove by: 0 @ -50.
			aStep mouseMove by: 0 @ -50.
			aStep mouseUp.
			aStep mouseDown.
			aStep mouseMove by: 0 @ -50.
			aStep mouseMove by: 0 @ -50.
			aStep mouseUp ]
		ensure: [ :aLink | aLink uninstall ]
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> searchAndBrowseBlElementZIndexMethod [
	"Issue [feenkcom/gtoolkit#3168](https://github.com/feenkcom/gtoolkit/issues/3168)"

	<gtExample>
	<return: #BlScripter>
	| aScripter aLogger |
	aScripter := self worldElementInScripter.

	aScripter
		substep: 'Search BlElement>>#zIndex: using Spotter'
		do: [ :aStep | 
			aStep memoryLogger
				runFor: LeDatabaseSidebarGroupedListUpdateSelectionSignal
						, LeDatabaseSidebarGroupedListScrolledToIndexSignal
						, LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal
				during: [ :aLoggerStep | 
					aLoggerStep
						clickStep: [ :s | 
							s
								label: 'Click on Spotter button';
								id: GtWorldSpotterSearchElementId ] ].

			aStep typeStep: [ :s | s text: (BlElement >> #zIndex:) printString ].

			aLogger := MemoryLogger startFor: GtPharoStreamingMethodsCoderElementSignal.
			aLogger name: '01 Browse method'.
			aScripter userData at: aLogger name put: aLogger.

			[ aStep
				keyPressStep: [ :s | 
					s
						label: 'Press return';
						key: BlKeyboardKey return ] ] ensure: [ aLogger stop ] ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert ' , (BlElement >> #zIndex:) printString , ' bounds in space';
				satisfies: [ :aMethodCoder | aScripter space root boundsInSpace containsRect: aMethodCoder boundsInSpace ];
				// GtCoderElement;
				// GtPharoStreamingMethodsCoderElement;
				/ GtPharoStreamingMethodsCoderListId;
				/ #scrollable;
				onChildFromBlock: [ :anInfiniteList | 
					anInfiniteList children
						detect: [ :aMethodCoder | 
							aMethodCoder coderViewModel behavior = BlElement
								and: [ aMethodCoder coderViewModel selector = #zIndex: ] ] ] ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert ' , (BlElement >> #zIndex:) printString , ' bounds in parent';
				satisfies: [ :aMethodCoder | aMethodCoder parent boundsInSpace containsRect: aMethodCoder boundsInSpace ];
				// GtCoderElement;
				// GtPharoStreamingMethodsCoderElement;
				/ GtPharoStreamingMethodsCoderListId;
				/ #scrollable;
				onChildFromBlock: [ :anInfiniteList | 
					anInfiniteList children
						detect: [ :aMethodCoder | 
							aMethodCoder coderViewModel behavior = BlElement
								and: [ aMethodCoder coderViewModel selector = #zIndex: ] ] ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> selectClassInSecondPane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self clickOnPackageEditableNameInSecondPane.
	aScripter
		substep: 'Select class in second pane'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						id: GtWorldTabGroupId;
						onPagerPaneWithIndex: 2;
						onBreadthFirstChildOfClass: GtPharoPackageCoderElement;
						onBreadthFirstChildOfClass: GtClassesElement;
						onChildOfClass: BrSimpleList;
						onChildOfClass: BrInfiniteListElement;
						onChildAt: 1 ].

			aStep
				doStep: [ :s | 
					s
						label: 'Store expected class name';
						block: [ :anElement | 
							| aClass |
							anElement navigationModel
								selectedClassDo: [ :theClass | aClass := theClass ].
							self
								assert: aClass isNotNil
								description: 'Second pane must have a class selected'.
							aScripter userData at: #secondPaneModel put: aClass.
							aScripter userData
								at: #secondPaneTabLabel
								put: anElement shortTitle asString ];
						id: GtWorldTabGroupId;
						onPagerPaneWithIndex: 2;
						onBreadthFirstChildOfClass: GtCoderElement ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check World tab label with class name';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: [ aScripter userData at: #secondPaneTabLabel ] ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Click on the second Coder';
						id: GtWorldTabGroupId;
						onPagerPaneWithIndex: 2;
						onBreadthFirstChildOfClass: GtPharoBehaviorCoderElement;
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check World tab label with class name';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: [ aScripter userData at: #secondPaneTabLabel ] ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> selectPackageInCoder [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self addCoderIntoTabElement.

	aScripter
		substep: 'Select package'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on a package item';
						id: GtWorldTabGroupId;
						onBreadthFirstChildOfClass: GtPackagesCoderElement;
						onBreadthFirstChildOfClass: BrSimpleList;
						onChildOfClass: BrInfiniteListElement;
						onChildAt: 1 ].

			aStep
				doStep: [ :s | 
					s
						label: 'Store expected package name';
						block: [ :anElement | 
							anElement navigationModel
								selectedPackageDo: [ :aPackage | aScripter model: aPackage ].
							self
								assert: aScripter model isNotNil
								description: 'Scripter model must be a package, but is nil'.
							aScripter userData at: #tabLabel put: anElement shortTitle asString ];
						id: GtWorldTabGroupId;
						onBreadthFirstChildOfClass: GtCoderElement ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check World tab label';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: [ aScripter userData at: #tabLabel ] ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> semanticErrorScriptInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Open result in the third pane'
		do: [ :aStep | 
			aStep
				typeStep: [ :s | 
					s
						label: 'Define variable';
						text: '| each | ';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				doStep: [ :s | 
					s
						label: 'Move cursor to the end';
						block: [ :anEditor | 
							anEditor navigator
								moveTo: anEditor text size;
								apply ];
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				typeStep: [ :s | 
					s
						label: 'Type block with variable';
						text: ' files do: [ :each | each ]';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				clickStep: [ :s | 
					s
						label: 'Play and inspect Pharo script';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderDoItAndGoActionId ].

			self
				forPharo12AndNewer: [ self assertNoSemanticErrorAndThreePanesForPharo12In: aStep ]
				forPharo11: [ self assertSemanticErrorInSecondPaneForPharo11In: aStep ] ].

	^ aScripter
]

{ #category : #'examples - coder' }
GtWorldByScripterExamples >> setupExpectedTabLabel: aBlock at: aPaneIndex step: aStep scripter: aScripter [
	<gtExample>
	aStep
		doStep: [ :s | 
			s
				label: 'Store expected Coder model and tab label name';
				block: [ :aCoder | 
					| aModel |
					aModel := aBlock value: aCoder navigationModel.
					self
						assert: aModel isNotNil
						description: 'Second pane must have a class selected'.
					aScripter userData
						at: (self paneModelKeyAt: aPaneIndex) put: aModel;
						at: (self paneTabLabelKeyAt: aPaneIndex) put: aCoder shortTitle asString ];
				id: GtWorldTabGroupId;
				onPagerPaneWithIndex: aPaneIndex;
				onBreadthFirstChildOfClass: GtCoderElement ]
]

{ #category : #'examples - remote objects' }
GtWorldByScripterExamples >> sourceCodeWInspectingRustObject [
	^ 'editor children first buildParagraph layoutWithWidth: 400'
]

{ #category : #'examples - remote objects' }
GtWorldByScripterExamples >> sourceCodeWithEditor [
	^ 'stream := BlTextStream new.
stream glamorousRegularFont fontSize: 40.
stream next
	putAll: ''This is a piece of text in an editor. The editor is made out of ''.
stream next
	foreground: Color blue;
	bold;
	putAll: ''Pharo''.
stream next
	putAll: '' paragraph objects. These paragraph objects have correspondent objects in the ''.
stream next
	foreground: Color red;
	bold;
	putAll: ''Rust''.
stream next putAll: '' world which can be inspected seamlessly, too.''.
editor := BrEditor new
		text: stream contents;
		aptitude: BrGlamorousRegularEditorAptitude new'
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> spawnSameLepiterPageWithPharoSnippetToNextPane [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPage |
	aScripter := self addLepiterPageWithPharoSnippetIntoTabElement.
	aPage := aScripter model page.

	aScripter
		substeps: 'Open the same page in a second pane'
		do: [ :aStep | 
			self
				clickOnLepiterPageTitle: aPage
				atPagerPaneIndex: 1
				scripter: aStep.
			aStep
				shortcutStep: [ :s | 
					s
						label: 'Browse the same lepiter page from editable title';
						combination: BlKeyCombination primaryB;
						onPagerPaneWithIndex: 1;
						// LePageEditableTitleElement;
						// BrEditor ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert there is a second pane with a same page';
						value: [ :anEditor | anEditor text asString ]
							equals: [ aPage title asString ];
						onPagerPaneWithIndex: 2;
						// LePageEditableTitleElement;
						// BrEditor ] ].

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> syntaxErrorScriptInTheSecondLepiterPagePane [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self spawnSameLepiterPageWithPharoSnippetToNextPane.

	aScripter
		substeps: 'Open result in the third pane'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Move cursor to the end';
						block: [ :anEditor | 
							anEditor navigator
								moveTo: anEditor text size;
								apply ];
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				typeStep: [ :s | 
					s
						label: 'Type semicolon';
						text: ';';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].
			aStep
				clickStep: [ :s | 
					s
						label: 'Play and inspect Pharo script';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderDoItAndGoActionId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert two panes';
						value: [ :aPager | aPager pages size ] equals: 2;
						onPager ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert one error content dropdown';
						value: [ :aRoot | 
								| aQuery |
								aQuery := aRoot query // GtSourceCoderErrorContentElementId.
								aQuery result size ]
							equals: 1;
						onSpaceRoot ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the second pane';
						satisfies: [ :anEditor | 
							(anEditor text attributesAt: 27)
								anySatisfy: [ :a | a class = GtSourceCoderErrorAttribute ] ];
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the first pane';
						satisfies: [ :anEditor | 
							(anEditor text attributesFinder
								hasAttributeSuchThat: [ :anAttribute | anAttribute class = GtSourceCoderErrorAttribute ])
								not ];
						onPagerPaneWithIndex: 1;
						// GtSourceCoderEditorId ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Click inside of the code';
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the second pane';
						exists;
						onPagerPaneWithIndex: 2;
						// GtSourceCoderEditorId;
						// GtSourceCoderErrorButtonElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert GtSourceCoderErrorAttribute in the first pane';
						notExists;
						onPagerPaneWithIndex: 1;
						// GtSourceCoderEditorId;
						// GtSourceCoderErrorButtonElementId ] ].

	^ aScripter
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> tabElementInScripter [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripter.
	aScripter element: GtWorldTabElement new.

	^ aScripter
]

{ #category : #'examples - lepiter' }
GtWorldByScripterExamples >> temporaryPackageName [
	^ 'TemporaryDummyPackageName20240705'
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> twoContextualPlaygroundsOfTheSameKindOfObjects [
	"See https://github.com/feenkcom/gtoolkit/issues/4852"

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self addPlaygroundIntoTabElement.

	aScripter methodCoder
		selectAll;
		type: '(1 to: 10) asOrderedCollection';
		playAndInspect;
		play.

	aScripter treePager
		assertNumberOfPaneElements: 2;
		dragInspectorPlaygroundAtPaneColumn: 2
			row: 1
			verticallyBy: -200;
		play.

	aScripter methodCoder
		click;
		selectAll;
		type: 'self select: [:each | each even ].';
		playAndInspect;
		onTreePagerPaneColumn: 2;
		id: GtSourceCoderEditorId index: 1;
		play.

	aScripter treePager
		assertNumberOfPaneElements: 3;
		dragInspectorPlaygroundAtPaneColumn: 3
			row: 1
			verticallyBy: -300;
		play.

	aScripter editor
		click;
		moveToEnd;
		pressPrimaryReturn;
		type: 'self selec';
		onTreePagerPaneColumn: 3;
		id: GtSourceCoderEditorId index: 1;
		play.

	aScripter click
		onSpaceRoot;
		// #'completion-list';
		// BrLabel;
		@ [ :eachLabel | eachLabel text asString = 'select:' ];
		play.

	^ aScripter
]

{ #category : #'examples - playground' }
GtWorldByScripterExamples >> typeSnippetInPlayground [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self addPlaygroundIntoTabElement.

	aScripter
		substep: 'Type Playground snippet'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						onPagerPaneWithIndex: 1;
						id: GtSourceCoderEditorId ].

			aStep
				typeStep: [ :s | 
					s
						text: '42';
						onPagerPaneWithIndex: 1;
						id: GtSourceCoderEditorId ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check Playground content';
						onPagerPaneWithIndex: 1;
						id: GtSourceCoderEditorId;
						value: [ :anElement | anElement text asString ] equals: '42' ] ].

	^ aScripter
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> worldElementInScripter [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripter.
	aScripter
		element: (GtWorldElement new
				knowledgeBase: LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase).
	^ aScripter
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> worldSpotter_ResizeVertically [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self worldElementInScripter.

	aScripter click
		label: 'Open Spotter dropdown';
		// GtWorldSpotterSearchElementId;
		play.

	aScripter do
		label: 'Store current Spotter extent';
		block: [ aScripter userData at: #worldSpotterSize put: GtWorldElement worldSpotterSize ];
		play.

	self resizeSpotterInScripter: aScripter.
	self assertResizeSpotterInScripter: aScripter.

	^ aScripter
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> worldSpotter_ResizeVertically_ClosePressingEscape [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self worldSpotter_ResizeVertically.

	aScripter keyPress
		label: 'Close Spotter pressing escape key';
		key: BlKeyboardKey escape;
		play.

	aScripter assert
		label: 'Assert Spotter resizers do not keep target elements';
		satisfies: [ :aButton | 
			aButton aptitude
				findActor: BrGlamorousWithDropdownAptitude
				ifFound: [ :anAptitude | 
					anAptitude resizerAptitudes
						withAllActorsDepthFirstDo: [ :eachAptitude | 
							eachAptitude
								resizerDo: [ :eachResizer | 
									eachResizer target isNil
										ifFalse: [ AssertionFailure signal: 'Resizer must not have target' ] ] ] ]
				ifNone: [ aButton aptitude
						findActor: BrGlamorousWithExplicitDropdownAptitude
						ifFound: [ :anAptitude | 
							anAptitude menuContainer elementCache isEmpty
								ifFalse: [ AssertionFailure signal: 'Dropdown cache is not empty' ] ]
						ifNone: [ AssertionFailure signal: 'Dropdown not found' ] ].
			true ];
		// GtWorldSpotterSearchElementId;
		play.

	^ aScripter
]

{ #category : #'examples - world' }
GtWorldByScripterExamples >> worldSpotter_ResizeVertically_ClosePressingEscape_ResizeSecondTime [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self worldSpotter_ResizeVertically_ClosePressingEscape.

	aScripter click
		label: 'Open Spotter dropdown';
		// GtWorldSpotterSearchElementId;
		play.

	self resizeSpotterInScripter: aScripter.
	self assertResizeSpotterInScripter: aScripter.

	^ aScripter
]
