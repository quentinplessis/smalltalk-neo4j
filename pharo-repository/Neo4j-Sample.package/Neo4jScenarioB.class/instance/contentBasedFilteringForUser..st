queries
contentBasedFilteringForUser: name
	| cypherString |
	
	cypherString := '
	MATCH (person:Person { name: $name })-[r:RATED]->(movie:Movie)
	MATCH (movie2:Movie)<-[r2:RATED]-(person2:Person)
	WITH person, movie, movie2, avg(r2.stars) as rating
	WHERE movie2.genre = movie.genre AND rating >= 3
	RETURN movie.title, movie.genre, movie2.title, movie2.genre, rating order by rating desc limit 10'.
	
	^ self graphDb queryByCypher: cypherString arguments: {('name' -> name)} asDictionary