Class {
	#name : #Absolute,
	#superclass : #ActivationFunction,
	#category : #'NEAT-Core'
}

{ #category : #'target resize' }
Absolute class >> apply: z [
	^ z abs
]
