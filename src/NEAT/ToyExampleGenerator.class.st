Class {
	#name : #ToyExampleGenerator,
	#superclass : #ExampleGenerator,
	#category : #'NEAT-Neat-VisualDiscrimination'
}

{ #category : #running }
ToyExampleGenerator class >> run [ 
	examples:= OrderedCollection new.
	1 to: 25 do:[:unused||ex| 
					ex := ToyExample new.
					ex	createGrid;
						spawnSmall.
					examples add: ex].
 ^examples
]

{ #category : #running }
ToyExampleGenerator >> run [ 
	examples:= OrderedCollection new.
	1 to: 25 do:[:unused||ex| 
					ex := ToyExample new.
					ex	createGrid;
						spawnSmall.].
 ^examples
]
