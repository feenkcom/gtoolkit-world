Extension { #name : #True }

{ #category : #'*GToolkit-Extensions' }
True >> lazyXor: alternativeBlock [
	"Nonevaluating conjunction. Answer the opposite of the
	the argument, alternativeBlock; since the receiver is true."
	"(true xor: [true]) >>> false"
	"(true xor: [false]) >>> true.
	This implementation keeps the original Pharo behaviour for installations where `#xor:` 
	is overwritten to be compatible with VisualWorks and GemStone."

	^ alternativeBlock value not
]
