Class {
	#name : #NEIndividualCPPN,
	#superclass : #NEIndividual,
	#instVars : [
		'network'
	],
	#classInstVars : [
		'inputs',
		'outputs'
	],
	#category : #'NEAT-Core'
}

{ #category : #testing }
NEIndividualCPPN class >> inputs [
	^inputs
]

{ #category : #testing }
NEIndividualCPPN class >> inputs: anArray [
	inputs:= anArray
]

{ #category : #testing }
NEIndividualCPPN class >> isHidden: position [
	^ ((self isInput: position) or: (self isOutput: position)) not.
]

{ #category : #testing }
NEIndividualCPPN class >> isInput: position [
	^ inputs includes: position
]

{ #category : #testing }
NEIndividualCPPN class >> isOutput: position [
	^ outputs includes: position
]

{ #category : #testing }
NEIndividualCPPN class >> outputs [
	  ^outputs
]

{ #category : #testing }
NEIndividualCPPN class >> outputs: anArray [
	outputs:= anArray
]

{ #category : #adding }
NEIndividualCPPN >> addHiddenNode [
	| node |
	node := NENode new setAsHidden.
	node activation: ActivationFunction allSubclasses atRandom.
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividualCPPN >> addHiddenNode: level [
	| node |
	node := NENode new setAsHidden: level.
	node activation: ActivationFunction allSubclasses atRandom.
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividualCPPN >> addInputNode [
	| node |
	node := NENode new setAsInput .
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividualCPPN >> addInputNode: aPosition [
	| node |
	node := NENode new setAsInput .
	node position: aPosition.
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividualCPPN >> addOutputNode [
	| node |
	node := NENode new setAsOutput.
	node activation: ActivationFunction allSubclasses atRandom.
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividualCPPN >> addOutputNode: aPosition [
	| node |
	node := NENode new setAsOutput.
	node activation: ActivationFunction allSubclasses atRandom.
	node position: aPosition.
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividualCPPN >> build [
	| b |
	network := NECPPNGenerated new.
	network nodes: OrderedCollection new.
	b := [ :position | 
	(NEIndividualCPPN  isInput: position)
		ifTrue: [ network addInputNode: position level: 0 bias: ((self evaluatePosition: position and: #(0 0 0)) at: 2)].
	(NEIndividualCPPN isHidden: position)
		ifTrue: [ network addHiddenNode: position level: ((position at: 3)+5) bias: ((self evaluatePosition: position and: #(0 0 0))at:2)].
	(NEIndividualCPPN isOutput: position)
		ifTrue: [ network addOutputNode: position level: 100 bias: ((self evaluatePosition: position and: #(0 0 0))at:2)]].
	-1 to: 1 do: [ :x | 
		-1 to: 1 do:[:y| 
			-1 to: 1  do: [:z | b cull: (Array with: x with: y with: z)]]].
	network connections: OrderedCollection new.
	network nodes
		collect: [ :node1 | 
			network nodes
				collect: [ :node2 | 
					| weight connection |
					weight := (self evaluatePosition: (node1 position) and: (node2 position)) at: 1.
					connection := NEConnection new.
					connection
						in: node1 id;
						out: node2 id;
						weight: weight;
						makeEnabled.
					weight abs < 0
						ifTrue: [ connection makeDisabled ].
					network connections add: connection ] ]
]

{ #category : #adding }
NEIndividualCPPN >> buildANNFromCPP [
		"We build the network from ind, the CPP"
		| net|
	    net := NEIndividual new.
		"This depends on the problem to solve, the XOR"
		
		NEIndividualCPPN inputs do: [ :position| net addInputNode: position ]. 
		NEIndividualCPPN outputs do: [ :position| net addOutputNode:position ].

		
		net inputNodes do: [ :node1| net outputNodes do:[:node2| |array| array := (Array with: (node1 position first) with:(node1 position last) with:(node2 position first) with: (node2 position last)).
																							net addConnection: (NEConnection new 
																											makeEnabled; 
																											in: (node1 id);
																											out: (node2 id);
																											weight: ((super evaluate: array) first))]].
		
		self network: net
]

{ #category : #adding }
NEIndividualCPPN >> evaluate: anArray [
	|result|
	self network = nil
		ifFalse: [ ^ self evaluateAux: anArray ].
   self buildANNFromCPP.
	network buildNetwork.
	result:=network evaluate: anArray.
	"network:= nil."
	^ result
]

{ #category : #adding }
NEIndividualCPPN >> evaluateAux: anArray [
	self
		assert: [ anArray size = (self network numberOfInputs +1)]
		description: 'Wrong number of arguments'.
	self network buildNetwork.

	"We provide 1 to the first node, which is considered as the bias node"
	self network inputNodes
		with: anArray
		do: [ :n :aValue | n evaluate: aValue ].
	^ self network outputNodes collect: [ :n | n result ] as: Array
]

{ #category : #adding }
NEIndividualCPPN >> evaluatePosition: position1 and: position2 [
^ super evaluate: (Array
								with: (position1 at: 1)
								with: (position1 at: 2)
								with: (position2 at: 1)
								with: (position2 at: 2)).
]

{ #category : #adding }
NEIndividualCPPN >> network [
	^network
]

{ #category : #adding }
NEIndividualCPPN >> network: aNetwork [
	network := aNetwork
]
