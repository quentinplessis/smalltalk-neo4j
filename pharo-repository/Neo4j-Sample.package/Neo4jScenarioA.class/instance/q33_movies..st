queries-3-scypher
q33_movies: director
	| cypherString |
	
	cypherString := '
	MATCH (director:Director {1})-[r:DIRECTED]->(movie:Movie {2})
	RETURN DISTINCT director.{3}, movie.{4}
	' format: {director}.
	
	^ self graphDb queryByCypher: cypherString