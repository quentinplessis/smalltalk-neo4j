queries-3-scypher
q32_moviesWhere: movieProperties
	| director movie directorToMovie query cypherString |
	
	director := CyNode name: 'director' label: 'Director'.
	movie := CyNode name: 'movie' label: 'Movie' props: movieProperties.
	directorToMovie := CyRelationship start: director end: movie name: 'directed' type: 'DIRECTED'.
		
	query := CyQuery statements: {
		(CyMatch of: directorToMovie).
		(CyReturn of: (CyIdentifier of: director prop: 'name'), (CyIdentifier of: movie prop: 'title')) beDistinct
	}.
	
	cypherString := query cypherString.
	
	^ self graphDb queryByCypher: cypherString