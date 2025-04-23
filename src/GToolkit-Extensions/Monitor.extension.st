Extension { #name : #Monitor }

{ #category : #'*GToolkit-Extensions' }
Monitor >> assertIsOwner [
	"Assert that the calling process is the owner of the receiver.
	Synonymous with #checkOwnerProcess, for Mutex compatibility."

	self isOwnerProcess ifFalse:
		[ self error: 'Monitor: current process is not owner', String cr, self stateString ].
]

{ #category : #'*GToolkit-Extensions' }
Monitor >> assertNotNested [
	"Confirm that the caller owns the receiver and that there aren't nested critical sections."

	self assertIsOwner.
	nestingLevel = 1 ifFalse:
		[ self error: 'Monitor nestingLevel ~= 1', String cr, self stateString ].
]

{ #category : #'*GToolkit-Extensions' }
Monitor >> critical: aBlock [
	"Critical section.
	Executes aBlock as a critical section. At any time, only one process can be executing code
	in a critical section.
	NOTE: All the following synchronization operations are only valid inside the critical section
	of the monitor!"
	| requestingProcess blockValue caught |

	requestingProcess := Processor activeProcess.
	caught := false.
	[ 
	"See Semaphore>>critical: for a description of the structure of the code below."
	requestingProcess == ownerProcess ifTrue: [
		"Don't move the caught assignment outside the ifTrue:ifFalse, see below"
		caught := true.
		nestingLevel := nestingLevel + 1.
	] ifFalse: [
		"Set caught immediately before the mutex wait to ensure the process isn't interrupted"
		caught := true.
		mutex wait.
		ownerProcess := requestingProcess.
		nestingLevel := 1.
	].

	blockValue := aBlock value ] ensure:
		[ caught ifTrue: [ requestingProcess == ownerProcess
			ifTrue: [ self exit ]
			ifFalse: [ (ownerProcess == nil and: [ nestingLevel = 0 ])
				ifTrue: [ mutex signal ] ] ] ].
	^ blockValue
]

{ #category : #'*GToolkit-Extensions' }
Monitor >> stateString [
	"Answer a string that details the internal state of the receiver,
	e.g. for when reporting errors.
	Note that this method may be called when the receiver is in a broken state, i.e. there are two processes within the critical section, so must deal with the state changing while within this method."

	^ String streamContents: [ :stream |
		stream
			<< 'Mutex:';
			tab; << 'Excess Signals: ';
				print: mutex excessSignalCount; lf;
			tab; << 'Size: ';
				print: mutex size; lf;
			tab; << 'Queue:'; lf.
		mutex asArray do: [ :proc |
			stream
				tab; tab; print: proc name; lf;
				tab; tab; print: proc id; lf.
			proc suspendedContext printDebugOn: stream.
			stream lf; tab; tab; << '------'; lf ].
		stream tab; << '------'; lf.
		stream << 'ownerProcess:'.
		ownerProcess ifNil:
			[ stream << ' nil'; lf ]
		ifNotNil: [ :proc |
			stream lf
				tab; << 'name: ';
					print: proc name; lf;
				tab; << 'id: ';
					print: proc id; lf.
			proc suspendedContext printDebugOn: stream.
			stream lf; << '-----'; lf. ].
		stream
			<< 'Nesting Level: ';
				print: nestingLevel; lf;
			<< 'Default Queue: '.
		defaultQueue ifNil:
			[ stream << 'nil'; lf ]
		ifNotNil:
			[ stream lf.
			defaultQueue do: [ :semaphore |
				stream tab; << 'Entry: '; print: semaphore; lf.
				semaphore asArray do: [ :proc |
					stream
						tab; tab; print: proc name; lf;
						tab; tab; print: proc id; lf.
					proc suspendedContext printDebugOn: stream.
					stream lf; tab; tab; << '------'; lf ] ].
			stream tab; << '------'; lf ].
		stream
			<< 'Queue Dictionary: ';
				print: queueDict; lf;
			<< 'Queues Mutex: ';
				print: queuesMutex; lf ].
]
