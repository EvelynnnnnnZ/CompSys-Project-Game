;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : os.asm                                 ;
;  author      : 
;  description : LC4 Assembly program to serve as an OS ;
;                TRAPS will be implemented in this file ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;   OS - TRAP VECTOR TABLE   ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.OS
.CODE
.ADDR x8000
  ; TRAP vector table
  JMP TRAP_GETC           ; x00
  JMP TRAP_PUTC           ; x01
  JMP TRAP_GETS           ; x02
  JMP TRAP_PUTS           ; x03
  JMP TRAP_TIMER          ; x04
  JMP TRAP_GETC_TIMER     ; x05
  JMP TRAP_RESET_VMEM	  ; x06
  JMP TRAP_BLT_VMEM	      ; x07
  JMP TRAP_DRAW_PIXEL     ; x08
  JMP TRAP_DRAW_RECT      ; x09
  JMP TRAP_DRAW_SPRITE    ; x0A
  JMP TRAP_LFSR_SET_SEED  ; x0B
  JMP TRAP_LFSR           ; x0C





  ;
  ; TO DO - add additional vectors as described in homework 
  ;
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;   OS - MEMORY ADDRESSES & CONSTANTS   ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; these handy alias' will be used in the TRAPs that follow
  USER_CODE_ADDR .UCONST x0000	; start of USER code
  OS_CODE_ADDR 	 .UCONST x8000	; start of OS code

  OS_GLOBALS_ADDR .UCONST xA000	; start of OS global mem
  OS_STACK_ADDR   .UCONST xBFFF	; start of OS stack mem

  OS_KBSR_ADDR .UCONST xFE00  	; alias for keyboard status reg
  OS_KBDR_ADDR .UCONST xFE02  	; alias for keyboard data reg

  OS_ADSR_ADDR .UCONST xFE04  	; alias for display status register
  OS_ADDR_ADDR .UCONST xFE06  	; alias for display data register

  OS_TSR_ADDR .UCONST xFE08 	; alias for timer status register
  OS_TIR_ADDR .UCONST xFE0A 	; alias for timer interval register

  OS_VDCR_ADDR	.UCONST xFE0C	; video display control register
  OS_MCR_ADDR	.UCONST xFFEE	; machine control register
  OS_VIDEO_NUM_COLS .UCONST #128
  OS_VIDEO_NUM_ROWS .UCONST #124


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; OS DATA MEMORY RESERVATIONS ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xA000
OS_GLOBALS_MEM	.BLKW x1000
;;;  LFSR value used by lfsr code
LFSR .FILL 0x0001


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; OS VIDEO MEMORY RESERVATION ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xC000
OS_VIDEO_MEM .BLKW x3E00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;   OS & TRAP IMPLEMENTATIONS BEGIN HERE   ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x8200
.FALIGN
  ;; first job of OS is to return PennSim to x0000 & downgrade privledge
  CONST R7, #0   ; R7 = 0
  RTI            ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - none
;;; Outputs          - R0 = ASCII character from ASCII keyboard

.CODE
TRAP_GETC
    LC R0, OS_KBSR_ADDR  ; R0 = address of keyboard status reg
    LDR R0, R0, #0       ; R0 = value of keyboard status reg
    BRzp TRAP_GETC       ; if R0[15]=1, data is waiting!
                             ; else, loop and check again...

    ; reaching here, means data is waiting in keyboard data reg

    LC R0, OS_KBDR_ADDR  ; R0 = address of keyboard data reg
    LDR R0, R0, #0       ; R0 = value of keyboard data reg
    RTI                  ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a single character out to ASCII display
;;; Inputs           - R0 = ASCII character to write to ASCII display
;;; Outputs          - none

.CODE
TRAP_PUTC
  LC R1, OS_ADSR_ADDR 	; R1 = address of display status reg
  LDR R1, R1, #0    	; R1 = value of display status reg
  BRz TRAP_PUTC    	; if R1[15]=1, display is ready to write!
		    	    ; else, loop and check again...

  ; reaching here, means console is ready to display next char

  LC R1, OS_ADDR_ADDR 	; R1 = address of display data reg
  STR R0, R1, #0    	; R1 = value of keyboard data reg (R0)
  RTI			; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETS   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a string of characters from the ASCII keyboard
;;; Inputs           - R0 = Address to place characters from keyboard
;;; Outputs          - R1 = Length of the string without the NULL

.CODE
TRAP_GETS
; Check if R0 is a valid address in data memory
  CONST R2 x00
  HICONST R2 x20
  CMP R0, R2                ; test if R0 is smaller than x2000
  BRn TRAP_GETS             ; if so, return
  CONST R3 xFF
  HICONST R3 x7F    
  CMP R0, R3                ; test if R0 is grater than x7FFF
  BRp TRAP_GETS             ; if so, return
  CONST R1, #0              ; set R1 to 0
  LOOP_GETS
    CHECK_GETS
      LC R2, OS_KBSR_ADDR  ; R2 = address of keyboard status reg
      LDR R2, R0, #0       ; R2 = value of keyboard status reg
      BRz CHECK_GETS       ; if R2[15]=1, data is waiting!
                             ; else, loop and check again
    ; reaching here, means data is waiting in keyboard data reg
    LC R2, OS_KBDR_ADDR  ; R2 = address of keyboard data reg
    LDR R2, R2, #0       ; R2 = value of keyboard data reg
    CMPI R2, x0A         ; Check if R2 = return key x0A
    BRp LOOP_GETS_END
    STR R2, R0, #0       ; Store R2 ASCII into address at R0
    ADD R0, R0, #1       ; move to the next address
    ADD R1, R1, #1       ; increment length
    BRnzp LOOP_GETS
  LOOP_GETS_END
  RTI                     ; PC = R7 ; PSR[15]=0




;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTS   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a string of characters out to ASCII display
;;; Inputs           - R0 = Address for first character
;;; Outputs          - none

.CODE
TRAP_PUTS
  CONST R2 x00
  HICONST R2 x20
  CMP R0, R2                ; test if R0 is smaller than x2000
  BRn TRAP_PUTS             ; if so, return
  CONST R3 xFF
  HICONST R3 x7F    
  CMP R0, R3                 ; test if R0 is grater than x7FFF
  BRp TRAP_PUTS              ; if so, return
  LDR R4, R0, #0             ; load the ASCII character from the address hold in R0 
  LOOP_PUTS
    BRz LOOP_PUTS_END        ; if R4==NULL, end
    LC R5, OS_ADSR_ADDR      ; R5 = address of display status reg
    LDR R5, R5, #0           ; R5 = value of display status reg
    BRzp LOOP_PUTS    
    LC R5, OS_ADDR_ADDR      ; R5 = address of display data reg
    STR R4, R5, #0           ; R5 = value of keyboard data reg (R4)
    ADD R0, R0, #1           ; load the next ASCII character
    LDR R4, R0, #0           ; load new ASCII character
    BRnzp LOOP_PUTS
  LOOP_PUTS_END

  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function:
;;; Inputs           - R0 = time to wait in milliseconds
;;; Outputs          - none

.CODE
TRAP_TIMER
  LC R1, OS_TIR_ADDR 	; R1 = address of timer interval reg
  STR R0, R1, #0    	; Store R0 in timer interval register

COUNT
  LC R1, OS_TSR_ADDR  	; Save timer status register in R1
  LDR R1, R1, #0    	; Load the contents of TSR in R1
  BRzp COUNT    	; If R1[15]=1, timer has gone off!

  ; reaching this line means we've finished counting R0

  RTI       		; PC = R7 ; PSR[15]=0



;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - R0 = time to wait
;;; Outputs          - R0 = ASCII character from keyboard (or NULL)

.CODE
TRAP_GETC_TIMER

  LC R1, OS_TIR_ADDR  ; R1 = address of timer interval reg
  STR R0, R1, #0      ; Store R0 in timer interval register

COUNT_GETC_TIMER
  LC R1, OS_TSR_ADDR               ; Save timer status register in R1
  LDR R1, R1, #0                   ; Load the contents of TSR in R1
  BRn READY_END                    ; If R1[15]=1, timer has gone off! 
  LC R0, OS_KBSR_ADDR  ; R0 = address of keyboard status reg
    LDR R0, R0, #0       ; R0 = value of keyboard status reg
    BRzp COUNT_GETC_TIMER       ; if R0[15]=1, data is waiting!
  
    ; reaching here, means data is waiting in keyboard data reg

    LC R0, OS_KBDR_ADDR  ; R0 = address of keyboard data reg
    LDR R0, R0, #0       ; R0 = value of keyboard data reg
    JMP END_TIMER
  ; reaching this line means we've finished counting R0
    READY_END 
      CONST R0, #0
      BRnzp END_TIMER
  END_TIMER ;

  ;;
  ;; TO DO: complete this trap
  ;;

  RTI                  ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TRAP_RESET_VMEM ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; In double-buffered video mode, resets the video display
;;; DO NOT MODIFY this trap, it's for future HWs
;;; Inputs - none
;;; Outputs - none
.CODE	
TRAP_RESET_VMEM
  LC R4, OS_VDCR_ADDR
  CONST R5, #1
  STR R5, R4, #0
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TRAP_BLT_VMEM ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_BLT_VMEM - In double-buffered video mode, copies the contents
;;; of video memory to the video display.
;;; DO NOT MODIFY this trap, it's for future HWs
;;; Inputs - none
;;; Outputs - none
.CODE
TRAP_BLT_VMEM
  LC R4, OS_VDCR_ADDR
  CONST R5, #2
  STR R5, R4, #0
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_PIXEL   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw point on video display
;;; Inputs           - R0 = row to draw on (y)
;;;                  - R1 = column to draw on (x)
;;;                  - R2 = color to draw with
;;; Outputs          - none

.CODE
TRAP_DRAW_PIXEL
  LEA R3, OS_VIDEO_MEM       ; R3=start address of video memory
  LC  R4, OS_VIDEO_NUM_COLS  ; R4=number of columns

  CMPIU R1, #0    	         ; Checks if x coord from input is > 0
  BRn END_PIXEL
  CMPIU R1, #127    	     ; Checks if x coord from input is < 127
  BRp END_PIXEL
  CMPIU R0, #0    	         ; Checks if y coord from input is > 0
  BRn END_PIXEL
  CMPIU R0, #123    	     ; Checks if y coord from input is < 123
  BRp END_PIXEL

  MUL R4, R0, R4      	     ; R4= (row * NUM_COLS)
  ADD R4, R4, R1      	     ; R4= (row * NUM_COLS) + col
  ADD R4, R4, R3      	     ; Add the offset to the start of video memory
  STR R2, R4, #0      	     ; Fill in the pixel with color from user (R2)

END_PIXEL
  RTI       		         ; PC = R7 ; PSR[15]=0
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_RECT   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw rectangle outto the video display
;;; Inputs    -R0 – “x coordinate” of upper-left corner of the rectangle. 
;             -R1 – “y coordinate” of upper-left corner of the rectangle. 
;             -R2 – length of the rectangle (in number of pixels). (x)
;             -R3 – width of the side of the rectangle (in number of pixels). (y)
;             -R4 – the color of the rectangle 
;;; Outputs   none

.CODE
TRAP_DRAW_RECT
  LEA R5, OS_VIDEO_MEM       ; R5=start address of video memory
  LEA R6, OS_GLOBALS_MEM

  STR R2, R6, #0             ; store R2 into an address in data memory 
  STR R0, R6, #1             ; store starting coordinate

    LOOP_Y_RECT
        
        LOOP_X_RECT
          LC  R6, OS_VIDEO_NUM_COLS  ; R6=number of columns
          CMPIU R0, #0    	         ; Checks if x coord from input is > 0
          BRn END_RECT

          CMPIU R0, #127    	     ; Checks if x coord from input is < 127
          BRp LOOP_X_RECT_END
          CMPIU R1, #0    	         ; Checks if y coord from input is > 0
          BRn END_RECT
          CMPIU R1, #123    	     ; Checks if y coord from input is < 123
          BRp END_RECT
          
          LC  R6, OS_VIDEO_NUM_COLS  ; R6=number of columns
          MUL R6, R1, R6      	     ; R6= (row * NUM_COLS)
          ADD R6, R6, R0      	     ; R6= (row * NUM_COLS) + col
          ADD R6, R6, R5      	     ; Add the offset to the start of video memory
          STR R4, R6, #0      	     ; Fill in the pixel with color from user (R4) ******** either stuck right here, or never print anything
          ADD R0, R0, #1             ; move to the next pixel
          ADD R2, R2, #-1            ; one less to move horizontally
          BRz LOOP_X_RECT_END     
          JMP LOOP_X_RECT
        LOOP_X_RECT_END
        LEA R6, OS_GLOBALS_MEM         ; reset R1
        LDR R2, R6, #0
        ADD R1, R1, #1                ; move to the next row
        LEA R6, OS_GLOBALS_MEM         ; reset R0
        LDR R0, R6, #1                ; reset R0
        ADD R3, R3, #-1               ; one less to move vertically
        BRnz LOOP_Y_RECT_END
        BRnzp LOOP_Y_RECT

    LOOP_Y_RECT_END

END_RECT
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_SPRITE   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw an 8x8 block of picels on the video display based on a bit pattern that the user supplies
;;; Inputs    R0 should contain the starting column in the video memory (0-127) (x)
;             R1 should contain the starting row in video memory (0 - 123) (y)
;             R2 should contain the color of the sprite 
;             R3 should contain the starting address, in user data memory, of an array of 8 
;                LC- 4 words that specify the bit pattern of the sprite. 
;;; Outputs   none
.CODE
TRAP_DRAW_SPRITE
  LEA R5, OS_VIDEO_MEM       ; R5=start address of video memory
  LEA R6, OS_GLOBALS_MEM
  STR R7, R6, #0
  STR R1, R6, #1             ; store starting coordinate

  CMPIU R0, #0    	         ; Checks if x coord from input is > 0
  BRn END_SPRITE
  CMPIU R0, #127    	     ; Checks if x coord from input is < 127
  BRp END_SPRITE
  CMPIU R1, #0    	         ; Checks if y coord from input is > 0
  BRn END_SPRITE
  CMPIU R1, #123    	     ; Checks if y coord from input is < 123
  BRp END_SPRITE
  CONST R7, #8               ; set R7 = 8

    LOOP_Y_SPRITE
        LDR R4, R3, #0             ; load content of R3, 8 bits
        SLL R4, R4, #8

        LOOP_X_SPRITE
          LC  R6, OS_VIDEO_NUM_COLS  ; R6=number of columns
          CMPI R4, #0                ; check if we need to fill in color for this pixel
          BRz LOOP_X_SPRITE_END       ; if we've done with the row
          BRp JUMP_NEXT               ; if it's positiv, we shouldn't draw
          MUL R6, R1, R6      	     ; R6= (row * NUM_COLS)
          ADD R6, R6, R0      	     ; R6= (row * NUM_COLS) + col
          ADD R6, R6, R5      	     ; Add the offset to the start of video memory
          STR R2, R6, #0      	     ; Fill in the pixel with color from user (R4) ******** either stuck right here, or never print anything
          JUMP_NEXT
            ADD R1, R1, #1             ; move to the next pixel
          SLL R4, R4, #1
          BRz LOOP_X_SPRITE_END
          JMP LOOP_X_SPRITE
        LOOP_X_SPRITE_END
        ADD R0, R0, #1                ; move to the next row
        LEA R6, OS_GLOBALS_MEM         ; reset R1
        LDR R1, R6, #1                ; reset R1
        ADD R7, R7, #-1               ; one less to move vertically
        ADD R3, R3, #1                ; read next line
        BRnz LOOP_Y_SPRITE_END
        BRnzp LOOP_Y_SPRITE
    LOOP_Y_SPRITE_END

END_SPRITE
  LEA R6, OS_GLOBALS_MEM
    ;HICONST
  LDR R7, R6, #0

  RTI

.CODE

TRAP_LFSR_SET_SEED
  ;CONST R1, x00
  ;HICONST R1, xA0
  ;STR R0, R1, #0                
  LEA R2, LFSR                 ; let R1 represent the adddress of seed
  STR R0, R2, #0               ; store R0 at xA000 


  RTI

.CODE
TRAP_LFSR



  ;AND R2, R0, R2       ; R2 = 15th bit            
  ;SRL R2, R2, #15      ; shift what we just saved to the right end
  LDR, R0, R2, #0
  
  SRL R2, R0, #15       ; shift 15 th bit of R0 to the right end
  AND R2, R2, #1        ; R2= 15th of R0
 
  SRL R3, R0, #13      ; shift what we just saved to the right end
  AND R3, R3, #1       ; R3 = 13th bit
  
  SRL R4, R0, #12      ; shift what we just saved to the right end
  AND R4, R4, #1       ; R4 = 12th bit

  SRL R5, R0, #10      ; shift what we just saved to the right end
  AND R5, R5, #1       ; R5 = 10th bit

  XOR R6, R2, R3       ; xor for 15th and 13th
  XOR R6, R6, R4       ; xor previous with 12th
  XOR R6, R6, R5       ; xor previous with 10th
  SLL R0, R0, #1       ; shifting R0 leftward
  ADD R0, R0, R6       ; save result of the xors to R0
  LEA R2, LFSR
  STR R0, R2, #0      ; update the value in xA000



 
  RTI



