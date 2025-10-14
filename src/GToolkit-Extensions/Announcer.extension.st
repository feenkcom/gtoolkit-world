Extension { #name : #Announcer }

{ #category : #'*GToolkit-Extensions' }
Announcer >> gtSubscriptionsPerSubscriberFor: aView [
	<gtView>
	self subscriptions ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Per subscriber';
		priority: 51;
		expandUpTo: 1;
		items: [ GtSubscriptionSubscriber fromAnnouncer: self ];
		children: [ :each | 
			(each isKindOf: GtSubscriptionSubscriberType)
				ifTrue: [ each subscribers size = 1
					ifTrue: [ each subscribers first subscriptions ]
					ifFalse: [ each subscribers ] ]
				ifFalse: [
					(each isKindOf: GtSubscriptionSubscriber)
						ifTrue: [ each subscriptions ]
						ifFalse: [ Array empty ] ] ];
		actionUpdateButtonTooltip: 'Update subscription list';
		column: 'Subscriber' text: [ :aSubscription | 
			(aSubscription isKindOf: GtSubscriptionSubscriberType)
				ifTrue: [ aSubscription subscribers size = 1
					ifTrue: [ aSubscription subscribers first subscriber ]
					ifFalse: [ aSubscription type ] ]
				ifFalse: [
					(aSubscription isKindOf: GtSubscriptionSubscriber)
						ifTrue: [ aSubscription subscriber ]
						ifFalse: [ '' ] ] ];
		column: 'Announcement' text: [ :aSubscription |
			((aSubscription isKindOf: GtSubscriptionSubscriber)
				or: [ aSubscription isKindOf: GtSubscriptionSubscriberType ])
					ifTrue: [ '{1} subscriptions' format: { aSubscription subscriptionsCount } ]
					ifFalse: [ aSubscription announcementClass ] ];
		column: 'Kind' text: [ :aSubscription | 
			((aSubscription isKindOf: GtSubscriptionSubscriber)
				or: [ aSubscription isKindOf: GtSubscriptionSubscriberType ])
					ifTrue: [ '' ]
					ifFalse: [ aSubscription class ] ];
		send: [ :aSubscription | 
			(aSubscription isKindOf: GtSubscriptionSubscriberType)
				ifTrue: [ aSubscription subscribers size = 1
					ifTrue: [ aSubscription subscribers first subscriber ]
					ifFalse: [ aSubscription subscribers ] ]
				ifFalse: [
					(aSubscription isKindOf: GtSubscriptionSubscriber)
						ifTrue: [ aSubscription subscriber ]
						ifFalse: [ aSubscription ] ] ]
]
