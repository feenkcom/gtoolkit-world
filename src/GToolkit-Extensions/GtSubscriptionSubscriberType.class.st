Class {
	#name : #GtSubscriptionSubscriberType,
	#superclass : #Object,
	#instVars : [
		'subscribers',
		'type'
	],
	#category : #'GToolkit-Extensions'
}

{ #category : #'instance  creation' }
GtSubscriptionSubscriberType class >> type: aClass subscribers: aCollectionOfSubscriptionSubscriber [
	^ self new
		type: aClass;
		subscribers: aCollectionOfSubscriptionSubscriber
]

{ #category : #accessing }
GtSubscriptionSubscriberType >> subscribers [
	^ subscribers
]

{ #category : #accessing }
GtSubscriptionSubscriberType >> subscribers: aCollection [
	subscribers := aCollection sort: [ :a :b | 
		a subscriber printString < b subscriber printString ]
]

{ #category : #accessing }
GtSubscriptionSubscriberType >> type [
	^ type
]

{ #category : #accessing }
GtSubscriptionSubscriberType >> type: anObject [
	type := anObject
]
