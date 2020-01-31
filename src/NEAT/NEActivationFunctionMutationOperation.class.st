Class {
	#name : #NEActivationFunctionMutationOperation,
	#superclass : #NEAbstractNonStructuralMutationOperation,
	#category : #'NEAT-Core'
}

{ #category : #'instance creation' }
NEActivationFunctionMutationOperation >> on: anIndividual [
	| node newActivation |
	node := anIndividual nodes atRandom: random.
	newActivation := ActivationFunction allSubclasses atRandom.
	node activation: newActivation
]
