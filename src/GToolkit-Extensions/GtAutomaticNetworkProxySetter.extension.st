Extension { #name : #GtAutomaticNetworkProxySetter }

{ #category : #'*GToolkit-Extensions' }
GtAutomaticNetworkProxySetter class >> gtNoProxyVariablesFor: aView [
	<gtClassView>
	^ (self new gtNoProxyVariablesFor: aView) priority: 2
]

{ #category : #'*GToolkit-Extensions' }
GtAutomaticNetworkProxySetter >> gtNoProxyVariablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'No proxy variables';
		priority: 2;
		items: [ OrderedCollection
				streamContents: [ :aStream | 
					self
						noProxyVariableNamesDo: [ :aVariableName :aPragma | aStream nextPut: aPragma -> aVariableName ] ] ];
		column: 'Variable' text: [ :anAssoc | anAssoc value ];
		column: 'Priority' text: [ :anAssoc | anAssoc key argumentAt: 1 ];
		column: 'Defined method' text: [ :anAssoc | anAssoc key methodSelector ];
		sendTool: [ :anAssoc | GtMethodCoderTool compiledMethod: anAssoc key method ]
]

{ #category : #'*GToolkit-Extensions' }
GtAutomaticNetworkProxySetter class >> gtProxyVariablesFor: aView [
	<gtClassView>
	^ (self new gtProxyVariablesFor: aView) priority: 1
]

{ #category : #'*GToolkit-Extensions' }
GtAutomaticNetworkProxySetter >> gtProxyVariablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Proxy variables';
		priority: 1;
		items: [ OrderedCollection
				streamContents: [ :aStream | 
					self
						proxyVariableNamesDo: [ :aVariableName :aPragma | aStream nextPut: aPragma -> aVariableName ] ] ];
		column: 'Variable' text: [ :anAssoc | anAssoc value ];
		column: 'Priority' text: [ :anAssoc | anAssoc key argumentAt: 1 ];
		column: 'Defined method' text: [ :anAssoc | anAssoc key methodSelector ];
		sendTool: [ :anAssoc | GtMethodCoderTool compiledMethod: anAssoc key method ]
]
