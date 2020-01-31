Class {
	#name : #NEIndividualCPPN,
	#superclass : #NEIndividual,
	#instVars : [
		'network'
	],
	#category : #'NEAT-Core'
}

{ #category : #adding }
NEIndividualCPPN >> addHiddenNode [
	| node |
	node := NENode new setAsHidden.
	node activation: ActivationFunction allSubclasses atRandom.
	self addNode: node.
	^ node
]

{ #category : #adding }
NEIndividualCPPN >> addHiddenNode: aPosition [
	| node |
	node := NENode new setAsHidden.
	node activation: ActivationFunction allSubclasses atRandom.
	node position: aPosition.
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
	b := [ :x :y | 
	y = -1
		ifTrue: [ network addInputNode: (Array with: x with: y) ].
	(y = 0 and: x = 0)
		ifTrue: [ network addOutputNode: (Array with: x with: y) ].
	(y = -1 or: (y = 0 and: x = 0))
		ifFalse: [ network addHiddenNode: (Array with: x with: y) ] ].
	-1 to: 1 do: [ :x | -1 to: 1 do: [ :y | b cull: x cull: y ] ].
	network connections: OrderedCollection new.
	network nodes
		collect: [ :node1 | 
			network nodes 
				collect: [ :node2 | 
					| weight connection |
					weight := super
						evaluate:
							(Array
								with: node1 position first
								with: node1 position last
								with: node2 position first
								with: node2 position last).
					connection := NEConnection new.
					connection
						in: node1 id;
						out: node2 id;
						weight: weight first + 1;
						makeEnabled.
					network connections add: connection ] ]
]

{ #category : #adding }
NEIndividualCPPN >> evaluate: anArray [
	self network = nil
		ifFalse: [ ^ self network evaluate: anArray ].
	self build.
	network buildNetwork.
	^ network evaluate: anArray
]

{ #category : #adding }
NEIndividualCPPN >> network [
	^network
]

{ #category : #adding }
NEIndividualCPPN >> network: aNetwork [
	network := aNetwork
]
