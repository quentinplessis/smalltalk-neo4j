queries-scypher
scypher_contentBasedFilteringForUser: name
	| person movie person2 movie2 query cypherString personToMovie person2ToMovie averageRating sameGenre goodRating return |
	
	person := CyNode name: 'person' label: 'Person' props: {('name' -> name)}.
	movie := CyNode name: 'movie' label: 'Movie'.
	person2 := CyNode name: 'person2' label: 'Person'.
	movie2 := CyNode name: 'movie2' label: 'Movie'.
	personToMovie := CyRelationship start: person end: movie name: 'r' type: 'RATED'.
	person2ToMovie := CyRelationship start: person2 end: movie2 name: 'r2' type: 'RATED'.
	
	averageRating := (CyFuncInvocation call: 'avg' expression: (CyIdentifier of: person2ToMovie prop: 'stars')) as: 'rating'.
	sameGenre := CyExpression eq: (CyIdentifier of: movie2 prop: 'genre') with: (CyIdentifier of: movie prop: 'genre').
	goodRating := CyExpression ge: 'rating' with: 3.
	
	return := CyReturn of:
		(CyIdentifier of: movie prop: 'title'),
		(CyIdentifier of: movie prop: 'genre'),
		(CyIdentifier of: movie2 prop: 'title'),
		(CyIdentifier of: movie2 prop: 'genre'),
		(CyLiteral value: 'rating').
	return orderBy: (CySortSpecifier of: 'rating') desc.
	
	query := CyQuery statements: {
		(CyMatch of: personToMovie).
		(CyMatch of: person2ToMovie).
		(CyWith of: (CyIdentifier of: person) , (CyIdentifier of: movie), (CyIdentifier of: movie2) , averageRating).
		(CyWhere of: (CyExpression and: sameGenre with: goodRating)).
		(return limit: 10)
	}.
			
	cypherString := query cypherString.
	
	^ self graphDb queryByCypher: cypherString