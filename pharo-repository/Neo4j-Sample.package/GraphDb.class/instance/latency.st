debug
latency
	| tmp2 |
	tmp2 := latency.
	^ tmp2 ifNil: [ latency := 0 ] ifNotNil: [ tmp2 ]