actions-cypher
queryByCyphersWithArguments: arguments
	^ self parseMultiResponse: (super queryByCyphersWithArguments: arguments)