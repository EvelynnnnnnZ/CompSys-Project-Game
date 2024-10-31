		.DATA
timer 		.FILL #150
;;;;;;;;;;;;;;;;;;;;;;;;;;;;printnum;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
printnum
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L2_snake
	LEA R7, L4_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L1_snake
L2_snake
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L6_snake
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-13
	JMP L7_snake
L6_snake
	LDR R7, R5, #3
	STR R7, R5, #-13
L7_snake
	LDR R7, R5, #-13
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L8_snake
	LEA R7, L10_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L1_snake
L8_snake
	ADD R7, R5, #-12
	ADD R7, R7, #10
	STR R7, R5, #-2
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
	JMP L12_snake
L11_snake
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	LDR R3, R5, #-1
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #-1
L12_snake
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L11_snake
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L14_snake
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #45
	STR R3, R7, #0
L14_snake
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L1_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endl;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endl
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, L17_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L16_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rand16;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rand16
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #127
	AND R7, R7, R3
L18_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
zero 		.FILL #255
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #255
		.DATA
one 		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.DATA
two 		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.FILL #224
		.FILL #255
		.FILL #255
		.DATA
three 		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.DATA
four 		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #255
		.FILL #3
		.FILL #3
		.FILL #3
		.FILL #3
		.DATA
five 		.FILL #255
		.FILL #255
		.FILL #224
		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.DATA
six 		.FILL #255
		.FILL #255
		.FILL #224
		.FILL #255
		.FILL #255
		.FILL #195
		.FILL #255
		.FILL #255
		.DATA
seven 		.FILL #255
		.FILL #255
		.FILL #3
		.FILL #3
		.FILL #3
		.FILL #3
		.FILL #3
		.FILL #3
		.DATA
eight 		.FILL #255
		.FILL #195
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #195
		.FILL #195
		.FILL #255
		.DATA
nine 		.FILL #255
		.FILL #255
		.FILL #195
		.FILL #255
		.FILL #255
		.FILL #3
		.FILL #3
		.FILL #255
		.DATA
none 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;init_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
init_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, snake_length
	CONST R3, #1
	STR R3, R7, #0
	LEA R7, snake_direction
	CONST R3, #3
	STR R3, R7, #0
	LEA R7, snake
	CONST R3, #10
	STR R3, R7, #0
	STR R3, R7, #1
L19_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset_bombs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset_bombs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	LEA R3, bombs_count
	STR R7, R3, #0
	STR R7, R5, #-1
L21_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	CONST R3, #-1
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	CONST R3, #-1
	STR R3, R7, #1
L22_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #5
	CMP R7, R3
	BRn L21_snake
L20_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;turn_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
turn_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L26_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRz L26_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
	JMP L27_snake
L26_snake
	LDR R7, R5, #3
	CONST R3, #1
	CMP R7, R3
	BRnp L28_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L28_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
	JMP L29_snake
L28_snake
	LDR R7, R5, #3
	CONST R3, #2
	CMP R7, R3
	BRnp L30_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #3
	CMP R7, R3
	BRz L30_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
	JMP L31_snake
L30_snake
	LDR R7, R5, #3
	CONST R3, #3
	CMP R7, R3
	BRnp L32_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #2
	CMP R7, R3
	BRz L32_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
L32_snake
L31_snake
L29_snake
L27_snake
L25_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;grow_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
grow_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, snake_length
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L34_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;move_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
move_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	LEA R7, snake
	LDR R7, R7, #0
	STR R7, R5, #-2
	LEA R7, snake
	LDR R7, R7, #1
	STR R7, R5, #-3
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L36_snake
	LEA R7, snake
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LEA R7, snake
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRzp L37_snake
	CONST R7, #0
	JMP L35_snake
L36_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L40_snake
	LEA R7, snake
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LEA R7, snake
	LDR R7, R7, #1
	CONST R3, #15
	CMP R7, R3
	BRnz L41_snake
	CONST R7, #0
	JMP L35_snake
L40_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #2
	CMP R7, R3
	BRnp L44_snake
	LEA R7, snake
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRzp L45_snake
	CONST R7, #0
	JMP L35_snake
L44_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #3
	CMP R7, R3
	BRnp L48_snake
	LEA R7, snake
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LDR R7, R7, #0
	CONST R3, #16
	CMP R7, R3
	BRnz L50_snake
	CONST R7, #0
	JMP L35_snake
L50_snake
L48_snake
L45_snake
L41_snake
L37_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRn L52_snake
	CONST R7, #1
	STR R7, R5, #-1
	JMP L57_snake
L54_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R5, #-4
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R7, R7, #1
	STR R7, R5, #-5
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R3, R5, #-2
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R3, R5, #-3
	STR R3, R7, #1
	LDR R7, R5, #-4
	STR R7, R5, #-2
	LDR R7, R5, #-5
	STR R7, R5, #-3
L55_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L57_snake
	LDR R7, R5, #-1
	LEA R3, snake_length
	LDR R3, R3, #0
	CMP R7, R3
	BRn L54_snake
L52_snake
	CONST R7, #1
L35_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;spawn_fruit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
spawn_fruit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, fruit
	CONST R2, #16
	MOD R7, R7, R2
	STR R7, R3, #0
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, fruit
	CONST R2, #15
	MOD R7, R7, R2
	STR R7, R3, #1
	CONST R7, #0
	STR R7, R5, #-1
	JMP L62_snake
L63_snake
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, fruit
	CONST R2, #16
	MOD R7, R7, R2
	STR R7, R3, #0
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, fruit
	CONST R2, #15
	MOD R7, R7, R2
	STR R7, R3, #1
L64_snake
	LEA R7, fruit
	STR R7, R5, #-2
	LDR R3, R5, #-1
	SLL R3, R3, #1
	LEA R2, bomb
	ADD R3, R3, R2
	LDR R2, R7, #0
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L66_snake
	LDR R7, R5, #-2
	LDR R7, R7, #1
	LDR R3, R3, #1
	CMP R7, R3
	BRz L63_snake
L66_snake
L60_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L62_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMP R7, R3
	BRn L64_snake
L58_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;spawn_bomb;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
spawn_bomb
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	LEA R7, bombs_count
	LDR R7, R7, #0
	STR R7, R5, #-2
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LDR R3, R5, #-2
	SLL R3, R3, #1
	LEA R2, bomb
	ADD R3, R3, R2
	CONST R2, #16
	MOD R7, R7, R2
	STR R7, R3, #0
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LDR R3, R5, #-2
	SLL R3, R3, #1
	LEA R2, bomb
	ADD R3, R3, R2
	CONST R2, #15
	MOD R7, R7, R2
	STR R7, R3, #1
	LEA R7, bombs_count
	LDR R7, R7, #0
	CONST R3, #5
	CMP R7, R3
	BRn L68_snake
	JMP L67_snake
L68_snake
	CONST R7, #0
	STR R7, R5, #-1
	JMP L73_snake
L70_snake
	LEA R7, bomb
	LDR R3, R5, #-1
	SLL R3, R3, #1
	ADD R3, R3, R7
	LDR R2, R5, #-2
	SLL R2, R2, #1
	ADD R7, R2, R7
	STR R7, R5, #-3
	LDR R2, R3, #0
	LDR R1, R7, #0
	CMP R2, R1
	BRnp L74_snake
	LDR R7, R3, #1
	LDR R3, R5, #-3
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L74_snake
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LDR R3, R5, #-2
	SLL R3, R3, #1
	LEA R2, bomb
	ADD R3, R3, R2
	CONST R2, #16
	MOD R7, R7, R2
	STR R7, R3, #0
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LDR R3, R5, #-2
	SLL R3, R3, #1
	LEA R2, bomb
	ADD R3, R3, R2
	CONST R2, #15
	MOD R7, R7, R2
	STR R7, R3, #1
L74_snake
L71_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L73_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMP R7, R3
	BRnz L70_snake
L67_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_bomb_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_bomb_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L80_snake
L77_snake
	LEA R7, snake
	STR R7, R5, #-2
	LDR R3, R5, #-1
	SLL R3, R3, #1
	LEA R2, bomb
	ADD R3, R3, R2
	LDR R2, R7, #1
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L81_snake
	LDR R7, R5, #-2
	LDR R7, R7, #0
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L81_snake
	CONST R7, #2
	JMP L76_snake
L81_snake
L78_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L80_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMP R7, R3
	BRn L77_snake
	CONST R7, #0
L76_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_fruit_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_fruit_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, snake
	STR R7, R5, #-1
	LEA R3, fruit
	LDR R2, R7, #1
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L84_snake
	LDR R7, R5, #-1
	LDR R7, R7, #0
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L84_snake
	CONST R7, #3
	JMP L83_snake
L84_snake
	CONST R7, #0
L83_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_self_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_self_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-1
	JMP L90_snake
L87_snake
	LEA R7, snake
	STR R7, R5, #-2
	LDR R3, R5, #-1
	SLL R3, R3, #1
	ADD R3, R3, R7
	LDR R2, R7, #0
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L91_snake
	LDR R7, R5, #-2
	LDR R7, R7, #1
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L91_snake
	CONST R7, #4
	JMP L86_snake
L91_snake
L88_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L90_snake
	LDR R7, R5, #-1
	LEA R3, snake_length
	LDR R3, R3, #0
	CMP R7, R3
	BRn L87_snake
	CONST R7, #0
L86_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;handle_collisions;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
handle_collisions
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR check_bomb_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #2
	CMP R7, R3
	BRnp L94_snake
	CONST R7, #2
	JMP L93_snake
L94_snake
	JSR check_fruit_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRnp L96_snake
	CONST R7, #3
	JMP L93_snake
L96_snake
	JSR check_self_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #4
	CMP R7, R3
	BRnp L98_snake
	CONST R7, #4
	JMP L93_snake
L98_snake
	CONST R7, #0
L93_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_game_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_game_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, bombs_count
	LDR R7, R7, #0
	STR R7, R5, #-1
	JSR move_snake
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRnp L101_snake
	CONST R7, #2
	JMP L100_snake
L101_snake
	JSR handle_collisions
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #2
	CMP R7, R3
	BRz L105_snake
	JSR handle_collisions
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #4
	CMP R7, R3
	BRnp L103_snake
L105_snake
	CONST R7, #2
	JMP L100_snake
L103_snake
	JSR handle_collisions
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRnp L106_snake
	JSR grow_snake
	ADD R6, R6, #0	;; free space for arguments
	JSR spawn_fruit
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #5
	MOD R7, R7, R3
	CONST R3, #0
	CMP R7, R3
	BRnp L107_snake
	JSR spawn_bomb
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, bombs_count
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LEA R7, timer
	LDR R7, R7, #0
	CONST R3, #35
	CMP R7, R3
	BRnz L107_snake
	LEA R7, timer
	LDR R3, R7, #0
	CONST R2, #30
	SUB R3, R3, R2
	STR R3, R7, #0
	JMP L107_snake
L106_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #25
	CMP R7, R3
	BRnp L112_snake
	CONST R7, #1
	JMP L100_snake
L112_snake
L107_snake
	CONST R7, #0
L100_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;index_to_pixel;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
index_to_pixel
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	SLL R7, R7, #3
L114_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_pixel;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_pixel
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #4
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR index_to_pixel
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR index_to_pixel
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-2
	LDR R7, R5, #5
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
L115_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L120_snake
L117_snake
	CONST R7, #0
	HICONST R7, #51
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L118_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L120_snake
	LDR R7, R5, #-1
	LEA R3, snake_length
	LDR R3, R3, #0
	CMP R7, R3
	BRn L117_snake
L116_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_bombs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_bombs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L125_snake
L122_snake
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L123_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L125_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMP R7, R3
	BRn L122_snake
L121_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_fruit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_fruit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, fruit
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L126_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;display_score;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
display_score
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #10
	LEA R3, snake_length
	LDR R3, R3, #0
	DIV R3, R3, R7
	MOD R7, R3, R7
	STR R7, R5, #-1
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR printnum
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-1
	LEA R3, snake_length
	LDR R3, R3, #0
	CONST R2, #10
	MUL R2, R2, R7
	SUB R3, R3, R2
	STR R3, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRnp L128_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, zero
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L129_snake
L128_snake
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRnp L130_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L131_snake
L130_snake
	LDR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRnp L132_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L132_snake
L131_snake
L129_snake
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRnp L134_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, zero
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L134_snake
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRnp L136_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, one
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L136_snake
	LDR R7, R5, #-2
	CONST R3, #2
	CMP R7, R3
	BRnp L138_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, two
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L138_snake
	LDR R7, R5, #-2
	CONST R3, #3
	CMP R7, R3
	BRnp L140_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, three
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L140_snake
	LDR R7, R5, #-2
	CONST R3, #4
	CMP R7, R3
	BRnp L142_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, four
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L142_snake
	LDR R7, R5, #-2
	CONST R3, #5
	CMP R7, R3
	BRnp L144_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, five
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L144_snake
	LDR R7, R5, #-2
	CONST R3, #6
	CMP R7, R3
	BRnp L146_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, six
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L146_snake
	LDR R7, R5, #-2
	CONST R3, #7
	CMP R7, R3
	BRnp L148_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, seven
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L148_snake
	LDR R7, R5, #-2
	CONST R3, #8
	CMP R7, R3
	BRnp L150_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, eight
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L127_snake
L150_snake
	LDR R7, R5, #-2
	CONST R3, #9
	CMP R7, R3
	BRnp L127_snake
	LEA R7, none
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, nine
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #13
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L127_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;redraw;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
redraw
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_snake
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_bombs
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_fruit
	ADD R6, R6, #0	;; free space for arguments
	JSR display_score
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L154_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;play_game;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
play_game
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
	LEA R7, bombs_count
	LDR R7, R7, #0
	STR R7, R5, #-3
	LEA R7, timer
	CONST R3, #150
	STR R3, R7, #0
	JSR init_snake
	ADD R6, R6, #0	;; free space for arguments
	JSR reset_bombs
	ADD R6, R6, #0	;; free space for arguments
	JSR spawn_fruit
	ADD R6, R6, #0	;; free space for arguments
	JSR redraw
	ADD R6, R6, #0	;; free space for arguments
	JSR display_score
	ADD R6, R6, #0	;; free space for arguments
	JMP L157_snake
L156_snake
	LEA R7, timer
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #105
	CMP R7, R3
	BRnp L159_snake
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L161_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L159_snake
	LDR R7, R5, #-1
	CONST R3, #106
	CMP R7, R3
	BRnp L162_snake
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L164_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L162_snake
	LDR R7, R5, #-1
	CONST R3, #107
	CMP R7, R3
	BRnp L165_snake
	CONST R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L167_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L165_snake
	LDR R7, R5, #-1
	CONST R3, #108
	CMP R7, R3
	BRnp L168_snake
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L170_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L168_snake
	LDR R7, R5, #-1
	CONST R3, #113
	CMP R7, R3
	BRnp L171_snake
	JMP L155_snake
L171_snake
	JSR update_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-2
	JSR redraw
	ADD R6, R6, #0	;; free space for arguments
	LDR R7, R5, #-2
	CONST R3, #2
	CMP R7, R3
	BRnp L173_snake
	LEA R7, L175_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L155_snake
L173_snake
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRnp L176_snake
	LEA R7, L178_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L155_snake
L176_snake
L157_snake
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRz L156_snake
L155_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	LEA R7, L180_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L181_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L183_snake
L182_snake
	CONST R7, #100
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #113
	CMP R7, R3
	BRnp L185_snake
	JMP L184_snake
L185_snake
	LDR R7, R5, #-1
	CONST R3, #114
	CMP R7, R3
	BRnp L187_snake
	LEA R7, L189_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L190_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L191_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR play_game
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, L192_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L187_snake
L183_snake
	JMP L182_snake
L184_snake
	CONST R7, #0
L179_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
score 		.BLKW 1
		.DATA
bombs_count 		.BLKW 1
		.DATA
fruit 		.BLKW 2
		.DATA
bomb 		.BLKW 10
		.DATA
snake_direction 		.BLKW 1
		.DATA
snake_length 		.BLKW 1
		.DATA
snake 		.BLKW 50
		.DATA
L192_snake 		.STRINGZ "Press 'r' to play again, or 'q' to quit...\n"
		.DATA
L191_snake 		.STRINGZ "Eat food (red) to grow, and avoid bombs (white)\n"
		.DATA
L190_snake 		.STRINGZ "Use i, j, k, l to move\n"
		.DATA
L189_snake 		.STRINGZ "\nNew game!\n"
		.DATA
L181_snake 		.STRINGZ "Press 'r' to start\n"
		.DATA
L180_snake 		.STRINGZ "Welcome to Snake!\n"
		.DATA
L178_snake 		.STRINGZ "You WIN!"
		.DATA
L175_snake 		.STRINGZ "You LOSE!"
		.DATA
L170_snake 		.STRINGZ "\nyeah you pressed l\n"
		.DATA
L167_snake 		.STRINGZ "\nyeah you pressed k\n"
		.DATA
L164_snake 		.STRINGZ "\nyeah you pressed j\n"
		.DATA
L161_snake 		.STRINGZ "\nyeah you pressed i\n"
		.DATA
L17_snake 		.STRINGZ "\n"
		.DATA
L10_snake 		.STRINGZ "-32768"
		.DATA
L4_snake 		.STRINGZ "0"
