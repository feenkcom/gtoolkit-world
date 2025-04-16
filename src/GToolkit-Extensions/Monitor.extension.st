Extension { #name : #Monitor }

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

	blockValue := aBlock value ]
		ensure: [ (caught and: [ requestingProcess == ownerProcess ])
			ifTrue: [ self exit ] ].
	^ blockValue
]
