;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : user_draw.asm                            ;
;  author      : Yuqi Zhang
;  description : draw a rectangle on the screen       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The following CODE will go into USER's Program Memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x0000
	CONST R0, #50
	CONST R1, #5
	CONST R2, #10
	CONST R3, #5
	CONST R4, x00
	HICONST R4, x7C
	TRAP x09		; TRAP_DRAW_RECT

	CONST R0, #120
	CONST R1, #100
	CONST R2, #27
	CONST R3, #10
	CONST R4, x00
	HICONST R4, xFF ; yellow
	TRAP x09		; TRAP_DRAW_RECT



	CONST R0, #10
	CONST R1, #10
	CONST R2, #50
	CONST R3, #40
	CONST R4, xE0
	HICONST R4, x03
	TRAP x09		; TRAP_DRAW_RECT



END


