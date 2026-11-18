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

{ #category : #'*GToolkit-Extensions' }
GtSingleCoderViewModel >> gtOptionsFor: aView [
	<gtView>
	self hasOptions ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Options';
		items: [ options ifNotNil: [ :v | v associations ] ifNil: [ #() ] ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations ]
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key'
			stencil: [ :assoc | 
				BrHorizontalPane new
					hMatchParent;
					vFitContent;
					addChild: (BrLabel new
							aptitude: BrGlamorousLabelAptitude;
							hFitContentLimited;
							text: assoc key asRopedText);
					addChild: (BrButton new
							beMiniSize;
							aptitude: BrGlamorousButtonWithIconAptitude;
							visibility: BlVisibility hidden;
							margin: (BlInsets left: 5);
							icon: BrGlamorousVectorIcons remove;
							label: 'Remove ' , assoc key asString;
							action: [ :aButton | 
								self clearOption: assoc key ifAbsent: [  "ignore" ].
								aButton phlow firstParentWithViewContent
									ifNotNil: [ :anElement | anElement phlow update ]
									ifNil: [ aButton phlow fireToolUpdateWish ] ];
							constraintsDo: [ :c | c linear vertical alignCenter ]);
					when: BlMouseEnterEvent
						do: [ :anEvent | (anEvent currentTarget childAt: 2) visibility: BlVisibility visible ];
					when: BlMouseLeaveEvent
						do: [ :anEvent | (anEvent currentTarget childAt: 2) visibility: BlVisibility hidden ] ]
			weight: 0.5;
		column: 'Value' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ];
		actionUpdateButton
]
