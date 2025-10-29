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
	| screenshot |
	screenshot := BrHorizontalPane new fitContent
			cellSpacing: 20;
			background: Color white.
	self tabModel pagerPagePreviews
		do: [ :each | 
			screenshot
				addChild: ((each asElementScaled: 1)
						margin: (BlInsets all: 20);
						addAptitude: BrShadowAptitude new beLarge) ].
	(BlScripter new
		maxPulseElapsedTime: 30 seconds;
		element: screenshot) element exportAsPNG
]

{ #category : #'as yet unclassified' }
GtWorldPreviewerTabElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #'as yet unclassified' }
GtWorldPreviewerTabElement >> initialize [
	| headerElement |
	super initialize.


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

{ #category : #'as yet unclassified' }
GtWorldPreviewerTabElement >> initializeHeaderElement [
	headerElement := BrHorizontalPane new fitContent
]

{ #category : #'as yet unclassified' }
GtWorldPreviewerTabElement >> initializeLabelElement [
	labelElement := BrLabel new
			text: 'Tab: ';
			margin: (BlInsets left: 10);
			aptitude: BrGlamorousLabelAptitude new
]

{ #category : #'as yet unclassified' }
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
