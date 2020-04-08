# HyperNeat for Pharo

This is an implementation of the HyperNeat algorithm in Pharo, this implementation is based on Neat4Pharo in https://github.com/bergel/NEAT. This implementation is still a work in progress.

# Loading HyperNeat for Pharo

In order to load HyperNeat for Pharo execute the following script.

```Smalltalk
Metacello new
    baseline: 'Roassal2';
    repository: 'github://ObjectProfile/Roassal2/src';
    load.
Gofer new
    url: 'github://VicentePenaLet/NEAT/src';
    package: 'NEAT';
    load.
```

# Example

The following script configures the algorithm to learn the binary to decimal convertion of 2 bit numbers.

```Smalltalk
dataset := #( #(0 0 0 0) #(0 0 1 1) #(0 1 0 2) #(0 1 1 3) #(1 0 0 4) #(1 0 1 5) #(1 1 0 6) #(1 1 1 7)).

neat := NEAT new.
neat numberOfInputs: 6.
neat numberOfOutputs: 2.
neat individualClass: NEIndividualCPPN.
NEIndividualCPPN inputs: #(#(1 1 -1) #(1 -1 -1) #(-1 1 -1) #(-1 -1 -1)).
NEIndividualCPPN outputs: #(#(-1 -1 1) #(-1 0 1) #(-1 1 1) #(0 -1 1) #(0 1 1) #(1 -1 1) #(1 0 1) #(1 1 1)).
neat populationSize: 50.
neat fitness: [ :ind |
        sumError := 0.
		  actual:= OrderedCollection new.
		  expected:= OrderedCollection new.
        dataset do: [ :row |
                outputs := ind evaluate: row allButLast.
                expectedOutput := (1 to: NEIndividualCPPN outputs size) collect: [ :notUsed | 0 ].
                expectedOutput at: (row last + 1) put: 1.
                t := (1 to: NEIndividualCPPN outputs size) collect: [ :i | ((expectedOutput at: i) - (outputs at: i)) squared ].
                sumError := sumError + t sum.
					actual add: outputs.
					expected add: expectedOutput.
        ].
			ind expected: expected.
			ind results: actual.
        sumError negated.].

neat numberOfGenerations: 10.
neat run.
```






