;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : lc4_stdio.asm                          ;
;  author      : 
;  description : LC4 Assembly subroutines that call     ;
;                call the TRAPs in os.asm (the wrappers);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; WRAPPER SUBROUTINES FOLLOW ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
.CODE
.ADDR x0010    ;; this code should be loaded after line 10
               ;; this is done to preserve "USER_START"
               ;; subroutine that calls "main()"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_PUTC Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_putc

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0 	;; these four lines same for all traps, won't repeat for lc4_traps below. 
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3	; set R0
    TRAP x01        ; R0 must be set before TRAP_PUTC is called
    
    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    STR R7, R6, #-1 ;; store return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETC Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_getc

    ;; PROLOGUE ;;
        ; TODO: write prologue code here
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0

    ;; FUNCTION BODY ;;
        ; TODO: TRAP_GETC doesn't require arguments!
        
    TRAP x00        ; Call's TRAP_GETC 
                    ; R0 will contain ascii character from keyboard
                    ; you must copy this back to the stack
    
    ;; EPILOGUE ;; 
        ; TRAP_GETC has a return value, so make certain to copy it back to stack
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    STR R0, R6, #-1 ;; store return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 

RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETS Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_gets

    ;; PROLOGUE ;;
        ; TODO: write prologue code here
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0

    ;; FUNCTION BODY ;;
        ; TODO: TRAP_GETC doesn't require arguments!
        
    TRAP x02        ; Call's TRAP_GETC 
                    ; R0 will contain ascii character from keyboard
                    ; you must copy this back to the stack
    
    ;; EPILOGUE ;; 
        ; TRAP_GETC has a return value, so make certain to copy it back to stack
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    STR R0, R6, #-1 ;; store return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 

RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_PUTS Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_puts

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3	; set R0
    TRAP x03        ; R0 must be set before TRAP_PUTS is called
    
    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    ;STR R7, R6, #-1    ;; store return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_TIMER Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_timer

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3	; set R0
    TRAP x04        ; R0 must be set before TRAP_PUTS is called
    
    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    STR R7, R6, #-1 ;; store return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETC_TIMER Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_getc_timer

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3	; set R0
    TRAP x05        ; R0 must be set before TRAP_PUTS is called
    
    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    STR R0, R6, #-1 ;; store return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_PIXEL Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_pixel

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3
    LDR R1, R5, #4
    LDR R2, R5, #5	; set R0, R1, R2
    TRAP x08        ; R0, R1, R2 must be set before TRAP_PUTS is called
    
    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    STR R7, R6, #-1 ;; store return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_RECT Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_rect

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3
    LDR R1, R5, #4
    LDR R2, R5, #5
    LDR R3, R5, #6
    LDR R4, R5, #7	; set R0, R1, R2, R3, R4

    CONST R7, x20
    HICONST R7, x30
    STR R5, R7, #-2
    STR R6, R7, #-3	; since we're using R5 and R6 in the code, I store them here

    TRAP x09        ; R0, R1, R2, R3, R4 must be set before TRAP_PUTS is called

    CONST R7, x20
    HICONST R7, x30
    LDR R5, R7, #-2
    LDR R6, R7, #-3	; get the original R5 and R6 back

    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value

    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_SPRITE Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_sprite

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3
    LDR R1, R5, #4
    LDR R2, R5, #5
    LDR R3, R5, #6	;set R0, R1, R2, R3

    CONST R7, x20
    HICONST R7, x30
    STR R5, R7, #-2
    STR R6, R7, #-3	; since we're using R5 and R6 in the code, I store them here

    TRAP x0A        ; R0, R1, R2, R3 must be set before TRAP_PUTS is called
    
    CONST R7, x20
    HICONST R7, x30
    LDR R5, R7, #-2
    LDR R6, R7, #-3	; get the original R5 and R6 back

    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_LFSR Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_lfsr

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call

    CONST R7, x20
    HICONST R7, x30
    STR R5, R7, #-2
    STR R6, R7, #-3	; since we're using R5 and R6 in the code, I store them here

    TRAP x0C        ; R0 must be set before TRAP_PUTS is called
    
    CONST R7, x20
    HICONST R7, x30
    LDR R5, R7, #-2
    LDR R6, R7, #-3	;get R5 and R6 back

    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    STR R0, R6, #-1 ;; store return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_LFSR_SET_SEED Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_lfsr_set_seed

    ;; PROLOGUE ;;
    STR R7, R6, #-2 ;; save return address
    STR R5, R6, #-3 ;; save base pointer
    ADD R6, R6, #-3
    ADD R5, R6, #0
    ;; FUNCTION BODY ;;
        ; TODO: write code to get arguments to the trap from the stack
        ;  and copy them to the register file for the TRAP call
    LDR R0, R5, #3	; set R0
    TRAP x0B        ; R0 must be set before TRAP_PUTS is called
    
    ;; EPILOGUE ;; 
    ADD R6, R5, #0  ;; pop locals off stack
    ADD R6, R6, #3  ;; free space for return address, base pointer, and return value
    LDR R5, R6, #-3 ;; restore base pointer same
    LDR R7, R6, #-2 ;; restore return address ; different with return value, some don't have 
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_RESET_VMEM Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_reset_vmem

    ;; STUDENTS - DON'T edit these wrappers - they must be here to get PennSim to work in double-buffer mode
    ;;          - DON'T use their prologue or epilogue's as models - use the slides!!
  
    ;; prologue
    ADD R6, R6, #-2
    STR R5, R6, #0
    STR R7, R6, #1
    ;; no arguments
    TRAP x06
    ;; epilogue
    LDR R5, R6, #0
    LDR R7, R6, #1
    ADD R6, R6, #2
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_BLT_VMEM Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_blt_vmem

    ;; STUDENTS - DON'T edit these wrappers - they must be here to get PennSim to work in double-buffer mode
    ;;          - DON'T use their prologue or epilogue's as models - use the slides!!

    ;; prologue
    ADD R6, R6, #-2
    STR R5, R6, #0
    STR R7, R6, #1
    ;; no arguments
    TRAP x07
    ;; epilogue
    LDR R5, R6, #0
    LDR R7, R6, #1
    ADD R6, R6, #2
RET




