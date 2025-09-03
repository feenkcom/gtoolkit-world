Extension { #name : #TGtUniqueInstance }

{ #category : #'*GToolkit-Extensions' }
TGtUniqueInstance classSide >> gtInstanceButtonFor: anAction [
	<gtClassAction>
	^ anAction button
		tooltip: 'Inspect unique instance';
		priority: 10;
		icon: BrGlamorousVectorIcons playinspect;
		action: [ :aButton | aButton phlow spawnObject: self uniqueInstance]
]
