Class {
	#name : #Agent,
	#superclass : #Object,
	#instVars : [
		'network',
		'inputs',
		'outputs',
		'n',
		'speed',
		'maxSpeed'
	],
	#category : #'NEAT-FoodGathering'
}

{ #category : #'as yet unclassified' }
Agent >> generateInputCoordenates [
	|m|
	m := 1.
   inputs := (1 to: n) collect: [ :i | |point x y angle|
							angle := 2*3.14159265359/n.
							x := ((i*angle) sin) * m. 
							y:= ((i*angle) cos) * m.
							point := (x @ y)]
	
]

{ #category : #'as yet unclassified' }
Agent >> generateOutputCoordenates [
	|m|
	m := 2.
   outputs := (1 to: n) collect: [ :i | |point x y angle|
							angle := 2*3.14159265359/n.
							x := ((i*angle) sin) * m. 
							y:= ((i*angle) cos) * m.
							point := (x @ y)]
	
]

{ #category : #'as yet unclassified' }
Agent >> getMaxOutput [
	|out m|
	out:= network nodes select:[:node| node isOutput].
	m := 0.
	out do: [:node| (m < node result) ifTrue:[m:= node result]].
	^m.
]

{ #category : #'as yet unclassified' }
Agent >> getSpeed [
	|oMax oTot|
	oMax := self getMaxOutput.
	oTot := self getTotalOutput.
	^ (maxSpeed  * oMax) * (oMax / oTot)
]

{ #category : #'as yet unclassified' }
Agent >> getTotalOutput [
	|out sum|
	out:= network nodes select:[:node| node isOutput].
	sum := 0.
	out do: [ :node| sum := sum + (node value)].
	^sum.
]

{ #category : #'as yet unclassified' }
Agent >> maxSpeed [
^maxSpeed 
]

{ #category : #'as yet unclassified' }
Agent >> maxSpeed: s [
	maxSpeed =  s
]

{ #category : #'as yet unclassified' }
Agent >> nSensor [
^n.
	
]

{ #category : #'as yet unclassified' }
Agent >> nSensor: number [
	n:= number.
	
]

{ #category : #'as yet unclassified' }
Agent >> network [ 
	^network
]

{ #category : #'as yet unclassified' }
Agent >> network: net [
	network := net
]
