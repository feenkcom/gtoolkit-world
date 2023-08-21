Class {
	#name : #GtMonitoredScripter,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'pulsers'
	],
	#category : #'GToolkit-Monitor-Scripter'
}

{ #category : #accessing }
GtMonitoredScripter >> children [
	^ pulsers ifNil: [ #() ]
]

{ #category : #accessing }
GtMonitoredScripter >> pulsers [
	^ pulsers ifNil: [ #() ]
]

{ #category : #accessing }
GtMonitoredScripter >> pulsers: anObject [
	pulsers := anObject
]

{ #category : #accessing }
GtMonitoredScripter >> scripter [
	^ scripter
]

{ #category : #accessing }
GtMonitoredScripter >> scripter: anObject [
	scripter := anObject
]

{ #category : #accessing }
GtMonitoredScripter >> startTime [
	^ self pulsers min: #startTime
]

{ #category : #accessing }
GtMonitoredScripter >> status [
	^ '{1} pulsers' format: {self pulsers size}
]

{ #category : #accessing }
GtMonitoredScripter >> title [
	^ 'Scripter'
]
