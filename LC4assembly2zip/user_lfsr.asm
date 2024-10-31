;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : user_lfsr.asm                            ;
;  author      : Yuqi Zhang
;  description : LFSR, generating a pseudo-random number ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The following CODE will go into USER's Program Memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x0000

CONST R0, x50
HICONST R0, xA9
TRAP x0B                    ; call TRAP_LFSR_SET_SEED
CONST R4, x00
HICONST R4, x40
STR R0, R4, #0              ; save original R0
CONST R1, #0                ; R1 works as counter for the loop
LOOP_FOR_TRAP
    TRAP x0C                ; call TRAP_LFSR
    ADD R1, R1, #1          ; count the loop
    CONST R4, x00
    HICONST R4, x40
    LDR R3, R4, #0
    CMP R0, R3              ; compare R0 andd R3 (cuurent R0 with original R0), if the same, stop
    BRz LOOP_FOR_TRAP_END
    JMP LOOP_FOR_TRAP
LOOP_FOR_TRAP_END

END

