Class {
	#name : #GtTextualCoderSubscriptionOverview,
	#superclass : #Object,
	#instVars : [
		'textualCoderViewModel',
		'subscriber'
	],
	#category : #'GToolkit-Extensions-Utilities'
}

{ #category : #accessing }
GtTextualCoderSubscriptionOverview >> coderModelSystemSubscriptions [
	^ self textualCoderViewModel coderModel systemSubscriptions
]

{ #category : #views }
GtTextualCoderSubscriptionOverview >> gtCoderModelSubscriptionsViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Coder model subscriptions';
		priority: 15;
		items: [ self textualCoderModelSubscriptions ];
		column: 'Announcement' text: [ :each | each announcementClass ];
		column: 'Action'
			text: [ :each | each action ]
			weight: 2
]

{ #category : #'as yet unclassified' }
GtTextualCoderSubscriptionOverview >> gtCoderViewModelSubscriptionsViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Coder view model subscriptions';
		priority: 10;
		items: [ self textualCoderViewModelSubscriptions ];
		column: 'Announcement' text: [ :each | each announcementClass ];
		column: 'Action'
			text: [ :each | each action ]
			weight: 2
]

{ #category : #'as yet unclassified' }
GtTextualCoderSubscriptionOverview >> gtSystemSubscriptionsViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'System subscriptions';
		priority: 20;
		items: [ self coderModelSystemSubscriptions ];
		column: 'Announcement' text: [ :each | each announcementClass ];
		column: 'Action'
			text: [ :each | each action ]
			weight: 2
]

{ #category : #accessing }
GtTextualCoderSubscriptionOverview >> subscriber [
	^ subscriber
]

{ #category : #accessing }
GtTextualCoderSubscriptionOverview >> subscriber: anObject [
	subscriber := anObject
]

{ #category : #accessing }
GtTextualCoderSubscriptionOverview >> textualCoderModelSubscriptions [
	^ Array
		streamContents: [ :aStream | 
			self textualCoderViewModel coderModel announcer subscriptions
				subscriptionsOf: self subscriber
				do: [ :eachSubscription | aStream nextPut: eachSubscription ] ]
]

{ #category : #accessing }
GtTextualCoderSubscriptionOverview >> textualCoderViewModel [
	^ textualCoderViewModel
]

{ #category : #accessing }
GtTextualCoderSubscriptionOverview >> textualCoderViewModel: anObject [
	textualCoderViewModel := anObject
]

{ #category : #accessing }
GtTextualCoderSubscriptionOverview >> textualCoderViewModelSubscriptions [
	^ Array
		streamContents: [ :aStream | 
			self textualCoderViewModel announcer subscriptions
				subscriptionsOf: self subscriber
				do: [ :eachSubscription | aStream nextPut: eachSubscription ] ]
]
