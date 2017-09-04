accessing
graphDb
	| tmp2 |
	tmp2 := graphDb.
	^ tmp2 ifNil: [ graphDb := GraphDb new ] ifNotNil: [ tmp2 ]