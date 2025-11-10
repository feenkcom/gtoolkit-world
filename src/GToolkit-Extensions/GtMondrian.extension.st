Extension { #name : #GtMondrian }

{ #category : #'*GToolkit-Extensions' }
GtMondrian >> gtCreateMondrianViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	 
	template := '{viewSelector} aView
	<gtView>

	^ aView mondrian
		title: ''{viewTitle}'';
		painting: [ :m | {objectSource} ]'.
	
	bindings := {
			'viewSelector' -> aGtViewCreator newSelector.
			'viewTitle' -> aGtViewCreator title.
			'objectSource' -> aGtViewCreator objectSource
		} asDictionary.
		
	aGtViewCreator
		source: (template format: bindings)
]
