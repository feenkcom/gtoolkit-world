"
I provide utility methods for configuring a Glamorous Tookit image after loading the code for production of for local development. 

I provide the following two API methods: 
- {{gtMethod:GtImageSetup class>>#performLocalSetup}}: use when creating an image locally for development;
- {{gtMethod:GtImageSetup class>>#performSetupForRelease}}: used during the release process

The various configurations that I support are in class-side methods in the `actions` category. For example, setting a new logo or updating the {{gtClass:GtImage}} version.


"
Class {
	#name : #GtImageSetup,
	#superclass : #Object,
	#category : #'GToolkit-Setup'
}

{ #category : #utilities }
GtImageSetup class >> addFoldersIn: icebergRepositories named: folderNames into: docFolders [
	icebergRepositories do: [ :aRepository | 
		folderNames do: [ :aName | 
			docFolders addAll: (aRepository location childrenMatching: aName) ] ]
]

{ #category : #actions }
GtImageSetup class >> captureRepositoryRegistryHistory [
	GtGitRepositoryRegistryHistory instance capture
]

{ #category : #actions }
GtImageSetup class >> cleanUpChangeSets [
	ChangeSet removeChangeSetsNamedSuchThat: [ :each | true ].
	ChangeSet resetCurrentToNewUnnamedChangeSet.
]

{ #category : #actions }
GtImageSetup class >> cleanUpImageAfterLoad [
	self cleanUpMonticelloCaches.
	
	self 
		forPharo12: [] 
		forPharo11AndPharo10: [
			self cleanUpChangeSets.
			Smalltalk organization sortCategories. ].

	3
		timesRepeat: [ 
			Smalltalk garbageCollect.
			Symbol rehash ].

	Smalltalk garbageCollect
]

{ #category : #actions }
GtImageSetup class >> cleanUpMonticelloCaches [
	MCFileBasedRepository flushAllCaches.
	MCMethodDefinition shutDown.
]

{ #category : #actions }
GtImageSetup class >> copyDataAndDocsFolders [
	| gtoolkitRepoFolders docFolders icebergRepositories |
	GtResourcesUtilityConstants localGtDirectory asFileReference ensureCreateDirectory.
	
	('localGtDirectory: ', GtResourcesUtilityConstants localGtDirectory printString) traceCr.
	
	gtoolkitRepoFolders := (IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent.
	
	icebergRepositories := IceRepository registry reject: [ :aRepository | 
		aRepository name = 'zinc' or: [
			aRepository location isNil or: [ 
				(aRepository location parent = gtoolkitRepoFolders) not ] ] ].
	
	docFolders := OrderedCollection new.
	self addFoldersIn: icebergRepositories named: #('doc' 'data') into: docFolders.
	docFolders 
		add: (gtoolkitRepoFolders asFileReference / 'gtoolkit' / 'lepiter');
		add: (gtoolkitRepoFolders asFileReference / 'gt4llm' / 'lepiter');
		add: (gtoolkitRepoFolders asFileReference / 'lepiter' / 'test-data');
		add: (gtoolkitRepoFolders asFileReference / 'JSLink' / 'js');
		add: (gtoolkitRepoFolders asFileReference / 'gtoolkit-external-process' / 'tests').

	self copyDocFolders: docFolders.

	"JSLink needs to be told where to find its runtime files.
	This should be a FileLocator so that it uses the local location, not the CI's"

	JSLinkPharoPlatform runtimeSourceDirectory: GtResourcesUtilityConstants localGtDirectory / 'feenkcom/JSLink/js'.
]

{ #category : #utilities }
GtImageSetup class >> copyDocFolders: docFolders [
	docFolders do: [ :each |
		|icebergIndex size topSegments localPath|
		icebergIndex := each absolutePath segments indexOf: 'iceberg'.
		size := each absolutePath segments size.
		topSegments := each absolutePath segments asOrderedCollection copyFrom: (icebergIndex + 1) to: size.
		localPath := String streamContents: [ :stream | topSegments asStringOn: stream delimiter:'/'].
		
		('copying ', each printString, ' to ', localPath) traceCr.
		[each copyAllTo: (GtResourcesUtilityConstants localGtDirectory asFileReference / localPath) ] 
			on: FileExists 
			do: [ :e | e printString traceCr ]].
]

{ #category : #actions }
GtImageSetup class >> installGtSessionManager [
	GtSessionManager install
]

{ #category : #actions }
GtImageSetup class >> installLogo [
	GtWorldMenu setGtDesktopLogo.
]

{ #category : #actions }
GtImageSetup class >> installOmbuFileStore [
	"Force a new Ombu store for epicea changes of type OmFileStore.
	We change this as OmBlockFileStore is slown with large compiled methods."

	EpMonitor current disable.
	EpMonitor reset.
	
	OmStoreFactory 
		compile: 'newStoreNamed: aGlobalName in: aDirectory
	<gtPharoPatch: #Pharo>
	^ OmFileStore
		named: aGlobalName
		inDirectory: aDirectory'
		classified: 'gt-pharo-patch'.
	
	EpMonitor current enable
]

{ #category : #accessing }
GtImageSetup class >> notRegisteredSystemFFIMethods [
	| allFFIMethods allRegisteredMethods |
	allFFIMethods := SystemNavigation default 
		allMethodsSelect: [ :eachMethod | 
			eachMethod hasProperty: #ffiNonCompiledMethod ].
	
	allRegisteredMethods := FFIMethodRegistry 
		uniqueInstance compiledMethods.
		
	^ allFFIMethods difference: allRegisteredMethods.
]

{ #category : #actions }
GtImageSetup class >> patchForStringSymbolStringComparison [
	GtStrictSymbolInstallation new
		patchIcebergRepositories;
		refactorOCAbstractMethodScope
]

{ #category : #api }
GtImageSetup class >> performLocalSetup [
	"Perform a setup for images that should be used locally for development."
	
	self recordSpaceTallyAtBeginning.
	
	self installOmbuFileStore.

	self installLogo.
	self registerTools.
	self updateLocalVersion.
	self updateDocumentationDirectoryForLocalDevelopment.
	self cleanUpImageAfterLoad.
	self preparePharoCompletionCache.
	self installGtSessionManager.
	
	self 
		forPharo12: [] 
		forPharo11AndPharo10: [
			self registerGTNamespace.
			self patchForStringSymbolStringComparison ].
	
	self recordSpaceTallyAtEnd.
]

{ #category : #api }
GtImageSetup class >> performSetupForRelease [
	"Perform a setup for images that should be released. This should 
	be called on the CI server during the release process."
	
	self performSetupForRelease: 'patch'
]

{ #category : #api }
GtImageSetup class >> performSetupForRelease: aVersionComputationName [
	"Perform a setup for images that should be released. This should 
	be called on the CI server during the release process.
	
	aVersionComputationName must be one of the following:
	 - patch
	 - minor
	 - major"
	
	self recordSpaceTallyAtBeginning.
	
	self installOmbuFileStore.
	
	self copyDataAndDocsFolders.
	self captureRepositoryRegistryHistory.
	self installLogo.
	self registerTools.
	self updateNextReleaseVersion: (GtRlSemanticVersionComputation named: aVersionComputationName).
	self cleanUpImageAfterLoad.
	self preparePharoCompletionCache.
	self registerGTNamespace.
	self installGtSessionManager.
	self recordSpaceTallyAtEnd.
	self resetFFIMethods.
	self patchForStringSymbolStringComparison.
	
	self printNotRegisteredFFIMethods.
]

{ #category : #api }
GtImageSetup class >> preparePharoCompletionCache [
	GtPharoIndex initializeCache
]

{ #category : #api }
GtImageSetup class >> printNotRegisteredFFIMethods [
	self notRegisteredSystemFFIMethods 
		ifEmpty: [
			Stdio stderr 
				nextPutAll: ('GtImageSetup>>printNotRegisteredFFIMethods: all FFI methods are registered!');
				lf . ] 
		ifNotEmpty: [ :aCollection |
			Stdio stderr 
				nextPutAll: ('GtImageSetup>>printNotRegisteredFFIMethods: found {1} FFI methods not in the registry:'
					format: {aCollection size asString});
				lf.
			Stdio stderr 
				nextPutAll: (String streamContents: [ :s | 
					aCollection 
						do: [ :aMethod | s 
							tab;
							<< aMethod printString ] 
						separatedBy: [ s << String lf] ]);
				lf ]
]

{ #category : #api }
GtImageSetup class >> recordSpaceTallyAtBeginning [
	GtSpaceTallyHistory recordDefaultSystemWideDataLabeled: 'Image Setup Start'
]

{ #category : #api }
GtImageSetup class >> recordSpaceTallyAtEnd [
	GtSpaceTallyHistory recordDefaultSystemWideDataLabeled: 'Image Setup End'
]

{ #category : #actions }
GtImageSetup class >> registerGTNamespace [
	RBClassModelFactory setRBNamespace: GtRBNamespace
]

{ #category : #actions }
GtImageSetup class >> registerTools [
	GtMoldableDebugger register.
	GtPharoDebuggerElement register.
	GtMoldableExceptionDebuggingElement register.
	GtEmergencyDebugger register.
	GtInspectorToolRegistryAdaptor register.
	GtPlaygroundToolRegistryAdaptor register.
]

{ #category : #actions }
GtImageSetup class >> resetFFIMethods [
	FFIMethodRegistry resetAll.
	
	CompiledMethod allInstances do: [ :cm |
		(cm hasProperty: #ffiNonCompiledMethod) ifTrue:
			[ cm methodClass methodDict
				at: cm selector
				put: (cm propertyAt: #ffiNonCompiledMethod) ] ]
]

{ #category : #api }
GtImageSetup class >> updateDocumentationDirectoryForLocalDevelopment [
	LepiterCoreDefaults defaultDocumentationDirectory: FileLocator imageDirectory 
		/ 'pharo-local'
		/ 'iceberg'
]

{ #category : #actions }
GtImageSetup class >> updateLocalVersion [
	| theVersion |
	
	theVersion := GtImage computeCurrentGToolkitVersion asDevSemanticVersion. 
	
	GtImage version: theVersion.
	GtImage timestamp: DateAndTime now
]

{ #category : #actions }
GtImageSetup class >> updateNextReleaseVersion: aVersionComputation [
	| theVersion |
	
	theVersion := GtImage computeNextGToolkitVersion: aVersionComputation.
	GtImage version: theVersion.
	GtImage timestamp: DateAndTime now.
]
