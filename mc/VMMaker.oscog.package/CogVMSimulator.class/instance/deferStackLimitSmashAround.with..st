multi-threading simulation switch
deferStackLimitSmashAround: functionSymbol with: arg
	"This method includes or excludes CoInterpreterMT methods as required.
	 Auto-generated by CogVMSimulator>>ensureMultiThreadingOverridesAreUpToDate"

	^self perform: #deferStackLimitSmashAround:with:
		withArguments: {functionSymbol. arg}
		inSuperclass: (cogThreadManager ifNil: [CoInterpreterPrimitives] ifNotNil: [CoInterpreterMT])