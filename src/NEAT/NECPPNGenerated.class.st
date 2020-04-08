Class {
	#name : #NECPPNGenerated,
	#superclass : #NEIndividual,
	#instVars : [
		'network'
	],
	#category : #'NEAT-Core'
}

{ #category : #adding }
NECPPNGenerated >> addHiddenNode: aPosition level: aLevel [
	| node |
	node := NECPPNGeneratedNode new setAsHidden: aLevel.
	node activation: Sigmoid.
	node position: aPosition.
	self addNode: node.
	^ node
]

{ #category : #adding }
NECPPNGenerated >> addHiddenNode: aPosition level: aLevel bias: n [
	| node |
	node := NECPPNGeneratedNode new setAsHidden: aLevel.
	node activation: Sigmoid.
	node position: aPosition.
	node bias: n.
	node result = 0.
	self addNode: node.
	^ node
]

{ #category : #adding }
NECPPNGenerated >> addInputNode: aPosition level: aLevel [
	| node |
	node := NECPPNGeneratedNode new setAsInput.
	node activation: Sigmoid.
	node position: aPosition.
	self addNode: node.
	^ node
]

{ #category : #adding }
NECPPNGenerated >> addInputNode: aPosition level: aLevel bias: n [
	| node |
	node := NECPPNGeneratedNode new setAsInput.
	node activation: Sigmoid.
	node position: aPosition.
	node result = 0.
	node bias: n.
	self addNode: node.
	^ node
]

{ #category : #adding }
NECPPNGenerated >> addOutputNode: aPosition level: aLevel [ 
	| node |
	node := NECPPNGeneratedNode new setAsOutput: aLevel.
	node activation: Sigmoid.
	node position: aPosition.
	
	node result = 0.
	self addNode: node.
	^ node
]

{ #category : #adding }
NECPPNGenerated >> addOutputNode: aPosition level: aLevel bias: n [
	| node |
	node := NECPPNGeneratedNode new setAsOutput: aLevel.
	node activation: Sigmoid.
	node position: aPosition.
	node bias: n.
	node result = 0.
	self addNode: node.
	^ node
]

{ #category : #adding }
NECPPNGenerated >> buildNetwork [
	| node1 node2 |
	self resetNetwork.
	connections
		do: [ :c | 
			(c isEnabled)
				ifTrue: [ (nodes at: c in) connect: (nodes at: c out) weight: (c weight).
					node1 := (nodes at: c in).
					node2 := (nodes at: c out).
					((nodes at: c in) level > (nodes at: c out) level)
						ifTrue: [(nodes at: c in) increaseNumberOfInputs ]]]
]

{ #category : #'public access' }
NECPPNGenerated >> evaluate: anArray [
	self
		assert: [ anArray size = self numberOfInputs ]
		description: 'Wrong number of arguments'.
	self buildNetwork.
	"We provide 1 to the first node, which is considered as the bias node"
	self inputNodes
		do: [ :input | 
			self nodes 
				do: [ :node | input evaluate: node value ] ].
	self inputNodes
		with: #(1) , anArray
		do: [ :n :aValue | n evaluate: aValue ].
	^ self outputNodes collect: [ :n | n result ] as: Array
]
