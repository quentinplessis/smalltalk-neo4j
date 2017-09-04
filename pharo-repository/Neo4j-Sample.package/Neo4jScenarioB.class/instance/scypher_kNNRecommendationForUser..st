queries-scypher
scypher_kNNRecommendationForUser: arg1
	| person movie person2 query cypherString similarPersons personToMovie person2ToMovie with return |
	
	person := CyNode name: 'person' label: 'Person' props: {('name' -> arg1)}.
	movie := CyNode name: 'movie' label: 'Movie'.
	person2 := CyNode name: 'person2' label: 'Person'.
	similarPersons := (CyRelationship start: person end: person2 name: 's' type: 'SIMILARITY') beOut.
	
	person2ToMovie := (CyRelationship start: person2 end: movie name: 'r2' type: 'RATED') beOut.
	personToMovie := (CyRelationship start: person end: movie name: '' type: 'RATED') beOut.
	
	with := CyWith of: 
		(CyIdentifier of: movie),
		((CyIdentifier of: similarPersons prop: 'similarity') as: 'similarity'),
		((CyIdentifier of: person2ToMovie prop: 'stars') as: 'rating').
	with beDistinct.
	
	return := CyReturn of: (CyIdentifier of: movie prop: 'title'), (CyLiteral of: 'recommendation').
	return orderBy: (CySortSpecifier of: 'recommendation') desc.
	
	query := CyQuery statements: {
		(CyMatch of: (CyPatternElement withAll: {similarPersons. person2ToMovie})).
		(CyWhere of: (CyExpression not: personToMovie)).
		(with orderBy: (CySortSpecifier of: 'similarity') desc).
		(CyWith of: (CyIdentifier of: movie), ((CyRawExpression of: 'collect(rating)[0..3] as ratings') enclosed: false)) beDistinct.
		(CyUnwind of: 'ratings' as: 'rating').
		(CyWith of: (CyIdentifier of: movie), ((CyFuncInvocation call: 'avg' expression: 'rating')as: 'recommendation')) beDistinct.
		(return limit: 10)
	}.
			
	cypherString := query cypherString.
	
	^ self graphDb queryByCypher: cypherString