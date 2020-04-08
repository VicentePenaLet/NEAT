Class {
	#name : #NECPPNGeneratedNode,
	#superclass : #NENode,
	#instVars : [
		'bias'
	],
	#category : #'NEAT-Core'
}

{ #category : #'as yet unclassified' }
NECPPNGeneratedNode >> bias [
	^ self bias
]

{ #category : #'as yet unclassified' }
NECPPNGeneratedNode >> bias: n [
	bias:=n
]

{ #category : #'as yet unclassified' }
NECPPNGeneratedNode >> evaluate: aValue [
	"	self isInput ifFalse: [
		self assert: [ aValue >= 0 ].
		self assert: [ aValue <= 1 ] ]."

	"We just received a value. We add it to zValue."

	self computed
		ifTrue: [ result := self isInput
				ifTrue: [ ^ zValue + bias ]
				ifFalse: [ ^ Sigmoid apply: (zValue +bias)] ].
	zValue := zValue + aValue.

	"We say we received a new value"
	numberOfReceivedValues := numberOfReceivedValues + 1.

	"	self haltIf: [ numberOfReceivedValues > numberOfInputs ]."
	"If we received the number of zValues, then we can compute the value of the activation, and keep it."
	(numberOfReceivedValues = numberOfInputs)
		ifFalse: [ ^ self ];
		ifTrue: [self computed: true.
	self isInput
		ifTrue: [result :=  zValue + bias. 
			self evaluateHigherLevels].
	self isOutput
		ifTrue: [ result := Sigmoid apply: (zValue +bias) ].
	self isHidden
		ifTrue: [ result := Sigmoid apply: (zValue + bias)].
		self evaluateHigherLevels]
]

{ #category : #'as yet unclassified' }
NECPPNGeneratedNode >> evaluateHigherLevels [
	connectionsCache do: [ :connection| 
		((connection value) level > self level) ifTrue:
		[connection value evaluate: (result * connection key)]]
]

{ #category : #'as yet unclassified' }
NECPPNGeneratedNode >> evaluateRecursive [
	connectionsCache do: [ :connection| 
		((connection value) level >= self level) ifTrue:
		[zValue := zValue + (connection key * (Sigmoid apply:(connection value zValue)))]]
]
