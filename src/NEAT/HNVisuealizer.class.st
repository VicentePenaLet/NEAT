Class {
	#name : #HNVisuealizer,
	#superclass : #Object,
	#instVars : [
		'population',
		'canvas',
		'pop'
	],
	#category : #'NEAT-Tests'
}

{ #category : #'as yet unclassified' }
HNVisuealizer >> canvas [ 
^canvas
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> canvas: c [
canvas:= c
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> cleanCanvas [
canvas:= RSCanvas new.
pop := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> drawGen: i [
pop addAll: ((population at: i) collect: [ :ind | |c|
														  c := RSEllipse new size: 5; model: ind.
														  c @ RSPopup @ RSDraggable.
														  ] as: RSGroup).
canvas addAll: pop.
RSGridLayout new lineItemsCount: 50; on: canvas nodes.
canvas @ RSCanvasController.

]

{ #category : #'as yet unclassified' }
HNVisuealizer >> findIdx: idx [
^pop select: [:item| (item model id) = idx]
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> findIdx: idx Gen: gen [
|s|
s:=pop select: [:item| (item model id) = idx].
^ s collect:[:ea|ea model]
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> findParents: item [ 
^(item parents) collect: [:parent| (self findIdx: (parent id))]
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> findParents: idx Gen: gen [
^ pop select: [:model| (model last = gen) and: (model id = idx)].

]

{ #category : #'as yet unclassified' }
HNVisuealizer >> findParentsAsObject: item [ 
^(item parents) collect: [:parent| (self findIdx: (parent id)) collect: [:ea| ea model]]
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> findParentsIdx: idx Gen: gen [
^ pop select: [:model| (model last = gen) and: (model ind first id = idx)].

]

{ #category : #'as yet unclassified' }
HNVisuealizer >> initialize [ 
canvas := RSCanvas new.
pop := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> loadGeneration: gen [
^ (FileSystem disk workingDirectory / 'logs'/ gen asString ) children collect: [:file| (STONReader on: (file readStream)) next].
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> loadPopulation: nGen [
population:= (1 to: nGen) collect:  [:gen| self loadGeneration: (gen+1)].
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> pop [
^pop
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> population [
^population 
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> population: p [
population:=p
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> showGenerations: n [
|eb|
self cleanCanvas.
(1 to: n) do: [ :ind| self drawGen: ind].
RSNormalizer size
    shapes: canvas nodes;
    normalize: [ :model | model fitness ].

eb := RSEdgeBuilder line.
eb canvas: canvas.
eb withBorderAttachPoint.
pop do: [ :shape| eb connectFrom: (shape model) toAll: (self findParents: shape model). ].
RSGridLayout new lineItemsCount: 50; on: canvas nodes.
canvas @ RSCanvasController.
]

{ #category : #'as yet unclassified' }
HNVisuealizer >> showPopulation: n [
|pop|
pop := population  collect: [ :ind | RSEllipse new size: 5; model: ind ] as: RSGroup.
canvas := RSCanvas new. 
canvas addAll: pop.

RSNormalizer size
    shapes: canvas nodes;
    normalize: [ :anArray | anArray first fitness ].

RSGridLayout new lineItemsCount: 50; on: canvas nodes.
canvas @ RSCanvasController.
"self population doWithIndex: [ :gen :i| gen doWithIndex: [ :ind :j|  |circle pos eb|
		circle := RSEllipse new size: 10; model: (Array with: ind with: (i@j)).
    	canvas add: circle.
    	circle @ RSPopup @ RSDraggable.
		eb := RSEdgeBuilder arrowedLine.
		eb canvas: canvas.
		eb color: Color gray.
		eb moveBehind.
		eb connectFrom: [ :model| ind parents] to: circle
	   ""pos := ((j-25)@(i-25)).
    	circle translateTo: pos rounded * 15.""]].
RSNormalizer size
    shapes: canvas nodes;
    normalize: [ :anArray | anArray first fitness ].
RSGridLayout new lineItemsCount: 50; on: canvas nodes.


canvas @RSCanvasController."
^canvas
]
