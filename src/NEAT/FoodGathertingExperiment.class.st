Class {
	#name : #FoodGathertingExperiment,
	#superclass : #Object,
	#instVars : [
		'agent',
		'foodPosition',
		'agentPosition',
		'e'
	],
	#category : #'NEAT-FoodGathering'
}

{ #category : #'as yet unclassified' }
FoodGathertingExperiment >> moveAgent [
   |speed|
	speed := agent getSpeed.
	
]
