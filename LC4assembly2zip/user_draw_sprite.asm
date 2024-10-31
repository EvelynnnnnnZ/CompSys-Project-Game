;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : user_echo.asm                            ;
;  author      : 
;  description : read characters from the keyboard,       ;
;	             then echo them back to the ASCII display ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The following CODE will go into USER's Program Memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.DATA
.ADDR x4000


traingle_array
	.FILL x000C				; ff (the word is unclear on my book)
	.FILL x0014				; dc4
	.FILL x0024				; $ 
	.FILL x0044				; D 
	.FILL x0024				; $ 
	.FILL x0014				; so 
	.FILL x000C				; ff 
	.FILL x0004				; eot 
	.FILL x0000				; NULL



.CODE
.ADDR x0000

	CONST R0, #30
	CONST R1, #30
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE

	CONST R0, #30
	CONST R1, #35
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE

	CONST R0, #30
	CONST R1, #40
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE

	CONST R0, #60
	CONST R1, #30
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE

	CONST R0, #60
	CONST R1, #35
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE

	CONST R0, #60
	CONST R1, #40
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE


	CONST R0, #38
	CONST R1, #60
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE

	CONST R0, #46
	CONST R1, #60
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE

	CONST R0, #54
	CONST R1, #60
	CONST R2, xE0
	HICONST R2, x03	
	LEA R3, traingle_array			; pupolate R0
	TRAP x0A				; TRAP_DRAW_SPRITE

END


