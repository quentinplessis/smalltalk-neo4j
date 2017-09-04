queries-3-scypher
q31_movies: movieProperties
	| cypherString |
	
	cypherString := '
	MATCH (director:Director)-[r:DIRECTED]->(movie:Movie {1})
	RETURN DISTINCT director.name, movie.title
	' format: {movieProperties}.
	
	^ self graphDb queryByCypher: cypherString