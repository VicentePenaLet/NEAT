Class {
	#name : #Gaussian,
	#superclass : #ActivationFunction,
	#category : #'NEAT-Core'
}

{ #category : #'target resize' }
Gaussian class >> apply: z [
^ (z*z) negated exp
]
