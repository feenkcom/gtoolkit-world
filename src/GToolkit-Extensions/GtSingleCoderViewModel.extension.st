Extension { #name : #GtSingleCoderViewModel }

{ #category : #'*GToolkit-Extensions' }
GtSingleCoderViewModel >> gtCoderModelSubscriptions [
	"Return my coder model subscriptions"

	^ self hasCoder
		ifTrue: [ Array
				streamContents: [ :aStream | 
					self coderModel announcer subscriptions
						subscriptionsOf: self
						do: [ :eachSubscription | aStream nextPut: eachSubscription ] ] ]
		ifFalse: [ Array empty ]
]

{ #category : #'*GToolkit-Extensions' }
GtSingleCoderViewModel >> gtCoderModelSubscriptionsViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Coder model subscriptions';
		items: [ self gtCoderModelSubscriptions ];
		column: 'Announcement' text: [ :each | each announcementClass ];
		column: 'Action'
			text: [ :each | each action ]
			weight: 2
]
