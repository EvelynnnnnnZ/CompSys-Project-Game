;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : factorial_sub.asm                          ;
;  author      : Yuqi Zhang
;  description : LC4 Assembly program to compute the    ;
;                factorial of a number                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;

;;; TO-DO: Above the subroutine code, implement the following code to call the subroutine:  
; MAIN 
;  A = 6 ; 
;  B = sub_factorial (A) ; 
 
;  // your sub_factorial subroutine goes here 
;END

; Below is my answer for Question 2

  CONST R0, #6                ; SETUP ARGUMENTS: A = 6
  ADD R1, R0 #0               ; SET B=A 
  JSR SUB_FACTORIAL           ; CALL TO SUBROUTINE: B = sub_factorial (A) 
  JMP END                     ; jumps over subrourtine
  .FALIGN                     ; aligns the subroutine
  SUB_FACTORIAL               ; ARGS: R0(A), R1(B)
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
      RET                     ; end subroutine
END                           ; end program
	  
 