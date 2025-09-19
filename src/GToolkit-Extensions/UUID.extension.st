Extension { #name : #UUID }

{ #category : #'*GToolkit-Extensions' }
UUID >> encodedTime [
	"Answer the receiver's encoded time.
	Only valid if the UUID was created with the default UUIDGenerator."
	| buffer |

	buffer := self forPharo12AndNewer: [ uuidData ] forPharo11: [ self ].
	^ (DateAndTime fromSeconds: (buffer uint64AtOffset: 0) / 1000000 offset: 0)
		offset: DateAndTime localOffset
]
