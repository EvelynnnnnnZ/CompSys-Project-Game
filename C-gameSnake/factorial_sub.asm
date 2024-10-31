;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : factorial_sub.asm                          ;
;  author      : Yuqi Zhang
;  description : LC4 Assembly program to compute the    ;
;                factorial of a number                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;

 

;; TO-DO:
;; 1) Open up the codio assignment where you created the factorial subroutine (in a separate browswer window)
;; 2) In that window, open up your working factorial_sub.asm file:
;;    -select everything in the file, and "copy" this content (Conrol-C) 
;; 3) Return to the current codio assignment, paste the content into this factorial_sub.asm 
;;    -now you can use the factorial_sub.asm from your last HW in this HW
;; 4) Save the updated factorial_sub.asm file

;SUB_FACTORIAL             ; your subroutine goes here

.FALIGN                     ; aligns the subroutine
SUB_FACTORIAL               ; ARGS: R0(A), R1(B)
  ; PROLOGUE
  STR R7, R6, #-2	;; save caller's return address
	STR R5, R6, #-3	;; save caller's frame pointer 
	ADD R6, R6, #-3
	ADD R5, R6, #0
  ; FUNCTION BODY
  LDR R0, R5, #3
  LDR R1, R5, #3
  CMPI R0, #1                ; sets  NZP (A-1), while loop
  BRnz INVALID               ; tests NZP (was A-1 neg or zero?, if yes, goto INVALID)
SUB_LOOP
  CMPI R0, #1               ; sets  NZP (A-1), while loop
  BRnz END_FACTORIAL        ; tests NZP (was A-1 neg or zero?, if yes, goto END_FACTORIAL)
  ADD R0, R0, #-1           ; A = A - 1
  MUL R1, R1, R0            ; B = B * A
  BRnzp SUB_LOOP            ; always goto loop
  INVALID
    CONST R1, #-1           ; set B=-1
  END_FACTORIAL
  ADD R7, R1, #0
  ; EPILOGUE
  ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; decrease stack
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
    RET                     ; end subroutine
	  