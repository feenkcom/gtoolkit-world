Extension { #name : #ByteArray }

{ #category : #'*GToolkit-Extensions' }
ByteArray >> gtFigureFor: aView [
	<gtView>
	(ImageReadWriter
		gtReaderClassFromStream: (ZnPositionableReadStream on: self readStream))
		ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Figure';
		priority: 30;
		stencil: [ BrFrame new
				matchParent;
				padding: (BlInsets all: 5);
				addChild: (BlSpartaBufferedImageElement new
						buffer: self;
						constraintsDo: [ :c | 
							c vertical matchParent.
							c horizontal matchParent ]) ]
]

{ #category : #'*GToolkit-Extensions' }
ByteArray >> gtTreeFor: aView context: aContext [
	^ aView empty
]
