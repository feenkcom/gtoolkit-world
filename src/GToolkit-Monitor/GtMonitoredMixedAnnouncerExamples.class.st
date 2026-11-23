"
I show how {{gtClass:GtMonitoredMixedAnnouncer}} and {{gtClass:GtMonitoredMixedAnnouncersElement}} classify the subscriptions of an announcer. They ask the registry ({{gtMethod:SubscriptionRegistry>>#allStrongSubscriptions}}, {{gtMethod:SubscriptionRegistry>>#allWeakSubscriptions}}, {{gtMethod:SubscriptionRegistry>>#hasLeakProneSubscriptionMix}}), so an announcer using a {{gtClass:GtMixedSubscriptionRegistry}}, where mixing strong and weak subscriptions is safe, is not reported.
"
Class {
	#name : #GtMonitoredMixedAnnouncerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Monitor'
}

{ #category : #examples }
GtMonitoredMixedAnnouncerExamples >> makeWeakAndStrongOfMixedRegistryAnnouncer [
	<gtExample>
	| anAnnouncer aSubscriber aMonitoredAnnouncer |
	anAnnouncer := Announcer new useMixedSubscriptionRegistry.
	aSubscriber := OrderedCollection new.
	anAnnouncer when: JobStart send: #add: to: aSubscriber.
	anAnnouncer
		when: JobStart
		do: [:anAnnouncement | aSubscriber add: anAnnouncement]
		for: aSubscriber.
	aMonitoredAnnouncer := GtMonitoredMixedAnnouncer new
				announcer: anAnnouncer.
	aMonitoredAnnouncer makeWeak.
	self assert: aMonitoredAnnouncer numberOfWeakSubscriptions equals: 2.
	self assert: aMonitoredAnnouncer numberOfStrongSubscriptions equals: 0.
	aMonitoredAnnouncer makeStrong.
	self assert: aMonitoredAnnouncer numberOfWeakSubscriptions equals: 0.
	self assert: aMonitoredAnnouncer numberOfStrongSubscriptions equals: 2.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber size equals: 2.
	^aMonitoredAnnouncer
]

{ #category : #examples }
GtMonitoredMixedAnnouncerExamples >> mixedRegistryAnnouncerIsNotReported [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber aMonitoredAnnouncer |
	anAnnouncer := Announcer new useMixedSubscriptionRegistry.
	aStrongSubscriber := OrderedCollection new.
	aWeakSubscriber := OrderedCollection new.
	anAnnouncer when: JobStart send: #add: to: aStrongSubscriber.
	anAnnouncer weak when: JobStart send: #add: to: aWeakSubscriber.
	self
		assert: (GtMonitoredMixedAnnouncersElement
				hasMultipleSubscriptionTypesFor: anAnnouncer) not.
	self
		assert: (GtMonitoredMixedAnnouncersElement
				hasSubscriptionWithNonWeakActionTypesFor: anAnnouncer) not.
	aMonitoredAnnouncer := GtMonitoredMixedAnnouncer new
				announcer: anAnnouncer.
	self assert: aMonitoredAnnouncer numberOfSubscriptions equals: 2.
	self assert: aMonitoredAnnouncer numberOfStrongSubscriptions equals: 1.
	self assert: aMonitoredAnnouncer numberOfWeakSubscriptions equals: 1.
	^aMonitoredAnnouncer
]

{ #category : #examples }
GtMonitoredMixedAnnouncerExamples >> plainAnnouncerWithStrongAndWeakSubscriptionsIsReported [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber aMonitoredAnnouncer |
	anAnnouncer := Announcer new.
	aStrongSubscriber := OrderedCollection new.
	aWeakSubscriber := OrderedCollection new.
	anAnnouncer when: JobStart send: #add: to: aStrongSubscriber.
	anAnnouncer weak when: JobStart send: #add: to: aWeakSubscriber.
	self assert: (GtMonitoredMixedAnnouncersElement
				hasMultipleSubscriptionTypesFor: anAnnouncer).
	aMonitoredAnnouncer := GtMonitoredMixedAnnouncer new
				announcer: anAnnouncer.
	self assert: aMonitoredAnnouncer numberOfSubscriptions equals: 2.
	self assert: aMonitoredAnnouncer numberOfStrongSubscriptions equals: 1.
	self assert: aMonitoredAnnouncer numberOfWeakSubscriptions equals: 1.
	self
		assert: aMonitoredAnnouncer numberOfWeakSubscriptionsWithWeakSendAction
		equals: 1.
	^aMonitoredAnnouncer
]
