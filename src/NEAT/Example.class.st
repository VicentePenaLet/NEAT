Class {
	#name : #Example,
	#superclass : #Object,
	#instVars : [
		'grid',
		'smallPosition',
		'largePosition',
		'smallIndex',
		'smallSize',
		'predicted',
		'c',
		'largeIndex',
		'predictedIndex'
	],
	#category : #'NEAT-Neat-VisualDiscrimination'
}

{ #category : #copying }
Example >> canvas [
	^c

]

{ #category : #copying }
Example >> copy [ 
|newExample|
newExample := Example new.
newExample grid: grid copy;
			  smallPosition: smallPosition;
			  smallIndex: smallIndex;
			  largePosition: largePosition;
			  smallSize: smallSize.
^ newExample 
]

{ #category : #copying }
Example >> createGrid [
| image |
image:= OrderedCollection new. 
-1 to: 1 by:0.2s do: [ :x| |inner| 
									inner:= OrderedCollection new. 
									-1 to: 1 by: 0.2s do:
										[ :y| inner add:  0].
									image add: inner].
grid:=image

]

{ #category : #copying }
Example >> draw [
|position|
c := RSCanvas new.

position:= (largeIndex last @ largeIndex first).
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
].

RSGridLayout new lineItemsCount: grid first size; gapSize: 0; on: c shapes.
c @ RSCanvasController.

]

{ #category : #copying }
Example >> evaluate: cpp [
|input|
input:= OrderedCollection new.
self grid do:[:row| input addAll: row].
cpp evaluate: input.

]

{ #category : #copying }
Example >> grid [
	^grid

]

{ #category : #copying }
Example >> grid: aGrid [
	grid:= aGrid.

]

{ #category : #copying }
Example >> largeIndex [
	^largeIndex.

]

{ #category : #copying }
Example >> largePosition [
	^largePosition 

]

{ #category : #copying }
Example >> largePosition: aPosition [
largePosition := aPosition 

]

{ #category : #copying }
Example >> placeValue: value atRow: i column: j [
  | row |
  row := grid at: i ifAbsentPut: [OrderedCollection new].
  j - row size timesRepeat: [row add: nil].
  row at: j put: value

]

{ #category : #copying }
Example >> predicted [
 ^predicted

]

{ #category : #copying }
Example >> predicted: array [
	predicted:= array

]

{ #category : #copying }
Example >> predictedIndex [
 ^predictedIndex 

]

{ #category : #copying }
Example >> predictedIndex: idx [
	predictedIndex := idx.

]

{ #category : #copying }
Example >> putSquare: size atRow: i column: j [ 
		(size negated) to:  size do:
			[:x| (size negated) to:  size do: 
				[:y| self placeValue: 1 atRow: (i+x) column: (j+y)]]

]

{ #category : #copying }
Example >> smallIndex [
^smallIndex.

]

{ #category : #copying }
Example >> smallIndex: index [
smallIndex:=index.

]

{ #category : #copying }
Example >> smallPosition [
	^smallPosition 

]

{ #category : #copying }
Example >> smallPosition: aPosition [
	smallPosition:= aPosition.

]

{ #category : #copying }
Example >> smallSize: size [
smallSize:= size.

]

{ #category : #copying }
Example >> spawnLarge: aPosition [
	|largeSize i j values| 
	largeSize:= (smallSize*2)+1.
	i:= (aPosition at:1) + (smallIndex  at:1).
	j:= (aPosition at:2) + (smallIndex at:2).
	
	(j>11) ifTrue:[j:=j-11].
   (i>11) ifTrue:[i:=i-11].
   
	((11-largeSize)<i) ifTrue:[i:= i - (11-largeSize)].
   ((11-largeSize)<j) ifTrue:[j:= j - (11-largeSize)].
   
	(largeSize +1 > j) ifTrue:[j:= largeSize+1].
	(largeSize +1 > i) ifTrue:[i:= largeSize+1].

	self putSquare: largeSize atRow: i column: j.
	largeIndex := Array with: i with: j.
	values:= -1 to: 1 count: 11.
	largePosition := Array with: (values at: i) with: (values at: j)

]

{ #category : #copying }
Example >> spawnSmall [
	self spawnSmall: 0.

]

{ #category : #copying }
Example >> spawnSmall: size [
   |x y|
	x:= (1 to: 11) atRandom.
	y:= (1 to: 11) atRandom.
	self spawnSmall: size position: (Array with: x with:y). 

]

{ #category : #copying }
Example >> spawnSmall: size position: aPosition [
   |values x y|
	smallSize:= size.
	values:= -1 to: 1 count: 11.

	x:= aPosition at:1.
	y:= aPosition at:2.

	self putSquare: smallSize atRow: x column: y.
	smallPosition := Array with: (values at: x) with:(values at: y).
	smallIndex:= Array with: x with: y	

]

{ #category : #copying }
Example >> valueAtRow: i column: j [
  | row |
  row := grid at: i ifAbsent: [^nil].
  ^row at: j ifAbsent: [nil]

]
