Class {
	#name : #FoodGathertingExperiment,
	#superclass : #Object,
	#instVars : [
		'agents',
		'foodPosition',
		'agentPosition',
		'e'
	],
	#category : #'NEAT-FoodGathering'
}

{ #category : #'as yet unclassified' }
FoodGathertingExperiment >> assignNetworks: networks [
	agents with: networks do:[:agent :net| agent cpp: net]
	
]

{ #category : #'as yet unclassified' }
FoodGathertingExperiment >> moveAgent [
   |speed|
	speed := agent getSpeed.
	
]
