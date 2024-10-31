;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : user_string.asm                            ;
;  author      : Yuqi Zhang
;  description : to output a NULL terminated string        ;
;	             to the ASCII display						 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The following CODE will go into USER's Program Memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.DATA
.ADDR x4000

	
global_array
	.FILL x0049				; I
	.FILL x0020				; space
	.FILL x006C				; l
	.FILL x006F				; o 
	.FILL x0076				; v 
	.FILL x0065				; e 
	.FILL x0020				; space
	.FILL x0043				; C 
	.FILL x0049				; I 
	.FILL x0053				; S 
	.FILL x0000				; NULL

.CODE
.ADDR x0000

	LEA R0, global_array	; pupolate R0
	TRAP x03				; call TRAP_PUTS

END


