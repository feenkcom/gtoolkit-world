Class {
	#name : #GtWorldPreviewerTabElement,
	#superclass : #BlElement,
	#traits : 'TGtWorldWithPreviewerTabModel + TBrLayoutResizable',
	#classTraits : 'TGtWorldWithPreviewerTabModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'labelElement',
		'screenshotButton',
		'contentContainerElement'
	],
	#category : #'GToolkit-WorldPreviewer-UI'
}

{ #category : #'private - event handling' }
GtWorldPreviewerTabElement >> computeScreenshot [
	self tabModel computeScreenshot
]

{ #category : #initialization }
GtWorldPreviewerTabElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtWorldPreviewerTabElement >> initialize [
	| headerElement |
	super initialize.

	"self background: Color white.
	self padding: (BlInsets all: 10).
	self addAptitude: BrShadowAptitude."
	
	self initializeLabelElement.
	self initializeScreenshotButton.

	headerElement := BrHorizontalPane new
			fitContent;
			alignCenter;
			addChild: labelElement;
			addChild: screenshotButton.

	contentContainerElement := BrVerticalPane new
			hMatchParent;
			vFitContentLimited;
			addAptitude: (BrLayoutResizerAptitude new common: [ contentContainerElement children ]).

	self addAptitude: (BrLayoutResizerAptitude new common: contentContainerElement).

	self addChild: headerElement.
	self addChild: contentContainerElement.

	self
		hMatchParent;
		vFitContent.
]

{ #category : #initialization }
GtWorldPreviewerTabElement >> initializeLabelElement [
	labelElement := BrLabel new
			text: 'Tab: ';
			margin: (BlInsets top: 0 left: 5 bottom: 5 right: 0);
			aptitude: BrGlamorousLabelAptitude new
]

{ #category : #initialization }
GtWorldPreviewerTabElement >> initializeScreenshotButton [
	screenshotButton := BrButton new
			beTinySize;
			margin: (BlInsets left: 10);
			aptitude: BrGlamorousButtonWithLabelAptitude new;
			label: 'Screenshot';
			withAsyncFutureDo: [ :anElementFuture | 
				anElementFuture
					whenPending: [ :theButton | theButton disable ];
					whenError: [ :theButton :anError | 
						| aCopyError |
						aCopyError := GtSystemUtility freeze: anError.
						theButton
							enable;
							background: theButton theme status errorBackgroundColor;
							action: [ :aButton | aButton phlow spawnObject: aCopyError ] ];
					whenSuccess: [ :theButton :aData | theButton enable ] ];
			action: [ :theButton | self onScreenshotButtonClick ]
]

{ #category : #'private - updating' }
GtWorldPreviewerTabElement >> newTabLabelText [
	^ self hasTabModel
		ifTrue: [ 'Tab: {1}' format: {self tabModel tabLabel} ]
		ifFalse: [ 'Tab:' ]
]

{ #category : #'private - event handling' }
GtWorldPreviewerTabElement >> onScreenshotButtonClick [
	self hasTabModel ifFalse: [ ^ self ].

	screenshotButton asyncFuture future: [ self computeScreenshot ]
]

{ #category : #'api - tab model' }
GtWorldPreviewerTabElement >> onTabModelChanged [
	self updateElement
]

{ #category : #'private - updating' }
GtWorldPreviewerTabElement >> updateContentContainerElement [
	contentContainerElement
		removeChildren;
		addChild: self tabModel tabContent asElement
]

{ #category : #'private - updating' }
GtWorldPreviewerTabElement >> updateElement [
	self updateLabelElement.
	self updateContentContainerElement
]

{ #category : #'private - updating' }
GtWorldPreviewerTabElement >> updateLabelElement [
	labelElement text: self newTabLabelText
]
