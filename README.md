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

## Visual Discrimination

```Smalltalk
substrate:= OrderedCollection new.
(-1 to: 1 count: 11) do:[:x| (-1 to: 1 count: 11) do: [ :y| substrate add: (Array with: x with: y)]].


NEIndividualCPPN inputs: substrate. 
NEIndividualCPPN outputs: substrate.


neat := NEAT new.
neat populationSize: 100. 
neat resetConfig.
neat individualClass: NEIndividualCPPN.
neat for: NEConnectionWeightMutationOperation prob: 0.2.
neat for: NEAddConnectionMutationOperation prob: 0.2.
neat for: NEAddNodeMutationOperation prob: 0.03.
neat for: NECrossoverOperation prob: 0.2.
neat for: NEActivationFunctionMutationOperation prob: 0.2.
neat numberOfInputs: 5.
neat numberOfOutputs: 1.



getPosition:= [ :individual| |out m position|
	out:= individual network nodes select:[:node| node isOutput].
	m := 0.
	out do: [:node| (m < node result) ifTrue:[m:= node result. position:= node position]].
	position].


neat fitness: [ :cpp | 
		| score network y1 y2 result error|
		score := 0.
		dataset:= ExampleGenerator run.
		cpp buildANNFromCPP.
		dataset do: [ :example |  example evaluate: cpp.
										 result:= getPosition value: cpp.
										 example predicted: result.
										 error:= (result  - (example largePosition)) squared sum.
										 score:= score + error].
									score negated asFloat].

neat numberOfGenerations: 100.
neat run.
```






