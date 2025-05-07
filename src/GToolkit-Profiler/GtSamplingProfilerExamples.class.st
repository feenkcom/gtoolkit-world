Class {
	#name : #GtSamplingProfilerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Profiler'
}

{ #category : #accessing }
GtSamplingProfilerExamples >> createSpyAllOn [
	<gtExample>
	<return: #AsyncFuturePromise>
	| tally |
	tally := GtSamplingProfiler spyAllProcessesFor: 2 seconds.
	^ tally
]
