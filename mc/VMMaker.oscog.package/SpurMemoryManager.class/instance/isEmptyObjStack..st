obj stacks
isEmptyObjStack: objStack
	objStack = nilObj ifTrue:
		[^true].
	self assert: (self isValidObjStack: objStack).
	^0 = (self fetchPointer: ObjStackTopx ofObject: objStack)
	  and: [0 = (self fetchPointer: ObjStackNextx ofObject: objStack)]