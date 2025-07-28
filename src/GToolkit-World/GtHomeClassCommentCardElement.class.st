"
I am an {{gtClass:BlElement}}.
I summarize a class comment for a given {{gtMethod:GtHomeClassCommentCardElement>>#documentClass:|label=class}}.
## Examples
### Existing class comment
{{gtExample:GtHomeClassCommentCardElementExamples>>#elementWithClassWithComment|codeExpanded=false|previewExpanded=true}}
### Empty class comment
{{gtExample:GtHomeClassCommentCardElementExamples>>#elementWithClassWithoutComment|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtHomeClassCommentCardElement,
	#superclass : #GtHomeDocumentCardElement,
	#category : #'GToolkit-World-Sections'
}

{ #category : #'private - accessing' }
GtHomeClassCommentCardElement >> description [
	| aComment aDescription reachedSecondLine |
	aComment := self documentClassComment.
	reachedSecondLine := false.
	aDescription := String 
		streamContents: [ :aStream |
			aComment do: [ :eachCharacter | 
				reachedSecondLine ifTrue: [ 
					aStream nextPut: eachCharacter ].
				eachCharacter isLineBreak
					ifTrue: [ reachedSecondLine := true ] ] ]
		limitedTo: self maxDescriptionLength.
	^ aDescription
]

{ #category : #'api - accessing' }
GtHomeClassCommentCardElement >> documentClass [
	^ self document
]

{ #category : #'api - accessing' }
GtHomeClassCommentCardElement >> documentClass: aClass [
	self document: aClass instanceSide.
]

{ #category : #'private - accessing' }
GtHomeClassCommentCardElement >> documentClassComment [
	| targetClass |
	targetClass := self documentClass.
	^ self 
		forPharo12: [
			targetClass comment ] 
		forPharo11AndPharo10: [ 
			targetClass organization classComment ].
]

{ #category : #'private - hooks' }
GtHomeClassCommentCardElement >> onDocumentChanged [
	self updateElement.
]

{ #category : #'private - accessing' }
GtHomeClassCommentCardElement >> title [
	| aComment aTitle |
	aComment := self documentClassComment.
	aTitle := self titleWithoutHeadingsFrom: aComment.
	aTitle ifEmpty: [ ^ self documentClass name ].
	^ aTitle
]
