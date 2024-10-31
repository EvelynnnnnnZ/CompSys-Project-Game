;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : factorial.asm                          ;
;  author      : Yuqi Zhang
;  description : LC4 Assembly program to compute the    ;
;                factorial of a number                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;; pseudo-code of factorial algorithm
;
; A = 5 ;  // example to do 5!
; B = A ;  // B=A! when while loop completes
;
; while (A > 1) {
; 	A = A - 1 ;
; 	B = B * A ;
; }
;

;;; TO-DO: Implement the factorial algorithm above using LC4 Assembly instructions
; register allocation: R0=A, R1=B, 
; Below is my answer for Question 1
	  
  CONST R0, #5      ; A = 5
  ADD R1, R0, #0    ; B = A
 
LOOP
  CMPI R0, #1       ; sets  NZP (A-1)
  BRnz END          ; tests NZP (was A-1 neg or zero?, if yes, goto END)
  ADD R0, R0, #-1   ; A = A - 1
  MUL R1, R1, R0    ; B = B * A
  BRnzp LOOP        ; always goto LOOP
END