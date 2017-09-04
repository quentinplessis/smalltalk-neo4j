actions-cypher
queryByCyphers: cypherString
	self inspectQueries
		ifTrue: [ cypherString inspect ].
	^ self parseMultiResponse: (super queryByCyphers: cypherString)