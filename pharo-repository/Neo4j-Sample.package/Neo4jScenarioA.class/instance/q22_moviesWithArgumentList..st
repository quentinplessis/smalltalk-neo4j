queries-2-multi
q22_moviesWithArgumentList: list
	| cypherString arguments |
	
	cypherString := '
	MATCH (director:Director { name: $director })-[r:DIRECTED]->(movie:Movie)<-[r2:ACTS_IN]-(actor:Actor)
	WHERE actor.birthplace =~ $birthplaceRegex
	RETURN director.name, actor.name, movie.title
	'.
	
	arguments := list collect: [ :each | {cypherString. each} ].
	
	^ self graphDb queryByCyphersWithArguments: arguments