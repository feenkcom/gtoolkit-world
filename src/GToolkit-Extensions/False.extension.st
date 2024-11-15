Extension { #name : #False }

{ #category : #'*GToolkit-Extensions' }
False >> lazyXor: alternativeBlock [
	"Answer the value of the alternativeBlock since the receiver is false."
	"(false xor: [true]) >>> true"
	"(false xor: [false]) >>> false.
	This implementation keeps the original Pharo behaviour for installations where `#xor:` 
	is overwritten to be compatible with VisualWorks and GemStone."

	^ alternativeBlock value
]
