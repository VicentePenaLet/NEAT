Class {
	#name : #NEIndividual,
	#superclass : #Object,
	#instVars : [
		'parents',
		'children',
		'nodes',
		'connections',
		'random',
		'fitness',
		'species',
		'ticks',
		'results',
		'expected',
		'id'
	],
	#category : #'NEAT-Core'
}

{ #category : #adding }
NEIndividual >> addChildren: anIndividual [
   anIndividual network: 0.
	children add: anIndividual
]

{ #category : #adding }
NEIndividual >> addConnection: aConnection [
	self assert: [ connections noneSatisfy: [ :c | c in = aConnection in and: [ c out =  aConnection out ] ] ] description: 'Cannot have duplicated connections'.

	connections add: aConnection.
	self resetNetwork.
]

{ #category : #adding }
NEIndividual >> addHiddenNode [
	| node |
	node := NENode new setAsHidden.
	node activation: Sigmoid.
	node computed: false.
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividual >> addHiddenNode: aPosition [
	| node |
	node := NENode new setAsHidden.
	node activation: Sigmoid.
	node position: aPosition.
	node computed: false.
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividual >> addInputNode [
	self
		addNode:
			(NENode new
				setAsInput;
				innovationNumber: 1; computed: false)

	"	self outputNodes do: [ :on |
		newWeight := random next * 4 - 2.
		self addConnection: (NEConnection new in: self numberOfNodesWithBias; out: on id; weight: newWeight; makeEnabled; innovationNumber: 1)
	]"
]

{ #category : #adding }
NEIndividual >> addInputNode: aPosition [
	self
		addNode:
			(NENode new
				setAsInput;
				innovationNumber: 1;
				computed: false; position: aPosition)

	"	self outputNodes do: [ :on |
		newWeight := random next * 4 - 2.
		self addConnection: (NEConnection new in: self numberOfNodesWithBias; out: on id; weight: newWeight; makeEnabled; innovationNumber: 1)
	]"
]

{ #category : #adding }
NEIndividual >> addNode: aNode [
	self resetNetwork.
	self addRawNode: aNode.
	aNode id: nodes size.
]

{ #category : #adding }
NEIndividual >> addOutputNode [
	self
		addNode:
			(NENode new
				setAsOutput;
				innovationNumber: 1;
				computed: false; activation: Sigmoid)

	"	self inputNodes do: [ :ino |
		newWeight := random next * 4 - 2.
		self addConnection: (NEConnection new in: ino id; out: self numberOfNodesWithBias; weight: newWeight; makeEnabled; innovationNumber: 1)
	]"
]

{ #category : #adding }
NEIndividual >> addOutputNode: aPosition [
	self
		addNode:
			(NENode new
				setAsOutput;
				innovationNumber: 1;
				activation: Sigmoid;
				computed: false;
				position: aPosition)

	"	self inputNodes do: [ :ino |
		newWeight := random next * 4 - 2.
		self addConnection: (NEConnection new in: ino id; out: self numberOfNodesWithBias; weight: newWeight; makeEnabled; innovationNumber: 1)
	]"
]

{ #category : #initialization }
NEIndividual >> addParent: aParent [
	aParent network: 0.
	parents add: aParent
]

{ #category : #adding }
NEIndividual >> addRawNode: aNode [
	nodes add: aNode
]

{ #category : #'as yet unclassified' }
NEIndividual >> buildNetwork [
	self resetNetwork.
	connections
		do: [ :c | 
			c isEnabled
				ifTrue: [ 
					(nodes at: c in) connect: (nodes at: c out) weight: c weight.
					(nodes at: c out) increaseNumberOfInputs ] ]
]

{ #category : #accessing }
NEIndividual >> children [
	^ children
]

{ #category : #'as yet unclassified' }
NEIndividual >> computeFitness: oneArgBlock [
	"self assert: [ fitness isNil ] description: 'Already compute fitness'."
	fitness ifNotNil: [ ^ self ]. "Already computed"
	fitness := oneArgBlock value: self.
]

{ #category : #accessing }
NEIndividual >> connections [
	^ connections 
]

{ #category : #accessing }
NEIndividual >> connections: someConnections [
	connections := someConnections 
]

{ #category : #copying }
NEIndividual >> copy [
	| newInd |
	newInd := self class new.
	newInd random: self random.
	newInd nodes: (self nodes collect: #copy).
	newInd connections: (self connections collect: #copy).
	newInd fitness: fitness.
	newInd ticks: ticks.
	newInd results: results.
	newInd expected: expected.
	^ newInd
]

{ #category : #'public access' }
NEIndividual >> evaluate: anArray [
	self
		assert: [ anArray size = (self numberOfInputs)]
		description: 'Wrong number of arguments'.
	self buildNetwork.

	"We provide 1 to the first node, which is considered as the bias node"
	self inputNodes
		with: #(1) , anArray
		do: [ :n :aValue | n evaluate: aValue ].
	^ self outputNodes collect: [ :n | n result ] as: Array
]

{ #category : #'as yet unclassified' }
NEIndividual >> expected: n [
 expected:= n
]

{ #category : #accessing }
NEIndividual >> fitness [
	self assert: [ fitness notNil ] description: 'Need to compute fitness first'.
	^ fitness
]

{ #category : #'as yet unclassified' }
NEIndividual >> fitness: aFitnessValue [
	"Private method"
	fitness := aFitnessValue
]

{ #category : #ui }
NEIndividual >> gtInspectorListIn: composite [
	<gtInspectorPresentationOrder: -1>
	composite list
		title: 'Innov';
		display: #innovationNumberSequence
]

{ #category : #ui }
NEIndividual >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ 	self visualize ]
]

{ #category : #accessing }
NEIndividual >> hasChildren [
	^ children notEmpty
]

{ #category : #accessing }
NEIndividual >> id [
^id
]

{ #category : #accessing }
NEIndividual >> id: i [
id:=i.
]

{ #category : #initialization }
NEIndividual >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	connections := OrderedCollection new.
	"self seed: 42."
	
	"This is the bias node"
	
	
	parents := OrderedCollection new: 2.
	children := OrderedCollection new
]

{ #category : #accessing }
NEIndividual >> innovationNumberSequence [
	self connections ifEmpty: [ ^ #(0) ].
	^ self connections collect: #innovationNumber as: Array
]

{ #category : #'as yet unclassified' }
NEIndividual >> inputNodes [
	^ nodes select: #isInput
]

{ #category : #testing }
NEIndividual >> isNode: node1Id connectedTo: node2Id [
	^ connections anySatisfy: [ :c | c in = node1Id and: [ c out = node2Id ] ]
]

{ #category : #accessing }
NEIndividual >> nodes [
	^ nodes
]

{ #category : #accessing }
NEIndividual >> nodes: someNodes [
	nodes := someNodes 
]

{ #category : #accessing }
NEIndividual >> numberOfChildren [
	^ children size
]

{ #category : #'as yet unclassified' }
NEIndividual >> numberOfConnections [
	^ connections size
]

{ #category : #'as yet unclassified' }
NEIndividual >> numberOfInputs [
	"We substracte one for the bias"
	^ self inputNodes size -1 
]

{ #category : #'as yet unclassified' }
NEIndividual >> numberOfNodes [
	"Exclude the bias node"
	^ nodes size - 1
]

{ #category : #'as yet unclassified' }
NEIndividual >> numberOfNodesWithBias [
	^ self nodes size
]

{ #category : #'as yet unclassified' }
NEIndividual >> numberOfOutputs [
	^ self outputNodes size
]

{ #category : #'as yet unclassified' }
NEIndividual >> outputNodes [
	^ nodes select: #isOutput
]

{ #category : #accessing }
NEIndividual >> parents [
	^ parents
]

{ #category : #'as yet unclassified' }
NEIndividual >> predict: inputs [
	"Make a prediction. This method assumes that the number of outputs is the same as the number of different values the network can output"
	"The index of a collection begins at 1 in Pharo"
	| outputs |
	outputs := self evaluate: inputs.
	^ (outputs indexOf: (outputs max)) - 1
]

{ #category : #printing }
NEIndividual >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	fitness ifNotNil: [ str nextPutAll: fitness asString ].
	str nextPut: $>.
	str nextPut: $<.
	fitness ifNotNil: [ str nextPutAll: id asString ].
	str nextPut: $>.
]

{ #category : #accessing }
NEIndividual >> random [
	^ random
	
]

{ #category : #accessing }
NEIndividual >> random: aRandomNumberGenerator [
	random := aRandomNumberGenerator
]

{ #category : #'as yet unclassified' }
NEIndividual >> resetFitness [
	fitness := nil
]

{ #category : #'as yet unclassified' }
NEIndividual >> resetNetwork [
	nodes do: #resetConnections
]

{ #category : #'as yet unclassified' }
NEIndividual >> results: n [
 results:= n
]

{ #category : #'instance creation' }
NEIndividual >> seed: aSeed [
	self random: (Random seed: aSeed)
]

{ #category : #accessing }
NEIndividual >> species [
	^ species
]

{ #category : #accessing }
NEIndividual >> species: anObject [
	species := anObject
]

{ #category : #'as yet unclassified' }
NEIndividual >> t: n [
 t:= n
]

{ #category : #accessing }
NEIndividual >> ticks [ 
^ticks
]

{ #category : #accessing }
NEIndividual >> ticks: n [
ticks:= n
]

{ #category : #tracing }
NEIndividual >> trace: anArray [
	"Do nothing here. This method is meant to be a hook"
]

{ #category : #ui }
NEIndividual >> visualize [
	| b |
	self buildNetwork.
	b := RTMondrian new.
	b shape label text: #id;
		color: Color gray;
		if: #isInput color: Color blue;
		if: #isOutput color: Color red;
		if: #isBias color: Color yellow.
	b nodes: self nodes.
	b edges connectToAll: #connectedNodes.
	b layout tree.
	^ b
]

{ #category : #'as yet unclassified' }
NEIndividual >> visualizeOutputs [
|position grid c predictedIndex |
c := RSCanvas new.

RSGridLayout new lineItemsCount: grid first size; gapSize: 0; on: c shapes.
c @ RSCanvasController.

self outputNodes do:[:node||pos| pos = node position rounded.
			grid doWithIndex: [ :row :y |
    row doWithIndex: [ :value :x ||box|
        box := RSBox new size: 10.
        value = 0 
            ifTrue: [ box color: Color black ] 
            ifFalse: [  box color: Color white  ].
		(x @ y)  =	 position ifTrue: [ box color: Color red ].
		(x @ y)  = (predictedIndex first @ predictedIndex last) ifTrue: [ box color: Color green ].
        c add: box.
    ]
].]
]
