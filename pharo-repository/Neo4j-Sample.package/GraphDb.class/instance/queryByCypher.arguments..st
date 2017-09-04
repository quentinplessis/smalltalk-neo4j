actions-cypher
queryByCypher: cypherString arguments: arguments
	self inspectQueries
		ifTrue: [ {cypherString.
			arguments} inspect ].
	^ self parseResponse: (super queryByCypher: cypherString arguments: arguments)