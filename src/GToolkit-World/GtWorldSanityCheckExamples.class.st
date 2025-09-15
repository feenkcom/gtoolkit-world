Class {
	#name : #GtWorldSanityCheckExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #utils }
GtWorldSanityCheckExamples >> createSanityCheckCommandString [
	^ '{1} --interactive {2} clap eval GtWorldSanityCheck new checkImage -- --detachChangesFromFileSystem --epiceaMemoryStore --noLepiterReload --noGtImageUpdate' format:  {
			LanguageLinkSettings pharoDefaultSettings serverExecutable fullName.
			Smalltalk imageFile resolve fullName}
]

{ #category : #examples }
GtWorldSanityCheckExamples >> sanityCheckProcessCreation [
	<gtExample>
	| processBuilder  |
	
	processBuilder := GtWorldSanityCheck 
		createCheckProcessForImageFile: Smalltalk imageFile resolve.
		
	self 
		assert: (processBuilder commandLineString 
			includesSubstring: 'GtWorldSanityCheck new checkImage')
		description: 'Command line should include call to check image'.
	
	self 
		assert: (processBuilder commandLineString 
			includesSubstring: 'clap eval')
		description: 'Command line should use clap'.
		
	self 
		assert: processBuilder commandLineString
		equals: self createSanityCheckCommandString.
		
	^ processBuilder
]

{ #category : #examples }
GtWorldSanityCheckExamples >> verifyRunChecksForScripterSpace [
	<gtExample>
	| scripter screenshot |
	
	scripter := BlScripter new 
		element: GtWorldElement new.
		
	screenshot := GtWorldSanityCheck new 
		runScreenshotChecksForWorld: scripter space.
	screenshot ensureDelete.
		
	^ scripter.
]
