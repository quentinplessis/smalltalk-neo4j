private
parseMultiResponse: response
	self latency > 0
		ifTrue: [ (Delay forMilliseconds: self latency) wait ].
	response errors
		ifNotEmpty: [ Error signal: (response errors first at: 'message') ].
	^ response results
		collect: [ :each | each data collect: [ :data | data at: 'row' ] ]