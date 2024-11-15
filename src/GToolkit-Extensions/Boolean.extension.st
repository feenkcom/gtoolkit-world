Extension { #name : #Boolean }

{ #category : #'*GToolkit-Extensions' }
Boolean >> lazyXor: alternativeBlock [
	"Nonevaluating conjunction. If the receiver is true, answer the opposite of the
	the argument, alternativeBlock; otherwise answer the value of the alternativeBlock.
	This implementation keeps the original Pharo behaviour for installations where `#xor:` 
	is overwritten to be compatible with VisualWorks and GemStone."

	"(true xor: [true]) >>> false"
	"(true xor: [false]) >>> true"
	"(false xor: [true]) >>> true"
	"(false xor: [false]) >>> false"

	self subclassResponsibility
]
