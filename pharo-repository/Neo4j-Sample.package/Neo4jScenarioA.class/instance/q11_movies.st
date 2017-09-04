queries-1-arguments
q11_movies
	| cypherString |
	
	cypherString := '
	MATCH (director:Director { name: "James Cameron" })-[r:DIRECTED]->(movie:Movie)<-[r2:ACTS_IN]-(actor:Actor { name: "Leonardo DiCaprio" })
	RETURN director.name, actor.name, movie.title
	'.
	
	^ self graphDb queryByCypher: cypherString