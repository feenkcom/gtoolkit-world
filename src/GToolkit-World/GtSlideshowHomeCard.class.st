Class {
	#name : #GtSlideshowHomeCard,
	#superclass : #GtJobHomeCard,
	#instVars : [
		'slideshowClassSymbol',
		'baseLineName',
		'repo',
		'loadLepiterBaseline'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtSlideshowHomeCard >> baseLineName [
	^ baseLineName
]

{ #category : #running }
GtSlideshowHomeCard >> block [
	^ [ :aButton :aModel :anEvent | 
	Smalltalk globals
		at: self slideshowClassSymbol
		ifAbsent: [ Metacello new
				baseline: self baseLineName;
				repository: self repo;
				load.
			loadLepiterBaseline ifNotNil: [ loadLepiterBaseline asClass loadLepiter ] ].
	self spawnSlideshowFor: aButton.
	self updateGtWorld ]
]

{ #category : #running }
GtSlideshowHomeCard >> defaultAction [
	"NB: if repo is missing load it using the parent defaultAction"
	^ [ :aButton :aModel :anEvent | 
	self invariant
		ifTrue: [ Smalltalk globals
				at: self slideshowClassSymbol
				ifPresent: [ self spawnSlideshowFor: aButton ]
				ifAbsent: [ super defaultAction
						value: aButton
						value: aModel
						value: anEvent ] ]
		ifFalse: [ self reportInvariantFailed ] ]
]

{ #category : #invariant }
GtSlideshowHomeCard >> invariant [
	^ self nilSlots isEmpty
]

{ #category : #accessing }
GtSlideshowHomeCard >> loadLepiterBaseline [
	^ loadLepiterBaseline
]

{ #category : #invariant }
GtSlideshowHomeCard >> nilSlots [
	^ {#slideshowClassSymbol.
		#baseLineName.
		#repo} select: [ :sel | (self perform: sel) isNil ]
]

{ #category : #accessing }
GtSlideshowHomeCard >> repo [
	^ repo
]

{ #category : #invariant }
GtSlideshowHomeCard >> reportInvariantFailed [
	^ self
		inform: self class name , ' slots must not be nil:'
				, (', ' join: (self nilSlots collect: #printString))
]

{ #category : #accessing }
GtSlideshowHomeCard >> slideshowClassSymbol [
	^ slideshowClassSymbol
]

{ #category : #initialization }
GtSlideshowHomeCard >> slideshowClassSymbol: aSlideshowSymbol baseLineName: aBaselineName repo: aGithubRepo [
	slideshowClassSymbol := aSlideshowSymbol.
	baseLineName := aBaselineName.
	repo := aGithubRepo
]

{ #category : #initialization }
GtSlideshowHomeCard >> slideshowClassSymbol: aSlideshowSymbol baseLineName: aBaselineName repo: aGithubRepo loadLepiterBaseline: aBaselineSymbol [
	self
		slideshowClassSymbol: aSlideshowSymbol
		baseLineName: aBaselineName
		repo: aGithubRepo.

	loadLepiterBaseline := aBaselineSymbol
]

{ #category : #running }
GtSlideshowHomeCard >> spawnSlideshowFor: aButton [
	self spawnObject: self slideshowClassSymbol asClass new from: aButton
]
