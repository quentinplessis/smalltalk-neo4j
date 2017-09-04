queries-1-arguments
q13_moviesDirector: director actorBornIn: country
	| cypherString |
	
	cypherString := '
	MATCH (director:Director \{ name: "{1}" \})-[r:DIRECTED]->(movie:Movie)<-[r2:ACTS_IN]-(actor:Actor)
	WHERE actor.birthplace =~ ".*{2}.*"
	RETURN director.name, actor.name, movie.title
	' format: {director. country}.
	
	^ self graphDb queryByCypher: cypherString