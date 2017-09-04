queries-2-multi
q21_moviesWithArgumentList: list
	| cypherString |
	
	cypherString := '
	MATCH (director:Director { name: $director })-[r:DIRECTED]->(movie:Movie)<-[r2:ACTS_IN]-(actor:Actor)
	WHERE actor.birthplace =~ $birthplaceRegex
	RETURN director.name, actor.name, movie.title
	'.
	
	^ list collect: [ :each |
		self graphDb queryByCypher: cypherString arguments: each
	]