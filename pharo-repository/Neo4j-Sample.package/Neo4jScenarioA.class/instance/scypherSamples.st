queries-3-scypher
scypherSamples
	| person movie personToMovie match where return query cypherString |
	
	person := CyNode name: 'n' label: 'Person' props: {('name' -> 'James Cameron')}.
	movie := CyNode name: 'm' label: 'Movie'.
	personToMovie := (CyRelationship start: person end: movie name: 'r' type: 'DIRECTED') beOut.
	
	CyMatch of: person.
	CyMatch of: person , movie.
	
	match := CyMatch of: personToMovie.
	
	CyIdentifier of: movie prop: 'title'.
	
	CyExpression eq: 'name' with: 2.
	
	CyWhere of: (CyExpression eq: 'name' with: 2).
	
	where := CyWhere of: (CyExpression eq: (CyIdentifier of: movie prop: 'title') with: 'Avatar' asCypherValue).
	return := CyReturn of: (CyIdentifier of: movie).
	
	query := CyQuery statements: {match. where. return}.
	
	cypherString := query cypherString.
	
	^ self graphDb queryByCypher: cypherString