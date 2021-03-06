tests
testRetN
	"self new testRetN"
	
	#(0) do:
		[:n| | inst len |
		inst := self gen: RetN operand: n.
		len := inst concretizeAt: 0.
		self processor
			disassembleInstructionAt: 0
			In: inst machineCode object
			into: [:str :sz| | plainJane herIntended |
				"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
				plainJane := self strip: str.
				self assert: (plainJane match: 'pop	{pc}') | (plainJane match: 'ldmfd	sp!, {pc}').
				self assert: len = sz]].
	
	#(1 2 4 8 16 31) do:
		[:n| | inst len |
		inst := self gen: RetN operand: n.
		len := inst concretizeAt: 0.
		self processor
			disassembleInstructionAt: 0
			In: inst machineCode object
			into: [:str :sz| | plainJane herIntended |
				"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
				plainJane := self strip: str.
				herIntended := 'add	sp, sp, #', n asString,', 30'.
				self assert: (plainJane match: herIntended).
				self assert: len = 8]]