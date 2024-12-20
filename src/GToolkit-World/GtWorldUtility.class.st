"
Use {{gtClass:GtPhlowSpaceBuilder}} instead.
"
Class {
	#name : #GtWorldUtility,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-World-Utilities'
}

{ #category : #testing }
GtWorldUtility class >> isDeprecated [
	"Replaced by GtPhlowShowSpaceAction"

	^ true
]

{ #category : #'instance creation' }
GtWorldUtility class >> showObject: anObject from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow showObject: anObject` instead'
		transformWith: '`@receiver showObject: `@object from: `@anotherElement'
				-> '`BlSpace new objectInPager: `@object; showFrom: `@anotherElement'.

	^ BlSpace new
		objectInPager: anObject;
		withSceneDriller;
		showFrom: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithIcon: anIcon title: aString with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithIcon: `@icon title: `@string with: `@stencil from: `@anotherElement'
				-> '`BlSpace new icon: `@icon; title: `@string; addChild: `@stencil asElement; showFrom: `@anotherElement'.
	
	^ BlSpace new
		icon: anIcon;
		title: aString;
		addChild: aStencil asElement;
		withSceneDriller;
		showFrom: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon inPager: aPagerConfiguration with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@string icon: `@icon inPager: `@pagerConfiguration with: `@stencil from: `@anotherElement'
				-> '`BlSpace new icon: `@icon; title: `@string; inPager: `@stencil configured: `@pagerConfiguration; showFrom: `@anotherElement'.
	
	^ BlSpace new
		icon: anIcon;
		title: aString;
		inPager: aStencil configured: aPagerConfiguration;
		withSceneDriller;
		showFrom: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon inPagerWith: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString icon: `@anIcon inPagerWith: `@aStencil from: `@anotherElement'
				-> 'BlSpace new icon: `@anIcon; title: `@aString; inPager: `@aStencil; showFrom: `@anotherElement'.
	
	^ BlSpace new
		icon: anIcon;
		title: aString;
		inPager: aStencil;
		withSceneDriller;
		showFrom: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString icon: `@anIcon with: `@aStencil from: `@anotherElement'
				-> 'BlSpace new icon: `@anIcon; title: `@aString; addChild: `@aStencil asElement; showFrom: `@anotherElement'.
	
	^ BlSpace new
		title: aString;
		icon: anIcon;
		addChild: aStencil asElement;
		withSceneDriller;
		showFrom: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString inPager: aPagerConfiguration with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString inPager: `@aPagerConfiguration with: `@aStencil from: `@anotherElement'
				-> 'BlSpace new title: `@aString; inPager: `@aStencil configured: `@aPagerConfiguration; showFrom: `@anotherElement'.
	
	^ BlSpace new
		title: aString;
		inPager: aStencil configured: aPagerConfiguration;
		withSceneDriller;
		showFrom: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString inPagerWith: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString inPagerWith: `@aStencil from: `@anotherElement'
				-> 'BlSpace new title: `@aString; inPager: `@aStencil; showFrom: `@anotherElement'.
	
	^ BlSpace new
		title: aString;
		inPager: aStencil;
		withSceneDriller;
		showFrom: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString with: `@aStencil from: `@anotherElement'
				-> 'BlSpace new title: `@aString; addChild: `@aStencil asElement; showFrom: `@anotherElement'.
	
	^ BlSpace new
		title: aString;
		addChild: aStencil asElement;
		withSceneDriller;
		showFrom: anotherElement.
]
