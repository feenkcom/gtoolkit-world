"
Examples of tools from the GtWorld menu.
"
Class {
	#name : #GtWorldMenuExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'as yet unclassified' }
GtWorldMenuExamples >> knowledgeBasesElement [
	<gtExample>
	<return: #LeHomeDatabasesElement>
	^ LeHomeDatabasesElement new
		databaseViewModel: LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase
				asContentUIModel
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
GtWorldMenuExamples >> worldElementOutsideScripter [
	<gtExample>
	<return: #GtWorldElement>
	^ GtWorldByScripterExamples new worldElementInScripter elementWithoutParent
]
