Class {
	#name : #FGSensor,
	#superclass : #Object,
	#instVars : [
		'position',
		'minAngle',
		'maxAngle',
		'output',
		'initPosition',
		'initialPosition',
		'angle',
		'angleDegree',
		'agentPosition'
	],
	#category : #'NEAT-FoodGathering'
}

{ #category : #accessing }
FGSensor >> agentPosition [
^agentPosition 
]

{ #category : #accessing }
FGSensor >> agentPosition: pos [
agentPosition := pos
]

{ #category : #accessing }
FGSensor >> angleDegree [
 ^angleDegree 
]

{ #category : #accessing }
FGSensor >> bounds: l and: r [
minAngle:=l.
maxAngle:=r. 
]

{ #category : #accessing }
FGSensor >> initialPosition [
	^initialPosition
]

{ #category : #accessing }
FGSensor >> initialPosition: point [
	initialPosition:= point
]

{ #category : #accessing }
FGSensor >> isInRange: angl [
|max ang|
max := maxAngle.
ang := angl.
(maxAngle < minAngle) ifTrue:[max := max + (2 * Float pi). ang := ang + (2* Float pi)].
^ ((minAngle <= ang) and: (ang <= max)) or: ((minAngle <= angle) and: (angle <= max))
]

{ #category : #accessing }
FGSensor >> maxAngle [
 ^maxAngle
]

{ #category : #accessing }
FGSensor >> measure: point [
  angle:= ((point y - agentPosition y)/ (point x - agentPosition x)) arcTan.
  ((point x - agentPosition x) < 0) ifTrue: [ angle := angle + (Float pi)].
  ((point y - agentPosition y) < 0) ifTrue: [ angle := angle + (Float pi * 2)].
  angle := Angle bound: angle. 
  angleDegree := angle *180 /  Float pi.
  (self isInRange: angle) ifFalse: [ output:= 0];
								  ifTrue: [ output := point dist: position]

	
]

{ #category : #accessing }
FGSensor >> minAngle [
 ^minAngle
]

{ #category : #accessing }
FGSensor >> moveTowards: point withSpeed: aSpeed [
|direction|
	direction := point /  ( point squaredDistanceTo: position) sqrt.
	position := position + (aSpeed * direction). 
]

{ #category : #accessing }
FGSensor >> output [
 ^output
]

{ #category : #accessing }
FGSensor >> position [
	^position
]

{ #category : #accessing }
FGSensor >> position: coord [
position:= coord.
]

{ #category : #accessing }
FGSensor >> resetPosition [
 position:= initialPosition.
]
