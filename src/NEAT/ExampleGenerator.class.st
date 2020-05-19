Class {
	#name : #ExampleGenerator,
	#superclass : #Object,
	#instVars : [
		'examples'
	],
	#classInstVars : [
		'examples'
	],
	#category : #'NEAT-Neat-VisualDiscrimination'
}

{ #category : #running }
ExampleGenerator class >> run [ 
	examples:= OrderedCollection new.
	1 to: 25 do:[:unused||ex| 
					ex := Example new.
					ex	createGrid;
						spawnSmall.
				   #(#(5 0) #(0 5) #(5 5)) do: [:vector||exCopy|
														exCopy:= Example new.
														exCopy createGrid.
														exCopy spawnSmall: 0 position:(ex smallIndex).
														exCopy spawnLarge: vector.
														examples add: exCopy]].
 ^examples
]
