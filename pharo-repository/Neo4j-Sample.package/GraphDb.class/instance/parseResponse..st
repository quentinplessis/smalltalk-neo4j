private
parseResponse: response
	self latency > 0
		ifTrue: [ (Delay forMilliseconds: self latency) wait ].
	response errors
		ifNotEmpty: [ Error signal: (response errors first at: 'message') ].
	^ response result data collect: [ :each | each at: 'row' ]