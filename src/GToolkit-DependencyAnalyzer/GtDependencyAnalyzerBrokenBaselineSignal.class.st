Class {
	#name : #GtDependencyAnalyzerBrokenBaselineSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'exception',
		'baseline'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtDependencyAnalyzerBrokenBaselineSignal >> baseline [
	^ baseline
]

{ #category : #accessing }
GtDependencyAnalyzerBrokenBaselineSignal >> baseline: anObject [
	baseline := anObject
]

{ #category : #accessing }
GtDependencyAnalyzerBrokenBaselineSignal >> exception [
	^ exception
]

{ #category : #accessing }
GtDependencyAnalyzerBrokenBaselineSignal >> exception: anObject [
	exception := anObject
]

{ #category : #initialize }
GtDependencyAnalyzerBrokenBaselineSignal >> prepareForDelivery [
	super prepareForDelivery.

	exception := GtSystemUtility freeze: exception
]

{ #category : #printing }
GtDependencyAnalyzerBrokenBaselineSignal >> printOneLineContentsOn: aStream [
	aStream print: baseline.
	aStream nextPutAll: ': '.
	aStream print: exception.
	aStream space.

	super printOneLineContentsOn: aStream
]
