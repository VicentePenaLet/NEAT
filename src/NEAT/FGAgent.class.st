Class {
	#name : #FGAgent,
	#superclass : #Object,
	#instVars : [
		'network',
		'inputs',
		'outputs',
		'n',
		'speed',
		'maxSpeed',
		'position',
		'score',
		'sensors',
		'maxTicks',
		'cpp',
		'tolerance',
		'ttot',
		'fitness',
		'capturedFood',
		'positionHistory',
		'canvas',
		'i',
		'drawings'
	],
	#category : #'NEAT-FoodGathering'
}

{ #category : #'as yet unclassified' }
FGAgent >> computeFitness [
 fitness := (10000*(score/n) )+ ((1000* n) -ttot) 
	
]

{ #category : #'as yet unclassified' }
FGAgent >> copy [
|newAgent|
newAgent := FGAgent new.
newAgent drawings: drawings.
	
]

{ #category : #'as yet unclassified' }
FGAgent >> cpp [ 
	^cpp
]

{ #category : #'as yet unclassified' }
FGAgent >> cpp: net [
	cpp := net
]

{ #category : #'as yet unclassified' }
FGAgent >> draw [ 
drawings := OrderedCollection new.
positionHistory asArray with: self getFoodPositions do: [:posHistory :foodPosition ||foodCircle|
	canvas := RSCanvas new. 
	posHistory doWithIndex: [ :pos :ind| |circle|
	 												circle := RSEllipse new size: 5; model: ind.
    												canvas add: circle.
    												circle @ RSPopup.
    												circle translateTo: pos rounded * 5.].
	
	"foodCircle := RSEllipse new size: 20; color: Color red.
	canvas add: foodCircle.
	foodCircle @ RSPopup.
	foodCircle translateTo: foodPosition rounded * 5."
	canvas @ RSCanvasController.
	drawings add: canvas.  
	].

]

{ #category : #'as yet unclassified' }
FGAgent >> drawings: d [
drawings := d.
]

{ #category : #'as yet unclassified' }
FGAgent >> fitness [ 
^fitness
	
]

{ #category : #'as yet unclassified' }
FGAgent >> generateInputCoordenates [
	|m angle|
	m := 0.5.
	angle := 2*(Float pi)/n.
	sensors := OrderedCollection  new.
   inputs := (1 to: n) collect: [ :i | |point x y lAngle rAngle sensor|
							x := ((i*angle) sin) * m. 
							y:= ((i*angle) cos) * m.
							lAngle := (i*angle) - (angle/2).
							rAngle := (i*angle) + (angle/2).
							lAngle := Angle bound: lAngle.
							rAngle := Angle bound: rAngle.
							point := (x @ y).
							sensor := FGSensor new.
							sensor bounds: lAngle and: rAngle.
							sensor position: point.
							sensor initialPosition: point.
							sensor agentPosition: position.
							sensors add: sensor
							]
	
]

{ #category : #'as yet unclassified' }
FGAgent >> generateOutputCoordenates [
	|m|
	m := 2.
   outputs := (1 to: n) collect: [ :i | |point x y angle|
							angle := 2*3.14159265359/n.
							x := ((i*angle) sin) * m. 
							y:= ((i*angle) cos) * m.
							point := (x @ y)]
	
]

{ #category : #'as yet unclassified' }
FGAgent >> getFoodPositions [
|sensorPosition anglePosition foodPositions|
sensorPosition:= sensors collect:[:sensor| sensor position].
anglePosition := sensors collect:[:sensor| sensor minAngle].
foodPositions := OrderedCollection new.
anglePosition do: [ :angle|  foodPositions add: ((angle cos * 100 )@(angle sin * 100))].
sensorPosition do: [ :pos| |direction|
direction := pos /  ( pos squaredDistanceTo: position) sqrt.
foodPositions add: (pos + (100 * direction))].
^foodPositions 






]

{ #category : #'as yet unclassified' }
FGAgent >> getMaxOutput [
	|out m maxNode|
	out:= cpp network nodes select:[:node| node isOutput].
	m := out first result.
	maxNode := out first.
	out do: [:node| (m < node result abs) ifTrue:[m := node result. maxNode := node.]].
	^maxNode.
]

{ #category : #'as yet unclassified' }
FGAgent >> getSpeed [
	|oMax oTot|
	oMax := self getMaxOutput result.
	oTot := self getTotalOutput.
	^ (maxSpeed  * oMax) * (oMax / (oTot+0.0000000001))
]

{ #category : #'as yet unclassified' }
FGAgent >> getTotalOutput [
	|out sum|
	out:= cpp network nodes select:[:node| node isOutput].
	sum := 0.
	out do: [ :node| sum := sum + (node result)].
	^sum.
]

{ #category : #'as yet unclassified' }
FGAgent >> initialize [ 
   n := 4.
	position:= (0 @ 0).
	maxSpeed := 100.
	maxTicks := 1000.
	tolerance := 5.
	score := 0.
	ttot := 0.
	capturedFood := OrderedCollection new.
	positionHistory := OrderedCollection new.
	self generateInputCoordenates.
	self generateOutputCoordenates.
	

]

{ #category : #'as yet unclassified' }
FGAgent >> maxSpeed [
^maxSpeed 
]

{ #category : #'as yet unclassified' }
FGAgent >> maxSpeed: s [
	maxSpeed =  s
]

{ #category : #'as yet unclassified' }
FGAgent >> measure: point [
 sensors do: [ :sensor| sensor measure: point ]
]

{ #category : #'as yet unclassified' }
FGAgent >> move [ 
	self moveTowards: (self getMaxOutput position) withSpeed: (self getSpeed).
]

{ #category : #'as yet unclassified' }
FGAgent >> moveTowards: point withSpeed: aSpeed [
|direction newOutputs|
	direction := point /  ( point squaredDistanceTo: position) sqrt.
	position := position + (aSpeed * direction). 
	sensors do: [ :sensor| sensor moveTowards: point withSpeed: aSpeed. sensor agentPosition: position].
	newOutputs := OrderedCollection new.
	outputs do: [ :pos| newOutputs  add: (pos + (aSpeed * direction))].
	outputs := newOutputs.
]

{ #category : #'as yet unclassified' }
FGAgent >> nSensor [
^n.
	
]

{ #category : #'as yet unclassified' }
FGAgent >> nSensor: number [
	n:= number.
	
]

{ #category : #'as yet unclassified' }
FGAgent >> network [ 
	^network
]

{ #category : #'as yet unclassified' }
FGAgent >> network: net [
	network := net
]

{ #category : #'as yet unclassified' }
FGAgent >> outputs [ 
^outputs
	
]

{ #category : #'as yet unclassified' }
FGAgent >> positionHistory [
^positionHistory
	
]

{ #category : #'as yet unclassified' }
FGAgent >> positionHistory: history [
positionHistory := history
	
]

{ #category : #'as yet unclassified' }
FGAgent >> resetPosition [
 position:= (0@0).
 sensors do:[:sensor| sensor resetPosition].
 self generateOutputCoordenates
	
]

{ #category : #'as yet unclassified' }
FGAgent >> run [
 cpp expected: self.
 self getFoodPositions do:[:foodPosition | self resetPosition.
														self runTrial: foodPosition].
 self computeFitness.

													
													
 
	
]

{ #category : #'as yet unclassified' }
FGAgent >> runTrial: foodPosition [
|positions|
positions := OrderedCollection new.
positions add: position.
1 to: maxTicks do: [ :i|  |outs|
						self measure: foodPosition.
						outs:= sensors collect: [:sensor| sensor output.].
						cpp buildANNFromCPP.
						cpp evaluate: outs.
						self getSpeed.
						self move.
						positions add: position.
						((position distanceTo: foodPosition) abs < tolerance) ifTrue: [ score := score + 1.ttot := ttot + i. capturedFood add: foodPosition .positionHistory add: positions.^true]. 
						].
positionHistory add: positions.
ttot := ttot + maxTicks. 
]

{ #category : #'as yet unclassified' }
FGAgent >> score [ 
^score
	
]

{ #category : #'as yet unclassified' }
FGAgent >> score: number [
score:= number
	
]

{ #category : #'as yet unclassified' }
FGAgent >> sensors [
	^sensors
	
]

{ #category : #'as yet unclassified' }
FGAgent >> ttot [
^ttot
	
]
