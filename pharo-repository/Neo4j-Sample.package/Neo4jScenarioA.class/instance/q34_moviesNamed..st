queries-3-scypher
q34_moviesNamed: title
	| cypherString |
	
	cypherString := '
	MATCH (director:Director)-[r:DIRECTED]->(movie:Movie)
	WHERE movie.title = "{1}"
	RETURN DISTINCT director.name, movie.title
	' format: {title}.
	
	^ self graphDb queryByCypher: cypherString