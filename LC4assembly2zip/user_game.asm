;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : user_echo.asm                            ;
;  author      : Yuqi Zhang
;  description : Game-like assembly, creating a "syper" trap tester ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
.DATA
.ADDR x4000

	;LC R0, OS_KBSR_ADDR
	
global_array
	.FILL x0041				; A
	.FILL x004C				; L
	.FILL x004C				; L
	.FILL x0020				; space
	.FILL x0044				; D 
	.FILL x004F				; O 
	.FILL x0057				; W 
	.FILL x004E				; N 
	.FILL x0000				; NULL


X_array
	.FILL x0000				; NULL
	.FILL x0042				; B
	.FILL x0024				; $ 
	.FILL x0018				; can 
	.FILL x0018				; can 
	.FILL x0024				; $ 
	.FILL x0042				; B 
	.FILL x0000				; NULL 
	.FILL x0000				; NULL

SPRITE_X .FILL 0x0020
SPRITE_Y .FILL 0x0021
SPRITE_COLOR .FILL 0x0022
SPRITE_ADDRESS .FILL 0x0023
TIMER_SAVE .FILL 0x0024

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The following CODE will go into USER's Program Memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x0000




	CONST R0, #60					; draw a green X in the center of the screen
	CONST R1, #57
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, X_array	; pupolate R0
	LEA R4, SPRITE_X
	STR R0, R4, #0
	LEA R4, SPRITE_Y
	STR R1, R4, #0
	LEA R4, SPRITE_COLOR
	STR R2, R4, #0
	LEA R4, SPRITE_ADDRESS
	STR R3, R4, #0

	LEA R4, SPRITE_X
	LDR R0, R4, #0
	LEA R4, SPRITE_Y
	LDR R1, R4, #0
	LEA R4, SPRITE_COLOR
	LDR R2, R4, #0
	LEA R4, SPRITE_ADDRESS
	LDR R3, R4, #0
	TRAP x0A						; TRAP_DRAW_SPRITE, draw the X

	CONST R0, #0
	CONST R1, #0
	CONST R2, #5
	CONST R3, #10
	CONST R4, x00
	HICONST R4, x7C
	TRAP x09						; TRAP_DRAW_RECT, red rectangle at upper left corner

	CONST R0, #115
	CONST R1, #105
	CONST R2, #15
	CONST R3, #20
	CONST R4, xE0
	HICONST R4, x03
	TRAP x09						; TRAP_DRAW_RECT, green rectangle at bottom right corner

	CONST R0, #0
	CONST R1, #105
	CONST R2, #10
	CONST R3, #20
	CONST R4, xFF
	HICONST R4, x00 ;
	TRAP x09						; TRAP_DRAW_RECT, blue rectangle at the bottom left

	CONST R0, #119
	CONST R1, #0
	CONST R2, #10
	CONST R3, #10
	CONST R4, x00
	HICONST R4, xFF
	TRAP x09							; TRAP_DRAW_RECT, yellow rectangle at the upper right



LOOP_GAME
	CONST R0, xA0						; timeout of 1s in R0
	HICONST R0 x0F
	TRAP x05							; call TRAP_GETC_TIMER
	LEA R4, TIMER_SAVE
	STR R0, R4, #0


    TRAP x00               			; read character from keyboard 
    TRAP x01               			; write character from R0 to ASCII display
	CMPI R0, x0A        			; "enter"'s ASCII is 13, test if R0 is enter
    BRz READY_END            		; if R0==enter, end loop
	CONST R1, x69
	HICONST R1, x00
	CMP R0, R1						; i=69, k=6B, j=6A, l=6D
	BRz READY_NORTH
	CONST R1, x68
	HICONST R1, x00
	CMP R0, R1
	BRz READY_SOUTH
	CONST R1, x6A
	HICONST R1, x00
	CMP R0, R1
	BRz READY_WEST
	CONST R1, x6D
	HICONST R1, x00
	CMP R0, R1
	BRz READY_EAST

	READY_NORTH
		LEA R4, SPRITE_Y
		LDR R1, R4, #0
		ADD R1, R1, #5
		LEA R4, SPRITE_Y			; move the sprite north
		STR R1, R4, #0



	READY_SOUTH
		LEA R4, SPRITE_Y
		LDR R1, R4, #0
		ADD R1, R1, #-5
		LEA R4, SPRITE_Y			; move the sprite south
		STR R1, R4, #0

	READY_EAST
		LEA R4, SPRITE_X
		LDR R0, R4, #0				; move the sprite east
		ADD R0, R0, #5
		LEA R4, SPRITE_X
		STR R0, R4, #0

	READY_WEST
		LEA R4, SPRITE_X
		LDR R0, R4, #0				; move the sprite west
		ADD R0, R0, #-5
		LEA R4, SPRITE_X
		STR R0, R4, #0
	
	READY_END
			LEA R0, global_array	; pupolate R0
			TRAP x03				; call TRAP_PUTS
			JMP LOOP_GAME_END		; end the game

	LEA R4, TIMER_SAVE
	LDR R0, R4, #0
	CMPI R0, #0
	BRp READY_LFSR
	READY_LFSR
		CONST R0, x50
		HICONST R0, xA9
		TRAP x0B
		TRAP x0C
		LEA R4, SPRITE_COLOR		; change the color for the sprite
		STR R0, R4, #0
		JMP LOOP_GAME_END			
	JMP LOOP_GAME
LOOP_GAME_END

END


