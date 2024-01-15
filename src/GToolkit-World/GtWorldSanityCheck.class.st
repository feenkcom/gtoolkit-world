Class {
	#name : #GtWorldSanityCheck,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #accessing }
GtWorldSanityCheck class >> checkImage: aFileReference [
	"Run the receiver in the supplied image using the current VM."
	| vm arguments proc timedOut pharoDebug |

	pharoDebug := Smalltalk logFileName asFileReference.
	self assert: pharoDebug exists not.
	vm := LanguageLinkSettings pharoDefaultSettings serverExecutable.
	arguments := {
		'--interactive'.
		aFileReference fullName.
		'eval'.
		'GtWorldSanityCheck'.
		'new'.
		'checkImage'.
		'--detachChangesFromFileSystem'.
		'--epiceaMemoryStore'.
		'--noLepiterReload'.
		'--noGtImageUpdate'.
		}.
	proc := GtSubprocessWithInMemoryOutput
		command: vm fullName
		arguments: arguments.
	proc runAndSignal.
	timedOut := proc waitTimeoutMSecs: 5 * 60 * 1000.
	timedOut ifTrue:
		[ self error: 'Check image process didn''t complete in time' ].
	proc isSuccess ifFalse:
		[ self error: 'Check image process didn''t succeed' ].
	(proc stdout includesSubstring: 'GtWorldSanityCheck pass') ifFalse:
		[ self error: 'Check image process didn''t pass' ].
	pharoDebug exists ifTrue:
		[ self error: 'PharoDebug log file present after running checks' ].
]

{ #category : #accessing }
GtWorldSanityCheck class >> checkOnDiskImage [
	"Confirm that the on-disk image opens.
	The image must be able to be run interactively."

	self checkImage: Smalltalk imageFile resolve
]

{ #category : #checking }
GtWorldSanityCheck >> checkImage [
	| image gtw screenshot |

	[ gtw := GtWorld allInstances anyOne.
	self assert: gtw isOpened.
	screenshot := gtw root exportAsPNG.
	self assert: screenshot exists.
	image := ImageReadWriter gtFormFromFileReference:  screenshot.
	self assert: (image width between: 600 and: 2000).
	self assert: (image height between: 400 and: 2000).
	Stdio stdout lf; << 'GtWorldSanityCheck pass'; lf ]
		on: Exception
		do: [ :ex |
			Stdio stdout 
				lf; 
				<< 'GtWorldSanityCheck failed: ';
				<< ex printString;
				lf.
			Smalltalk exit: 1 ].
	Smalltalk exit: 0.
]
