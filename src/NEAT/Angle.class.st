Class {
	#name : #Angle,
	#superclass : #Object,
	#category : #'NEAT-FoodGathering'
}

{ #category : #'as yet unclassified' }
Angle class >> bound:  value [
|new|
new:= value.
[new >= (2* (Float pi))] whileTrue: [new := (new - (2 * (Float pi)))].
^new
								  

]

{ #category : #'as yet unclassified' }
Angle >> bound:  value [
(value >= 2* (Float pi)) ifTrue: [value = value - 2 * (Float pi)]
]
