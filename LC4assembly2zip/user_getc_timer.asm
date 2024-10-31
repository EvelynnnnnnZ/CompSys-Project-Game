;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : user_getc_timer.asm                            ;
;  author      : Yuqi Zhang
;  description : read characters from the keyboard,       ;
;	             with a timeout							 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The following CODE will go into USER's Program Memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x0000

CONST R0, xE8			; timeout of 1s in R0
HICONST R0 x03
TRAP x05				; call TRAP_GETC_TIMER

;;;  Students - run this code and see how it works before modifying!
;;;  once you load it into PennSim, press "continue" instead of step to run
;;;  type a character by clicking on the white box in left hand corner of PennSim


;;;  The following code will output "Type Here>" on the ASCII display
;;;  then it will then read one character from the keyboard
;;;  and output it back to the display
;;;  HINT: you could simplify this with a directive called ".STRINGZ" - see your textbook!


	
	;; To-Do
	;; add code to "loop" reading characters from keyboard and outputting them to display
	;; until the "enter" key is pressed

	;; pseudocode of algorithm you must implement for problem #1
	;;
	;; loop until (R0 == enter)
	;;    read character from keyboard into R0 using TRAP_GETC
	;;    write character from R0 to ASCII display using TRAP_PUTC
	;;    repeat loop...
	;; loop_end 

        ;TRAP x00               ; read character from keyboard (***could we just write this? or we need to install TRAP as the ppt showed?)
        ;TRAP x01               ; write character from R0 to ASCII display
        ;ADD R1, R0, #-10        ; "enter"'s ASCII is 13, test if R0 is enter


END


