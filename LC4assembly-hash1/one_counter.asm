;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : one_counter.asm                          ;
;  author      : Yuqi Zhang
;  description : LC4 Assembly program to count the ones   ;
;                in R0                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
; CONST R0 x70                      ; hex, 1370
; HICONST R0 x13                    ; I used this two lines to text CONST R0

; Below is my answer for Question 4

 CONST R1, #0                       ; set R1=0
 CONST R2, #16	                    ; R2 is our loop counter init to 16

LOOP
 CMPI R0 #0                         ; check NZP
 BRz END                            ; if R0 is zero, end
 AND R3, R0, #1                     ; check if R0 = 1 
 ADD R1, R1, R3                     ; R1 = R1+1 if the AND true
 SRL R0, R0, #1                     ; shift R0 1 bit to the right 
 ADD R2, R2, #-1                    ; counter = counter - 1
 BRnz END                           ; if counter is not positive, end
 JMP LOOP                           ; jumps to loop
END