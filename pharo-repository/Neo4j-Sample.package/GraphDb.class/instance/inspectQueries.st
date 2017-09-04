debug
inspectQueries
	| tmp2 |
	tmp2 := inspectQueries.
	^ tmp2 ifNil: [ inspectQueries := false ] ifNotNil: [ tmp2 ]