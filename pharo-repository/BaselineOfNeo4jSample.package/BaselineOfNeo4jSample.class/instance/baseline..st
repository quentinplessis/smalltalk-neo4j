baseline
baseline: spec 
	 <baseline>
	
	spec for: #common do: [
		
		spec project: 'Neo4reSt' with: [
			spec
				className: 'ConfigurationOfNeo4reSt';
				file: 'ConfigurationOfNeo4reSt';
				repository: 'http://smalltalkhub.com/mc/MasashiUmezawa/Neo4reSt/main'. ].
		
		spec project: 'SCypher' with: [
			spec
				className: 'ConfigurationOfSCypher';
				file: 'ConfigurationOfSCypher';
				repository: 'http://smalltalkhub.com/mc/MasashiUmezawa/SCypher/main'. ].
			
		spec 
			package: 'Neo4j-Sample'.
	].