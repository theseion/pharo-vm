generate machine code - concretize
concretizeArithmeticShiftRightCqR
	"Will get inlined into concretizeAt: switch."
	"this is an unfortunate waste of an instruction in most cases since the shift can usually be done in a subsequent arithmetic instruction. 
	Handle for now with a MOV reg, reg, ASR #distance"
	<inline: true>
	| distance reg |
	distance := (operands at: 0) min: 31.
	reg := self concreteRegister: (operands at: 1).
	"cond 000 1101 0 0000 dest dist -100 srcR"
	self machineCodeAt: 0 put: (self type: 0 op: 16rD set: 0 rn: 0 rd: reg 
									shifterOperand: (distance << 7 bitOr: (64 "flag for arithmetic" bitOr: reg))).
	^machineCodeSize := 4