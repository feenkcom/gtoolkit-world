Class {
	#name : #BaselineOfGToolkitWorld,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitWorld
}

{ #category : #baseline }
BaselineOfGToolkitWorld >> baseline: spec [
	<baseline>
	^ spec
		for: #common
		do: [ spec
				baseline: 'GToolkitVirtualMachine'
					with: [ spec repository: 'github://feenkcom/gtoolkit-vm-bindings:main/src' ];
				baseline: 'GToolkitClipboard'
					with: [ spec repository: 'github://feenkcom/gtoolkit-clipboard:main/src' ];
				baseline: 'GToolkitTranscript'
					with: [ spec repository: 'github://feenkcom/gtoolkit:main/src' ];
				baseline: 'GToolkitDebugger'
					with: [ spec repository: 'github://feenkcom/gtoolkit-debugger:main/src' ];
				baseline: 'GToolkitFileBrowser'
					with: [ spec repository: 'github://feenkcom/gtoolkit-filebrowser:main/src' ];
				baseline: 'GToolkitReleaser'
					with: [ spec repository: 'github://feenkcom/gtoolkit-releaser:main/src' ];
				baseline: 'GToolkitConstrainer'
					with: [ spec repository: 'github://feenkcom/gtoolkit-constrainer:main/src' ];
				baseline: 'GToolkit4Pharo'
					with: [ spec repository: 'github://feenkcom/gt4pharo:main/src' ];
				baseline: 'GToolkit4XMLSupport'
					with: [ spec repository: 'github://feenkcom/gt4xmlsupport:main/src' ];
				baseline: 'GToolkit4Changes'
					with: [ spec repository: 'github://feenkcom/gt4changes:main/src' ];
				baseline: 'GToolkit4Git'
					with: [ spec repository: 'github://feenkcom/gt4git:main/src' ];
				baseline: 'GToolkit4GraphQL'
					with: [ spec repository: 'github://feenkcom/gt4graphql:main/src' ];
				baseline: 'GToolkitCoder'
					with: [ spec repository: 'github://feenkcom/gtoolkit-coder:main/src' ];
				baseline: 'GToolkitVisualizerPhlow'
					with: [ spec repository: 'github://feenkcom/gtoolkit-visualizer:main/src' ];
				baseline: 'GToolkitPager'
					with: [ spec repository: 'github://feenkcom/gtoolkit-pager:main/src' ];
				baseline: 'GToolkitSpotter'
					with: [ spec repository: 'github://feenkcom/gtoolkit-spotter:main/src' ];
				baseline: 'GToolkitNotifications'
					with: [ spec repository: 'github://feenkcom/gtoolkit-notifications:main/src' ];
				baseline: 'GToolkitNotificationsExamples'
					with: [ spec repository: 'github://feenkcom/gtoolkit-notifications:main/src' ];
				baseline: 'XdocClient'
					with: [ spec repository: 'github://feenkcom/xdoc:main/src' ];
				baseline: 'LepiterEngine'
					with: [ spec repository: 'github://feenkcom/lepiter:main/src' ].

			spec
				package: 'GToolkit-Docs'
					with: [ spec requires: #('GToolkitCoder' 'GToolkit-World') ];
				package: 'GToolkit-Monitor'
					with: [ spec requires: #('LepiterEngine' 'GToolkitVisualizerPhlow') ];
				package: 'GToolkit-Profiler'
					with: [ spec
							requires: #('LepiterEngine' 'GToolkitVisualizerPhlow' 'GToolkitNotifications') ];
				package: 'GToolkit-Constraints'
					with: [ spec
							requires: #('GToolkitConstrainer' 'GToolkit-DependencyAnalyzer' 'LepiterEngine' 'GToolkit4Git') ];
				package: 'GToolkit-SceneDriller'
					with: [ spec requires: #('GToolkitVisualizerPhlow' 'GToolkitPager') ];
				package: 'GToolkit-Setup'
					with: [ spec requires: #('GToolkitReleaser' 'GToolkitDebugger' 'LepiterEngine') ];
				package: 'GToolkit-DependencyAnalyzer';
				package: 'GToolkit-World'
					with: [ spec
							requires: #('GToolkit-SceneDriller' 'GToolkitFileBrowser' 'LepiterEngine' 'GToolkit4Git' 'GToolkitTranscript' 'GToolkit-Monitor' 'GToolkitReleaser' 'XdocClient' 'GToolkitNotifications' 'GToolkitNotificationsExamples' 'GToolkit4Changes') ];
				package: 'GToolkit-Extensions'
					with: [ spec
							requires: #('GToolkitCoder' 'GToolkit4Pharo' 'GToolkitSpotter' 'GToolkitVirtualMachine' 'GToolkitClipboard' 'GToolkitTranscript' 'GToolkitDebugger' 'GToolkitFileBrowser' 'GToolkitConstrainer' 'GToolkit4Git' 'GToolkitVisualizerPhlow' 'GToolkitReleaser' 'GToolkit4XMLSupport' 'GToolkit-DependencyAnalyzer' 'GToolkit-Docs' 'GToolkit-Monitor' 'GToolkit-Profiler' 'GToolkit-Constraints' 'GToolkit-SceneDriller' 'GToolkit-World' 'GToolkit-Setup' 'GToolkit4GraphQL') ];
				package: 'GtIdentity' ]
]
