Class {
	#name : #NELog,
	#superclass : #Object,
	#instVars : [
		'generation',
		'speciation',
		'minFitness',
		'maxFitness',
		'averageFitness',
		'bestIndividual',
		'bestN'
	],
	#category : #'NEAT-Core'
}

{ #category : #accessing }
NELog >> averageFitness [
	^ averageFitness
]

{ #category : #accessing }
NELog >> averageFitness: anObject [
	averageFitness := anObject
]

{ #category : #accessing }
NELog >> bestIndividual [
	^ bestIndividual
]

{ #category : #accessing }
NELog >> bestIndividual: anObject [
	bestIndividual := anObject
]

{ #category : #accessing }
NELog >> bestN [
^bestN 
]

{ #category : #accessing }
NELog >> bestN:n [
bestN:= n 
]

{ #category : #accessing }
NELog >> generation [
	^ generation
]

{ #category : #accessing }
NELog >> generation: anObject [
	generation := anObject
]

{ #category : #ui }
NELog >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ 	speciation visualize ]
]

{ #category : #accessing }
NELog >> maxFitness [
	^ maxFitness
]

{ #category : #accessing }
NELog >> maxFitness: anObject [
	maxFitness := anObject
]

{ #category : #accessing }
NELog >> minFitness [
	^ minFitness
]

{ #category : #accessing }
NELog >> minFitness: anObject [
	minFitness := anObject
]

{ #category : #'as yet unclassified' }
NELog >> numberOfSpecies [
	^ speciation numberOfSpecies
]

{ #category : #printing }
NELog >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	generation ifNotNil: [ str nextPutAll: generation asString ].
	str nextPut: $>.
]

{ #category : #dependencies }
NELog >> release [
	speciation := nil.
	bestIndividual := nil
]

{ #category : #accessing }
NELog >> speciation [
	^ speciation
]

{ #category : #accessing }
NELog >> speciation: anObject [
	speciation := anObject
]
