"
Examples of tools from the GtWorld menu used especially in “A quick tour of GT”.
See {{gtClass:name=GtHomeToolsSection}} for the source buttons.
"
Class {
	#name : #GtWorldMenuExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> codeChangesElement [
	<gtExample>
	^ GtEpiceaStencil new create
]

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> coderElement [
	<gtExample>
	^ GtCoderStencil new create
]

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> gitToolElement [
	<gtExample>
	^ GtGitStencil new create
]

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> knowledgeBasesElement [
	<gtExample>
	<return: #LeHomeDatabasesElement>
	^ (LeLepiterToolStencil new
		knowledgeBase: LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase)
		create
]

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> monitorElement [
	<gtExample>
	^ (GtInspector createOn: GtMonitor new) maximized
]

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> openWorldMenuOutsideScripter [
	<gtExample>
	<return: #GtWorldElement>
	^ GtWorldByScripterExamples new openWorldMenu elementWithoutParent
]

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> primaryDBElement [
	<gtExample>
	<return: #GtInspector>
	^ GtInspector newOn: LeDatabase primaryDB
]

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> transcriptElement [
	<gtExample>
	^ GtTranscriptStencil new
]

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> worldElementOutsideScripter [
	<gtExample>
	<return: #GtWorldElement>
	^ GtWorldByScripterExamples new worldElementInScripter elementWithoutParent
]
