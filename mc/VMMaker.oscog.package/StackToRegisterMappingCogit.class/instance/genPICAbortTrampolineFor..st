initialization
genPICAbortTrampolineFor: numArgs
	"Generate the abort for a PIC.  This abort performs either a call of
	 ceInterpretMethodFromPIC:receiver: to handle invoking an uncogged
	 target or a call of ceMNUFromPICMNUMethod:receiver: to handle an
	 MNU dispatch in a closed PIC.  It distinguishes the two by testing
	 ClassReg.  If the register is zero then this is an MNU."
	opcodeIndex := 0. 
	backEnd genPushRegisterArgsForAbortMissNumArgs: numArgs.
	^self genInnerPICAbortTrampoline: (self trampolineName: 'cePICAbort' numArgs: (numArgs <= self numRegArgs ifTrue: [numArgs] ifFalse: [-1]))