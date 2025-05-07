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
Monitor >> copyLinkedList: aLinkedList to: listContents [
	"Safely copy the elements from the supplied linked list to the supplied OrderedCollection.
	If an error occurs while copying, presumably because a higher priority process has modified the list during traversal, simply return the elements so far."

	[ aLinkedList do: [ :each | listContents add: each ] ]
		on: Error
		do: [ "nothing" ]
]

{ #category : #'*GToolkit-Extensions' }
Monitor >> critical: aBlock [
	"Critical section.
	Executes aBlock as a critical section. At any time, only one process can be executing code
	in a critical section.
	NOTE: All the following synchronization operations are only valid inside the critical section
	of the monitor!"
	| requestingProcess caught |

	requestingProcess := Processor activeProcess.
	caught := false.
	^ [ "See Semaphore>>critical: for a description of the structure of the code below."
	requestingProcess == ownerProcess ifTrue: [
		"Don't move the caught assignment outside the ifTrue:ifFalse, see below"
		caught := true.
		nestingLevel := nestingLevel + 1.
	] ifFalse: [
		"Only one process should be able to enter the critical: section at a time,
		however there is obviously a window where terminating a process can allow two
		processes in at the same time.
		Protect against this by rewaiting if someone else owns the monitor."
		[ "Set caught immediately before the mutex wait to ensure both are executed as an atomic operation"
		caught := true.
		mutex wait] doWhileFalse: [ ownerProcess isNil ].
		ownerProcess := requestingProcess.
		nestingLevel := 1. ].
	aBlock value ] ensure:
		"The critical section is only exited if:
		1. the ensured block was entered (caught), and
		2. the process exiting was the owning process
		If the process being terminted was waiting on the monitor (caught) and there is no
		current owner, the mutex needs to be signalled to reestablish the excess signal."
		[ caught ifTrue: [ requestingProcess == ownerProcess
			ifTrue: [ self exit ]
			ifFalse: [ ownerProcess ifNil: [ mutex signal ] ] ] ].
]

{ #category : #'*GToolkit-Extensions' }
Monitor >> stateString [
	"Answer a string that details the internal state of the receiver,
	e.g. for when reporting errors.
	Note:
	- This method may be called when the receiver is in a broken state, i.e. there are two processes within the critical section, so must deal with the state changing while within this method.
	- The list of processes waiting on the receiver may change while the string is being constructed.  The queue of processes is a best effort attempt, but may be missing entries."

	^ String streamContents: [ :stream | | listContents |
		stream
			<< 'Mutex:';
			tab; << 'Excess Signals: ';
				print: mutex excessSignalCount; lf;
			tab; << 'Size: ';
				print: mutex size; lf;
			tab; << 'Queue:'; lf.
		listContents := OrderedCollection new.
		self copyLinkedList: mutex to: listContents.
		listContents do: [ :proc |
			stream
				tab; tab; print: { proc name. proc priority. proc identityHash. }; lf.
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
				tab; << 'priority, identityHash: ';
					print: { proc priority. proc identityHash. }; lf.
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
				listContents := OrderedCollection new.
				self copyLinkedList: semaphore to: listContents.
				listContents do: [ :proc |
					stream
						tab; tab; print: { proc name. proc priority. proc identityHash. }; lf.
					proc suspendedContext printDebugOn: stream.
					stream lf; tab; tab; << '------'; lf ] ].
			stream tab; << '------'; lf ].
		stream
			<< 'Queue Dictionary: ';
				print: queueDict; lf;
			<< 'Queues Mutex: ';
				print: queuesMutex; lf ].
]
