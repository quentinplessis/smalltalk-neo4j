queries
kNNRecommendationForUser: name
	| cypherString |
	
	cypherString := '
	MATCH (person:Person { name: $name })-[s:SIMILARITY]->(person2:Person)-[r:RATED]->(movie:Movie)
	WHERE NOT((person)-[:RATED]->(movie))
	WITH distinct movie, s.similarity as similarity, r.stars as rating
	ORDER BY similarity desc
	WITH distinct movie, collect(rating)[0..3] as ratings
	UNWIND ratings as rating
	WITH distinct movie, avg(rating) as recommendation
	RETURN movie.title, recommendation ORDER BY recommendation desc
	'.
	
	^ self graphDb queryByCypher: cypherString arguments: {('name' -> name)} asDictionary