Class {
	#name : #BaselineOfNEAT,
	#superclass : #BaselineOf,
	#category : #BaselineOfNEAT
}

{ #category : #baselines }
BaselineOfNEAT >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Roassal2'
				with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ].
			spec
				package: 'NEAT' with: [ spec requires: #('Roassal2') ].			
	spec
		group: 'default'
		with: #('NEAT')]
]
