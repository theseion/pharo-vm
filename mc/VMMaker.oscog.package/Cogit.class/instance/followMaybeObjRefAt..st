garbage collection
followMaybeObjRefAt: mcpc
	"Follow a potential object reference from a closed PIC.
	 This may be a method reference or null.
	 Answer if the followed literal is young."
	| object subject |
	object := backEnd literalBeforeFollowingAddress: mcpc.
	(objectRepresentation couldBeObject: object) ifFalse:
		[^false].
	(objectMemory isForwarded: object) ifFalse:
		[^objectMemory isYoungObject: object].
	subject := objectMemory followForwarded: object.
	backEnd storeLiteral: subject beforeFollowingAddress: mcpc.
	codeModified := true.
	^objectMemory isYoungObject: subject