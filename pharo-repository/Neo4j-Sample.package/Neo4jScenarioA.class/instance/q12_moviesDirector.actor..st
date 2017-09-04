queries-1-arguments
q12_moviesDirector: director actor: actor
	| cypherString |
	
	cypherString := '
	MATCH (director:Director \{ name: "{1}" \})-[r:DIRECTED]->(movie:Movie)<-[r2:ACTS_IN]-(actor:Actor \{ name: "{2}" \})
	RETURN director.name, actor.name, movie.title
	' format: {director. actor}.
	
	^ self graphDb queryByCypher: cypherString