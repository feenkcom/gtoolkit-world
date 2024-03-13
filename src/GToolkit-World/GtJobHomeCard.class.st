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

{ #category : #running }
GtJobHomeCard >> action [
	^ [ :aButton :aModel :anEvent | 
	mutex
		critical: [ process
				ifNil: [ process := [ [ :job | 
						job title: self title.
						self block value.
						mutex critical: [ process := nil ] ] asJob run ] fork ]
				ifNotNil: [ self inform: 'A job is already running!' ] ] ]
]

{ #category : #accessing }
GtJobHomeCard >> block [
	^ block
]

{ #category : #accessing }
GtJobHomeCard >> block: anObject [
	block := anObject
]

{ #category : #initalization }
GtJobHomeCard >> initialize [
	super initialize.
	mutex := Monitor new
]
