queries-3-scypher
q35_moviesNamed: title
	| director movie directorToMovie query cypherString statements |
	
	director := CyNode name: 'director' label: 'Director'.
	movie := CyNode name: 'movie' label: 'Movie'.
	directorToMovie := CyRelationship start: director end: movie name: 'directed' type: 'DIRECTED'.
	
	statements := OrderedCollection new.
	statements add: (CyMatch of: directorToMovie).
	title ifNotNil: [
		statements add: (CyWhere of: (CyExpression eq: (CyIdentifier of: movie prop: 'title') with: title asCypherValue))
	].
	statements add: (CyReturn of: (CyIdentifier of: director prop: 'name'), (CyIdentifier of: movie prop: 'title')) beDistinct.
	query := CyQuery statements: statements.
	
	cypherString := query cypherString.
	
	^ self graphDb queryByCypher: cypherString