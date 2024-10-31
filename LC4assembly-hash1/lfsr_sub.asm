;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : lfsr_sub.asm                           ;
;  author      : Yuqi Zhang
;  description : LC4 Assembly program for LFSR (a 16-bit;
;                “shift” register where the 15th, 13th, ;
;                12th and 10th bits and XOR’ed together ;
;                and the result serves as input into the;
;                shift register. )                      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Below is my answer for Question 5

CONST R0, x00
HICONST r0, x20
STR R1, R0, #0         ; set R1 = seed and store R0 in it 
CONST R7, xFF          ; counter set to be R7=65535
HICONST R7, xFF
LOOP
  JSR LFSR_SUB         ; CALL TO SUBROUTINE
  ADD R7, R7, #-1      ; counter = counter-1
  BRnz END             ; end when counter is negative or zero
JMP END                ; jumps over subrourtine
.FALIGN
LFSR_SUB
  AND R2, R0, R2       ; R2 = 15th bit SRL R2, R2, #15 CONSTR R2 48 HiCONST R2 20
  SRL R2, R2, #15      ; shift what we just saved to the right end
  AND R3, R0, R3       ; R3 = 13th bit 
  SRL R3, R3, #13      ; shift what we just saved to the right end
  AND R4, R0, R4       ; R4 = 12th bit
  SRL R4, R4, #12      ; shift what we just saved to the right end
  AND R5, R0, R5       ; R5 = 10th bit
  SRL R5, R5, #10      ; shift what we just saved to the right end
  XOR R6, R2, R3       ; xor for 15th and 13th
  XOR R6, R6, R4       ; xor previous with 12th
  XOR R6, R6, R5       ; xor previous with 10th
  SLL R0, R0, #1       ; shifting R0 leftward
  ADD R0, R0, R6       ; save result of the xors to R0
  STR R0, R0, #0       ; update the value in x2000
  RET                  ; end subroutine
END                    ; end program