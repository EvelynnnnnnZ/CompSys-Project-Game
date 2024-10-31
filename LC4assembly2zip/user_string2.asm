;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : user_string2.asm                            ;
;  author      : Yuqi Zhang
;  description : read characters from the keyboard until    ;
;	             enter key is pressed, store them in user 	;
;				 data memory as a string in a location 		;
;				 requested by the caller, then return 		;
;				 the length of the string to the caller.   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;

.DATA
.ADDR x2020
	
global_array
	.FILL x004C				; L
	.FILL x0065				; e
	.FILL x006E				; n 
	.FILL x0067				; g  
	.FILL x0074				; t  
	.FILL x0068				; h  
	.FILL x003D				; =
	.FILL x0000				; NULL

.CODE
.ADDR x0000

	CONST R0 x20
	HICONST R0 X20
	TRAP x02				; call TRAP_GETS
	ADD R6, R1, #0			; let R6 store R1

	LEA R0, global_array	; pupolate R0
	TRAP x03				; call TRAP_PUTS
	CONST R4, #30
	ADD R0, R6, R4			; R0 = R6 + R4
	TRAP x01				; call TRAP_PUTC

	CONST R0 x20
	HICONST R0 X20
	TRAP x03				; call TRAP_PUTS with address x2020 in R0
	
END


