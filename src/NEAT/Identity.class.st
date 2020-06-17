Class {
	#name : #Identity,
	#superclass : #ActivationFunction,
	#category : #'NEAT-Core'
}

{ #category : #'target resize' }
Identity class >> apply: z [
 (z < -1) ifTrue:[^-1].
 (z > 1) ifTrue:[^1].
^z
]
