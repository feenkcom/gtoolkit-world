Extension { #name : #GtSearchMethodsFilter }

{ #category : #'*Gtoolkit-Extensions' }
GtSearchMethodsFilter >> gtItemsByClassFor: aView [
	<gtView>
	<gtToolView>

	^ aView columnedList
		title: 'By Class';
		priority: 43;
		items: [ 
			(self result asyncSimilarCopy toArray wait 
				groupedBy: [ :aCompiledMethod | aCompiledMethod methodClass ])
				associations sorted: [ :assoc | assoc key name ] ascending ];
		column: 'Class' text: [ :assoc | assoc key name ];
		column: 'Items' text: [ :assoc | assoc value size ];
		send: [ :assoc |
			(GtSearchFixedMethodsFilter new 
				methods: assoc value)
					labeled: self gtDisplayString, ' & ', assoc key name, ' class' ] 
]

{ #category : #'*Gtoolkit-Extensions' }
GtSearchMethodsFilter >> gtItemsByPackageFor: aView [
	<gtView>
	<gtToolView>

	^ aView columnedList
		title: 'By Package';
		priority: 43;
		items: [ 
			(self result asyncSimilarCopy toArray wait 
				groupedBy: [ :aCompiledMethod | aCompiledMethod package ])
				associations sorted: [ :assoc | 
					assoc key 
						ifNil: [ '' ] 
						ifNotNil: [:aPackage | aPackage name] ] ascending ];
		column: 'Package' text: [ :assoc | 
			assoc key 
				ifNil: [ '<Obsolete>' ] 
				ifNotNil: [:aPackage | aPackage name ] ];
		column: 'Items' text: [ :assoc | assoc value size ];
		send: [ :assoc |
			(GtSearchFixedMethodsFilter new 
				methods: assoc value)
					labeled: (self gtDisplayString
						, ' & '
						, (assoc key 
							ifNil: [ '<Obsolete>' ] 
							ifNotNil: [:aPackage | aPackage name ])
						, ' package') ] 
]
