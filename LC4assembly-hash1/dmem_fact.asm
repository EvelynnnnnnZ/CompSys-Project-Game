;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : dmem_fact.asm                          ;
;  author      : Yuqi Zhang
;  description : LC4 Assembly program to compute the    ;
;                factorial of a number, working with    ;
;                data memory                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;

; Below is my answer for Question 3

;; This is the data section
	.DATA
	.ADDR x4020		              ; Start the data at address 0x4020 **************not working properly?
	
global_array
	.FILL #6
	.FILL #5
	.FILL #8
	.FILL #10
	.FILL #-5
  
;; Start of the code section
	.CODE
	.ADDR 0x0000		            ; Start the code at address 0x0000
INIT
	LEA R2, global_array	      ; R2 contains the address of the data
	CONST R3, 5		              ; R4 is our loop counter init to 5
	
FOR_LOOP
  LDR R0, R2, #0              ; SETUP ARGUMENTS: A = first number
  ADD R1, R0, #0              ; B=A 
  JSR SUB_FACTORIAL           ; CALL TO SUBROUTINE: B = sub_factorial (A)
  STR R1, R2, #0              ; store the B after doing sub_factorial 
  ADD R2, R2, #1              ; add R2 with 1
  ADD R3, R3, #-1             ; counter = counter - 1
  BRnz END                    ; end if counter is negative or zero
  JMP FOR_LOOP                ; jumps over the for loop in subroutine
  .FALIGN                     ; aligns the subroutine
  SUB_FACTORIAL               ; ARGS: R0(A), R1(B)
   CMPI R0, #1                ; sets  NZP (A-1), while loop
   BRnz INVALID               ; tests NZP (was A-1 neg or zero?, if yes, goto END)
  SUB_LOOP
    CMPI R0, #1               ; sets  NZP (A-1), while loop
    BRnz END_FACTORIAL        ; tests NZP (was A-1 neg or zero?, if yes, goto END)
    ADD R0, R0, #-1           ; A = A - 1
    MUL R1, R1, R0            ; B = B * A
    BRnzp SUB_LOOP            ; end loop
    INVALID
      CONST R1, #-1           ; set B=-1
    END_FACTORIAL
      RET                     ; end subroutine
END                           ; end program
	  
 