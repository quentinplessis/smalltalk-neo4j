actions-cypher
queryByCypher: cypherString
	self inspectQueries
		ifTrue: [ cypherString inspect ].
	^ self parseResponse: (super queryByCypher: cypherString)