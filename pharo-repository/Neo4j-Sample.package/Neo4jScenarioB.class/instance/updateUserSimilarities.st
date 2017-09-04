queries
updateUserSimilarities
	| cypherString |
	
	cypherString := '
	MATCH (p1:Person)-[x:RATED]->(m:Movie)<-[y:RATED]-(p2:Person)
	WITH p1, p2, count(distinct m) as moviesNumber,
	collect({movie: m.title, person1Stars: x.stars, person2Stars: y.stars}) as details,
	SUM(x.stars * y.stars) as dotProduct,
	SQRT(REDUCE(xDot = 0.0, a IN COLLECT(x.stars) | xDot + a^2)) as xLength,
	SQRT(REDUCE(yDot = 0.0, b IN COLLECT(y.stars) | yDot + b^2)) as yLength
	WHERE xLength * yLength > 0 AND moviesNumber > 1
	WITH p1, p2, details, dotProduct / (xLength * yLength) as similarity
	MERGE (p1)-[s:SIMILARITY]-(p2)
	SET s.similarity = similarity
	RETURN p1.name, p2.name, similarity, details order by similarity desc'.
	
	^ self graphDb queryByCypher: cypherString