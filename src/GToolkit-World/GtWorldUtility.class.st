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
		transformWith: '`@receiver showObject: `@object from: `@element'
				-> '`@element phlow showObject: `@object'
		when: [ anotherElement isNotNil ].

	^ GtPhlowSpaceBuilder new
		fromElement: anotherElement;
		objectInPager: anObject;
		show
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithIcon: anIcon title: aString with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithIcon: `@icon title: `@string with: `@stencil from: `@element'
				-> '`@element phlow spaceBuilder icon: `@icon; title: `@string; stencil: `@stencil; show'
		when: [ anotherElement isNotNil ].
	
	^ GtPhlowSpaceBuilder new
		fromElement: anotherElement;
		icon: anIcon;
		title: aString;
		stencil: aStencil;
		show
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon inPager: aPagerConfiguration with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@string icon: `@icon inPager: `@pagerConfiguration with: `@stencil from: `@element'
				-> '`@element phlow spaceBuilder icon: `@icon; title: `@string; inPager: `@stencil configured: `@pagerConfiguration; show'
		when: [ anotherElement isNotNil ].
	
	^ GtPhlowSpaceBuilder new
		fromElement: anotherElement;
		icon: anIcon;
		title: aString;
		inPager: aStencil configured: aPagerConfiguration;
		show
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon inPagerWith: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString icon: `@anIcon inPagerWith: `@aStencil from: `@anotherElement'
				-> '`@anotherElement phlow spaceBuilder icon: `@anIcon; title: `@aString; inPager: `@aStencil; show'
		when: [ anotherElement isNotNil ].
	
	^ GtPhlowSpaceBuilder new
		fromElement: anotherElement;
		icon: anIcon;
		title: aString;
		inPager: aStencil;
		show
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString icon: anIcon with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString icon: `@anIcon with: `@aStencil from: `@anotherElement'
				-> '`@anotherElement phlow spaceBuilder icon: `@anIcon; title: `@aString; stencil: `@aStencil; show'
		when: [ anotherElement isNotNil ].
	
	^ GtPhlowSpaceBuilder new
		fromElement: anotherElement;
		icon: anIcon;
		title: aString;
		stencil: aStencil;
		show
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString inPager: aPagerConfiguration with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString inPager: `@aPagerConfiguration with: `@aStencil from: `@anotherElement'
				-> '`@anotherElement phlow spaceBuilder title: `@aString; inPager: `@aStencil configured: `@aPagerConfiguration; show'
		when: [ anotherElement isNotNil ].
	
	^ GtPhlowSpaceBuilder new
		fromElement: anotherElement;
		title: aString;
		inPager: aStencil configured: aPagerConfiguration;
		show
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString inPagerWith: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString inPagerWith: `@aStencil from: `@anotherElement'
				-> '`@anotherElement phlow spaceBuilder title: `@aString; inPager: `@aStencil; show'
		when: [ anotherElement isNotNil ].
	
	^ GtPhlowSpaceBuilder new
		fromElement: anotherElement;
		title: aString;
		inPager: aStencil;
		show
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString with: aStencil from: anotherElement [
	self
		deprecated: 'Use `anotherElement phlow spaceBuilder ...; show` instead'
		transformWith: '`@receiver showSpaceWithTitle: `@aString with: `@aStencil from: `@anotherElement'
				-> '`@anotherElement phlow spaceBuilder title: `@aString; stencil: `@aStencil; show'
		when: [ anotherElement isNotNil ].
	
	^ GtPhlowSpaceBuilder new
		fromElement: anotherElement;
		title: aString;
		stencil: aStencil;
		show
]
