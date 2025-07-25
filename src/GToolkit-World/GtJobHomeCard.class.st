"
I am a card that runs a block as an asynchronous job.
I store the process id and warning the user if a job is already running

See {{gtMethod:name=GtHomeCardExamples>>#jobCard}}
"
Class {
	#name : #GtJobHomeCard,
	#superclass : #GtHomeCard,
	#instVars : [
		'block',
		'mutex',
		'process'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtJobHomeCard >> block [
	^ block
]

{ #category : #accessing }
GtJobHomeCard >> block: anObject [
	block := anObject
]

{ #category : #running }
GtJobHomeCard >> defaultAction [
	"Something is wrong here -- a mutex critical: within a mutex critical: makes no sense."

	^ [ :aButton :aModel :anEvent | 
	mutex
		critical: [ process
				ifNil: [ process := [ [ :job | 
						job title: self title.
						self block argumentCount = 0 ifTrue: [ self block value ].
						self block argumentCount = 1 ifTrue: [ self block value: aButton ].
						self block argumentCount = 3
							ifTrue: [ self block
									value: aButton
									value: aModel
									value: anEvent ].
						mutex critical: [ process := nil ] ] asJob run ] fork ]
				ifNotNil: [ self inform: 'A job is already running!' ] ] ]
]

{ #category : #initalization }
GtJobHomeCard >> initialize [
	super initialize.
	mutex := Mutex new
]
