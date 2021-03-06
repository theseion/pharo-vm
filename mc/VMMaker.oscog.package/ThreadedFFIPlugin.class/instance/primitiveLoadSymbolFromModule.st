primitives
primitiveLoadSymbolFromModule
	"Attempt to find the address of a symbol in a loaded library.
	loadSymbol: aSymbol fromModule: moduleName
		<primitive: 'primitiveLoadSymbolFromModule' error: errorCode module: 'SqueakFFIPrims'>
	"
	<export: true>

	| symbol module moduleHandle address oop ptr |

	<var: #address type: #'void *'>
	<var: #ptr type:'unsigned int *'>
	
	interpreterProxy methodArgumentCount = 2 ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].	

	module := interpreterProxy stackValue: 0.
	symbol := interpreterProxy stackValue: 1.

	moduleHandle := self ffiLoadCalloutModule: module.
	address := interpreterProxy
		ioLoadSymbol: (self cCoerce: (interpreterProxy firstIndexableField: symbol) to: #sqInt)
		OfLength: (interpreterProxy byteSizeOf: symbol)
		FromModule: moduleHandle.
	(interpreterProxy failed
	 or: [address = 0]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNotFound].
	
	oop := interpreterProxy 
		instantiateClass: interpreterProxy classExternalAddress 
		indexableSize: 4.
	ptr := interpreterProxy firstIndexableField: oop.
	ptr at: 0 put: address.
	
	interpreterProxy methodReturnValue: oop