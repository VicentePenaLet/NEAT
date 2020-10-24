Class {
	#name : #HNLog,
	#superclass : #Object,
	#instVars : [
		'generationNumber',
		'bestFitness',
		'worstFitness',
		'averageFitness',
		'medianFitness',
		'fileName',
		'logReference',
		'bestN',
		'bestIndividual',
		'generation',
		'time',
		'population'
	],
	#category : #'NEAT-Core'
}

{ #category : #accessing }
HNLog >> averageFitness [
^averageFitness
]

{ #category : #accessing }
HNLog >> averageFitness: fitness [
averageFitness  := fitness
]

{ #category : #accessing }
HNLog >> bestFitness [
^bestFitness 
]

{ #category : #accessing }
HNLog >> bestFitness: fitness [
bestFitness := fitness.
]

{ #category : #accessing }
HNLog >> bestIndividual [ 
^bestIndividual
]

{ #category : #accessing }
HNLog >> bestIndividual: ind [
bestIndividual:= ind
]

{ #category : #accessing }
HNLog >> bestN [ 
^bestN
]

{ #category : #accessing }
HNLog >> bestN: array [ 
bestN:= array
]

{ #category : #accessing }
HNLog >> cleanFile [
|ref|
ref:= fileName asFileReference.
ref deleteIfAbsent: [].
]

{ #category : #accessing }
HNLog >> fileName [
^fileName 

]

{ #category : #accessing }
HNLog >> fileName: path [
fileName :=path

]

{ #category : #accessing }
HNLog >> generation [
^generation
]

{ #category : #accessing }
HNLog >> generation: n [
generation:=n
]

{ #category : #accessing }
HNLog >> logReference [
 ^logReference
]

{ #category : #accessing }
HNLog >> medianFitness [
^medianFitness
]

{ #category : #accessing }
HNLog >> medianFitness: fitness [
medianFitness  := fitness
]

{ #category : #accessing }
HNLog >> population [ 
^population

]

{ #category : #accessing }
HNLog >> population: ind [
population:= ind

]

{ #category : #accessing }
HNLog >> populationToFiles [
|path|
path := (FileSystem disk workingDirectory / 'logs'/ (generation asString )).
path ensureCreateDirectory. 
population do: [ :ind|  |string fileRef writeStream|
								string := STON toString: ind.
								fileRef := (path / ((ind id asString ) , '.txt')).
								writeStream := fileRef writeStream.
								writeStream setToEnd.
								writeStream nextPutAll: string.
								writeStream lf.
								writeStream close.]


]

{ #category : #accessing }
HNLog >> time [ 
^time

]

{ #category : #accessing }
HNLog >> time: t [
time := t

]

{ #category : #accessing }
HNLog >> worstFitness [
^worstFitness  
]

{ #category : #accessing }
HNLog >> worstFitness: fitness [
worstFitness  := fitness
]

{ #category : #accessing }
HNLog >> writeToFile [
|writeStream data str|
logReference := fileName asFileReference.
writeStream := logReference writeStream.
writeStream setToEnd.
data := OrderedCollection new.
data add: generation asString.
data add: bestFitness asString.
data add: worstFitness asString.
data add: averageFitness asString.
data add: time.
data do: [:each | writeStream nextPutAll: each ] separatedBy: [ writeStream nextPut: $, ].

writeStream lf.
writeStream close.

]
