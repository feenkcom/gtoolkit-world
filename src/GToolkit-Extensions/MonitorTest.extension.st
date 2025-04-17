Extension { #name : #MonitorTest }

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> fork: aBlock [
	| newProcess |
	newProcess := aBlock forkNamed: testSelector.
	forkedProcesses add: newProcess.
	^newProcess
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> fork: aBlock at: priority [
	| newProcess |

	newProcess := aBlock forkAt: priority named: testSelector.
	forkedProcesses add: newProcess.
	^newProcess
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> fork: aBlock at: priority named: aString [
	| newProcess |

	newProcess := aBlock forkAt: priority named: aString, '-', testSelector.
	forkedProcesses add: newProcess.
	^newProcess
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> fork: aBlock named: aString [
	| newProcess |
	newProcess := aBlock forkNamed: aString, '-', testSelector.
	forkedProcesses add: newProcess.
	^newProcess
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> setUp [
	super setUp.

	forkedProcesses := OrderedCollection new.
	monitor := Monitor new.
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> tearDown [
	forkedProcesses do: #terminate.
	super tearDown
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> testFailedCriticalSectionShouldUnblockWaitingOne [
	| lastCriticalExecuted semaphoreToHoldMutex |
	lastCriticalExecuted := false.
	semaphoreToHoldMutex := Semaphore new.
	self fork: [
		[
		monitor critical: [
			semaphoreToHoldMutex wait. "here we grab mutex and control it with semaphore"
			self error: 'critical section failed' ] ] onErrorDo: [  ] ].
	self waitLastProcessLock. "wait until first process grabs the mutex"

	self fork: [ monitor critical: [ lastCriticalExecuted := true ] ].
	self waitLastProcessLock.

	semaphoreToHoldMutex signal.
	self waitLastProcessTerminate.
	self assert: lastCriticalExecuted
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> testTerminatedCriticalSectionShouldUnblockWaitingOne [
	| lastCriticalExecuted semaphoreToHoldMutex processHoldingMutex |
	lastCriticalExecuted := false.
	semaphoreToHoldMutex := Semaphore new.

	processHoldingMutex := self fork: [
		monitor critical: [ semaphoreToHoldMutex wait. "here we grab mutex and control it with semaphore"
		self error: 'should not happen' ]].
	self waitLastProcessLock.

	self fork: [monitor critical: [ lastCriticalExecuted := true ]].
	self waitLastProcessLock.

	processHoldingMutex terminate.
	self waitLastProcessTerminate.
	self assert: lastCriticalExecuted
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> testTerminatingBlockedCriticalSectionShouldNotUnblockAnotherWaitingSection [
	| semaphoreToHoldMutex holdingCriticalExecutedFirst firstWaitingProcess lastCriticalExecuted |
	holdingCriticalExecutedFirst := false.
	semaphoreToHoldMutex := Semaphore new.
	lastCriticalExecuted := false.
	self fork: [
		monitor critical: [ semaphoreToHoldMutex wait. "here we grab mutex and control it with semaphore"
		holdingCriticalExecutedFirst := lastCriticalExecuted not ]].
	self waitLastProcessLock.

	firstWaitingProcess := self fork: [monitor critical: [ self error: 'should not happen' ]].
	self waitLastProcessLock.
	self fork: [monitor critical: [ lastCriticalExecuted := true]].
	self waitLastProcessLock.
	firstWaitingProcess terminate.
	self waitLastProcessLock. "check that last process is still waiting"
	semaphoreToHoldMutex signal. "here we resume first process execution"
	self waitLastProcessTerminate.
	self assert: holdingCriticalExecutedFirst.
	self assert: lastCriticalExecuted
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> testTerminatingBlockedCriticalWhichWasSignalledButNotResumedYet [
	| processWaitingForMutex firstCriticalExecuted lastCriticalExecuted semaphoreToHoldMutex |
	firstCriticalExecuted := false.
	lastCriticalExecuted := false.
	semaphoreToHoldMutex := Semaphore new.
	self fork: [
		monitor critical: [ semaphoreToHoldMutex wait.
		firstCriticalExecuted := true ]] 
			at: Processor activeProcess priority + 1
			named: 'P1'.
	self waitLastProcessLock.
	"for second critical we choose small priority. So it can't be resumed automatically by scheduler in our scenario."
	processWaitingForMutex := self fork: [monitor critical: [ self error: 'should not happen' ]] 
		at: Processor activeProcess priority - 1
		named: 'P2'.
	self waitLastProcessLock.
	self deny: firstCriticalExecuted.
	semaphoreToHoldMutex signal.
	self assert: firstCriticalExecuted.
	processWaitingForMutex terminate. "Here the process waits for monitor and being terminated at the point when monitor was already signalled but process was not resumed.
		Correct critical implementation should allow execution of new consequent criticals"
	self fork: [ monitor critical: [ lastCriticalExecuted := true ]]
		named: 'P3'.
	self waitLastProcessTerminate.
	self assert: lastCriticalExecuted description: 'consequent last critical should be executed'
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> waitFor: aBlock [

	[ 10 milliSeconds wait. aBlock value ] whileFalse
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> waitLastProcessLock [

	self waitProcessLock: forkedProcesses last
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> waitLastProcessSuspend [

	self waitProcessSuspend: forkedProcesses last
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> waitLastProcessTerminate [

	self waitProcessTermination: forkedProcesses last
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> waitProcessLock: aProcess [

	self waitFor: [ aProcess suspendingList isEmptyOrNil not ]
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> waitProcessSuspend: aProcess [

	self waitFor: [ aProcess isSuspended ]
]

{ #category : #'*GToolkit-Extensions' }
MonitorTest >> waitProcessTermination: aProcess [

	self waitFor: [ aProcess isTerminated ]
]
