Class {
	#name : #BaselineOfGToolkitWorld,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitWorld
}

{ #category : #baseline }
BaselineOfGToolkitWorld >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitVirtualMachine' with: [
				spec repository: 'github://feenkcom/gtoolkit-vm-bindings:v0.6.49/src' ].
		spec
			baseline: 'GToolkitClipboard' with: [
				spec repository: 'github://feenkcom/gtoolkit-clipboard:v0.8.73/src' ].
		spec
			baseline: 'GToolkitDebugger' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugger:v0.9.51/src' ].
		spec
			baseline: 'GToolkitFileBrowser' with: [
				spec repository: 'github://feenkcom/gtoolkit-filebrowser:v0.7.51/src' ].
		spec
			baseline: 'GToolkitReleaser' with: [
				spec repository: 'github://feenkcom/gtoolkit-releaser:v0.8.333/src' ].
		spec
			baseline: 'GToolkitConstrainer' with: [
				spec repository: 'github://feenkcom/gtoolkit-constrainer:v0.8.21/src' ].
		spec
			baseline: 'GToolkit4Pharo' with: [
				spec repository: 'github://feenkcom/gt4pharo:v0.7.49/src' ].
		spec
			baseline: 'GToolkit4XMLSupport' with: [
				spec repository: 'github://feenkcom/gt4xmlsupport:v0.8.32/src' ].
		spec
			baseline: 'GToolkit4Changes' with: [
				spec repository: 'github://feenkcom/gt4changes:v0.7.33/src' ].
		spec
			baseline: 'GToolkit4Git' with: [
				spec repository: 'github://feenkcom/gt4git:v0.9.30/src' ].
		spec
			baseline: 'GToolkit4GraphQL' with: [
				spec repository: 'github://feenkcom/gt4graphql:v0.7.61/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.9.39/src' ].
		spec
			baseline: 'GToolkitVisualizerPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.9.56/src' ].
		spec
			baseline: 'GToolkitPager' with: [
				spec repository: 'github://feenkcom/gtoolkit-pager:v0.9.34/src' ].
		spec
			baseline: 'GToolkitSpotter' with: [
				spec repository: 'github://feenkcom/gtoolkit-spotter:v0.9.30/src' ].
		spec
			baseline: 'GToolkitNotifications' with: [
				spec repository: 'github://feenkcom/gtoolkit-notifications:v0.7.29/src' ].
		spec
			baseline: 'GToolkitNotificationsExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-notifications:v0.7.29/src' ].
		spec
			baseline: 'XdocClient' with: [
				spec repository: 'github://feenkcom/xdoc:v0.9.19/src' ].
		spec
			baseline: 'LepiterEngine' with: [
				spec repository: 'github://feenkcom/lepiter:v0.7.59/src' ].

		spec package: 'GToolkit-Monitor' with: [
			spec requires: #(#LepiterEngine #GToolkitVisualizerPhlow) ].
		spec package: 'GToolkit-Profiler' with: [
			spec requires: #(#LepiterEngine #GToolkitVisualizerPhlow #GToolkitNotifications) ].
		spec package: 'GToolkit-SceneDriller' with: [
			spec requires: #(#GToolkitVisualizerPhlow #GToolkitPager) ].
		spec package: 'GToolkit-Setup' with: [
			spec requires: #(#GToolkitReleaser #GToolkitDebugger #LepiterEngine) ].
		spec package: 'GToolkit-DependencyAnalyzer'.
		spec package: 'GToolkit-Constraints' with: [
			spec requires: #(#GToolkitConstrainer #'GToolkit-DependencyAnalyzer' #LepiterEngine #GToolkit4Git) ].
		spec package: 'GToolkit-WorldPreviewer' with: [
			spec requires: #(#GToolkitPager) ].
		spec package: 'GToolkit-World' with: [
			spec requires: #(#'GToolkit-SceneDriller' #GToolkitFileBrowser #LepiterEngine #GToolkit4Git #'GToolkit-Monitor' #GToolkitReleaser #XdocClient #GToolkitNotifications #GToolkitNotificationsExamples #GToolkit4Changes #'GToolkit-WorldPreviewer') ].
		spec package: 'GToolkit-Docs' with: [
			spec requires: #(#GToolkitCoder #'GToolkit-World') ].
		spec package: 'GToolkit-Extensions' with: [
			spec requires: #(#GToolkitCoder #GToolkit4Pharo #GToolkitSpotter #GToolkitVirtualMachine #GToolkitClipboard #GToolkitDebugger #GToolkitFileBrowser #GToolkitConstrainer #GToolkit4Git #GToolkitVisualizerPhlow #GToolkitReleaser #GToolkit4XMLSupport #'GToolkit-DependencyAnalyzer' #'GToolkit-Docs' #'GToolkit-Monitor' #'GToolkit-Profiler' #'GToolkit-Constraints' #'GToolkit-SceneDriller' #'GToolkit-World' #'GToolkit-Setup' #GToolkit4GraphQL #'GToolkit-WorldPreviewer') ].
		spec package: 'GtIdentity'.
	]
]
