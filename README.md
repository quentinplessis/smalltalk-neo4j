# Manipulating Neo4j from Pharo Smalltalk

Sample code to manipulate Neo4j data from Pharo Smalltalk via Cypher queries, using Neo4reSt and SCypher libraries.

## Installation
```smalltalk
Metacello new
    baseline: 'Neo4jSample';
    repository: 'github://github.com/quentinplessis/smalltalk-neo4j:v0.1/pharo-repository';
    load.
```
Package: Neo4j-Sample

## Neo4j environment
A Neo4j docker image containing sample data is provided.
Docker and ruby must be installed and running.

## Launch Neo4j
```shell
ruby setup.rb start
```

## Stop Neo4j
```shell
ruby setup.rb stop
```

## Sample code
### Get Started
```smalltalk
N4Settings default rootUri: 'http://localhost:7474/db/data/'. 

"Arguments"
scenarioA := Neo4jScenarioA new.
scenarioA debug: true.
scenarioA q11_movies.
scenarioA q12_moviesDirector: 'James Cameron' actor: 'Leonardo DiCaprio'.
scenarioA q13_moviesDirector: 'James Cameron' actorBornIn: 'California'.
scenarioA q14_moviesDirector: 'James Cameron' actorBornIn: 'California'.

"Multi"
argumentsList := { 
	{
		'director' -> 'James Cameron'.
		'birthplaceRegex' -> '.*California.*'.
	} asDictionary.
	{
		'director' -> 'George Lucas'.
		'birthplaceRegex' -> '.*Washington.*'.
	} asDictionary.
	{
		'director' -> 'Stanley Kubrick'.
		'birthplaceRegex' -> '.*Chicago.*'.
	} asDictionary.
}.
scenarioA q21_moviesWithArgumentList: argumentsList.
scenarioA debug: true.
scenarioA graphDb latency: 0.
scenarioA graphDb latency: 10.
fullArgumentsList := OrderedCollection new.
100 timesRepeat: [ fullArgumentsList addAll: argumentsList ].
scenarioA q21_moviesWithArgumentList: fullArgumentsList.
scenarioA q22_moviesWithArgumentList: fullArgumentsList.

"SCypher"
scenarioA q31_movies: '{language: "en", genre: "Action"}'.
properties := { 
	'language' -> 'en'.
 } asDictionary.
scenarioA q31_movies: properties asJsonString. "Json format not recognized by Neo4j"

scenarioA scypherSamples.
scenarioA q32_moviesWhere: properties.

scenarioA q34_moviesNamed: 'Titanic'.
scenarioA q34_moviesNamed: ''.
scenarioA q34_moviesNamed: nil.
scenarioA debug: true.
scenarioA q35_moviesNamed: 'Titanic'.
scenarioA q35_moviesNamed: ''.
scenarioA q35_moviesNamed: nil.
```

### Simple recommendation engine
```smalltalk

"Recommendation"

scenarioB := Neo4jScenarioB new.
scenarioB debug: true.

personName := 'Yuri'.

scenarioB contentBasedFilteringForUser: personName.
scenarioB scypher_contentBasedFilteringForUser: personName.
scenarioB scypher_contentBasedFilteringForUser: personName rating: 3 limit: 30.
scenarioB scypher_contentBasedFilteringForUser: personName rating: 2 limit: 30.

scenarioB updateUserSimilarities.

scenarioB kNNRecommendationForUser: personName.
scenarioB scypher_kNNRecommendationForUser: personName.
```




