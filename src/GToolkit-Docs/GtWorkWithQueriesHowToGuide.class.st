"
# How to work with queries
One of the design principles behind Glamorous Toolkit is that search must be universal. This is achieved using queries.
## What are queries?
They are small pieces of code, written in plain Pharo, that we can use to get information about a package, a class, a method or an object that satisfies one or more conditions.

Let's see an example: a search for all the methods annotated with the #gtView pragma.

{{gtExample:GtWorkWithQueriesHowToGuide>>#searchForGtViewPragmaMethods}}

Executing the query, opens up an inspector on the result which, in this case, is an instance of GtSearchPragmasFilter. The filter instance knows how to present itself through a view that shows method widgets. The method widgets know how to match the input query to the abstract syntax tree nodes to produce the orange highlighting.

But what if we want to search for multiple conditions at the same time? Well, queries can be composed using & and | messages, making this easily extensible.

Let's see an example: a search for all the methods that are annotated with the #gtView pragma and implement a tree view.

{{gtExample:GtWorkWithQueriesHowToGuide>>#searchForGtViewTreeMethods}}

Now let's search for those methods above, plus the ones that implement a columnedTree view.

{{gtExample:GtWorkWithQueriesHowToGuide>>#searchForGtViewTreeAndColumnedTreeMethods}}

Since queries are just plain Pharo code, we can combine them with Pharo methods like select: , collect: and others.

For example, this code snippet returns all example methods from packages starting with 'GToolkit'.

{{gtExample:GtWorkWithQueriesHowToGuide>>#exampleMethodsFromGToolkitPackages}}

Earlier we mentioned filters helping us to work with queries.

## What are filters? 
They are predicates that work as conditions in the query.

For example, let's search certain methods in a certain package. The result will be an instance of GtSearchIntersectionFilter, being the intersetion of two filters: GtSearchReferencesFilter and GtSearchMethodsWithPackagePatternFilter.

{{gtExample:GtWorkWithQueriesHowToGuide>>#searchInCertainPackage}}

There already exists a number of such predicates readily available. Below is a diagram of the GtSearchFilter class hierarchy.

{{gtExample:GtWorkWithQueriesHowToGuide>>#searchFiltersDiagram|previewShow=#gtHierarchyFor:|noCode=|previewHeight=720}}

## More Filters
Now let's take a closer look at the filters in the diagram above.
### Binary
The intersetion filter is a result of the & message. The result is a collection of elements that satisfy both the left side and the right side of the query.

{{gtExample:GtIntersectionFilterExamples>>#intersectionDifferentFilters}}

The union filter is a result of the | message. The result is a collection of elements that satisfy at least one of the query parts.

{{gtExample:GtUnionFilterExamples>>#unionDifferentMethods}}
### Packages
These filters allow us to see all the packages in the current image

{{gtExample:GtSearchPackageFilterExamples>>#packagesInImageFilter}}

and the packages that are deprecated.

{{gtExample:GtSearchPackageFilterExamples>>#deprecatedPackagesFilter}}

### Classes
Using these we can search the classes in the current image,

{{gtExample:GtSearchClassFilterExamples>>#classesInImageFilter}}

in a certain package,

{{gtExample:GtSearchClassFilterExamples>>#classesInCurrentPackageFilter}}

and the deprecated classes.

{{gtExample:GtSearchClassFilterExamples>>#deprecatedClassesFilter}}
### Methods
These allow us to perform various searches related to methods. For example, we can search methods in a certain package,

{{gtExample:GtSearchMethodFilterExamples>>#methodsInPackageFilter}}

with a certain category,

{{gtExample:GtSearchMethodFilterExamples>>#methodsInCategoryFilter}}

or methods that are deprecated.

{{gtExample:GtSearchMethodFilterExamples>>#deprecatedMethodsFilter}}

Inside a class, we can also search for instance side methods,

{{gtExample:GtSearchMethodsContainedInClassFilterExamples>>#methodsInClassFilter}}

for both instance and class side methods,

{{gtExample:GtSearchMethodsContainedInClassFilterExamples>>#methodsInClassOnBothSidesFilter}}

or for methods that use a certain instance variable.

{{gtExample:GtMethodsCoderExamples>>#instanceSlotsFilter}}

Through these method filters we can search different patterns. For example, we can search for methods that have a certain pattern in the source code,

{{gtExample:GtSearchMethodFilterExamples>>#astPatternFilter}}

or in the name.

{{gtExample:GtSearchMethodFilterExamples>>#implementorsPatternFilter}}

At the same time we can search for methods that are in a class with a certain pattern,

{{gtExample:GtSearchMethodFilterExamples>>#methodsWithClassPatternFilter}}

or in a package with a certain pattern.

{{gtExample:GtSearchMethodFilterExamples>>#packagePatternFilter}}

It is also possible to search methods by a name,

{{gtExample:GtSearchMethodFilterExamples>>#implementorsOfThisMessage}}

or by the annotation

{{gtExample:GtSearchMethodFilterExamples>>#gtExamplePragmas}}

and to search all the methods that reference something: a piece of code, another method or a class.

{{gtExample:GtSearchMethodReferencesFilterExamples>>#referencesTo42}}
### Negation
This filter takes another filter and does the opposite of that filter. For example, if we search for all deprecated packages and apply this filter, we end up with all the packages that are not deprecated.

{{gtExample:GtSearchNegationFilterExamples>>#negationSearchFilter}}
### Null
The Null filter always returns false, not matching anything.

{{gtExample:GtSearchNullFilterExamples>>#nullSearchFilter}}

"
Class {
	#name : #GtWorkWithQueriesHowToGuide,
	#superclass : #Object,
	#category : #'GToolkit-Docs'
}

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> exampleMethodsFromGToolkitPackages [
	<gtExample>
	<return: #GtSearchIntersectionFilter>
	^ #gtExample gtPragmas
		select: [ :method | method package name beginsWith: 'GToolkit' ]
]

{ #category : #accessing }
GtWorkWithQueriesHowToGuide >> searchAllFilters [
	<gtExample>
	<return: #OrderedCollection>
	^ GtSearchFilter allSubclasses reject: [ :each | each gtReferences size = 0 ]
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchFiltersDiagram [
	<gtExample>
	<return: #'GtSearchFilter class'>
	^ GtSearchFilter
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchForGtExampleReferences [
	<gtExample>
	<return: #GtCachedSearchReferencesFilter>
	^ #gtExample gtReferences
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchForGtViewPragmaMethods [
	<gtExample>
	<return: #GtSearchPragmasFilter>
	^ #gtView gtPragmas
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchForGtViewTreeAndColumnedTreeMethods [
	<gtExample>
	<return: #GtSearchIntersectionFilter>
	^ #gtView gtPragmas & (#tree gtReferences | #columnedTree gtReferences)
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchForGtViewTreeMethods [
	<gtExample>
	<return: #GtSearchIntersectionFilter>
	^ #gtView gtPragmas & #tree gtReferences
]

{ #category : #'as yet unclassified' }
GtWorkWithQueriesHowToGuide >> searchInCertainPackage [
	<gtExample>
	<return: #GtSearchIntersectionFilter>
	^ #todo gtReferences & 'Bloc' gtPackageMatches
]
