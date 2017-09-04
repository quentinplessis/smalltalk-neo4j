queries-1-arguments
q14_moviesDirector: director actorBornIn: country
	| cypherString arguments |
	
	cypherString := '
	MATCH (director:Director { name: $director })-[r:DIRECTED]->(movie:Movie)<-[r2:ACTS_IN]-(actor:Actor)
	WHERE actor.birthplace =~ $birthplaceRegex
	RETURN director.name, actor.name, movie.title
	'.
	
	arguments := {
		('director' -> director).
		('birthplaceRegex' -> ('.*{1}.*' format: {country}))
	} asDictionary.
	
	^ self graphDb queryByCypher: cypherString arguments: arguments