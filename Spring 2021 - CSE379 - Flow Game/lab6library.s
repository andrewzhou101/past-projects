	.text
	.global read_character
	.global output_character
	.global output_string
	.global read_string
	.global uart_init
	.global gpio_init
	.global read_from_push_btn
	.global illuminate_RGB_LED
	.global num_digits
	.global int2str
	.global str2int
	.global print_newline
	.global timer_init
    .global interrupt_init

	; Your routines go here
	; Required routines are shown in the global declarations above

;---------------------------------------------------------read_character----------------------------------------------------------

read_character:
    STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

    mov r1, #0xC000         ; Load bottom 16 bits to Data Register
    movt r1, #0x4000        ; Load top 16 bits to Data Register

    mov r2, #0xC018         ; Load bottom 16 bits to Flag Register
    movt r2, #0x4000        ; Load top 16 bits to Flag Register

rc_loop:
    ldr r3, [r2]            ; Load flag register value into r3
    AND r4, r3, #0x10    	; Check the bit corresponding to RxFE
    cmp r4, #0x10
    BNE rc_continue
    B rc_loop

rc_continue:
    LDRB r0, [r1]

    LDMFD sp!, {lr, r4-r11}
    mov pc, lr


;--------------------------------------------------------output_character---------------------------------------------------------

output_character:
    STMFD sp!, {lr, r4-r11}  ; Registers 4 through 11 need to be preserved

    mov r1, #0xC000          ; Load bottom 16 bits to Data Register
    movt r1, #0x4000         ; Load top 16 bits to Data Register
    ADD r2, r1, #0x18        ; Add 0x18 to set r2 to the flag register
    mov r3, #0x20            ; Set r3 to 0x10 0000 to check bits


check:
    ldr r4, [r2]            ; Check the bit corresponding to TXFF
    AND r4, r4, #0x20        ; AND the flag register with 0010 0000 to check bit 5
    cmp r4, r3                ; If TXFF is 0
    BNE continue            ; We can modify the Data
    B check                    ; Otherwise, check it again

continue:
    str r0, [r1]            ; Put the chraracter in r0 into C0004000 (The UART Data)
    LDMFD sp!, {lr, r4-r11}
    mov pc, lr


;----------------------------------------------------------output_string----------------------------------------------------------

output_string:
    STMFD sp!, {lr, r1-r11} ; Registers 4 through 11 need to be preserved

    ; I assume that r0 is a ptr to a string
    ; This uses output character, which uses r0 - r4
    ; This also uses r5 and r6

    MOV r5, r0                   ; move the ptr to r5

output_loop:
    LDRB r6, [r5]                ; load byte at r1
    CMP r6, #0x00                ; Compare byte to null byte
    BEQ end_output_loop          ; If byte is null byte, end loop
    MOV r0, r6                   ; otherwise, run output chracter with that byte
    BL output_character          ; output character uses r0 - r4, so use other registers when using output_string
    ADD r5, r5, #1               ; Add one to the pointer so we can get the next value
    B output_loop


end_output_loop:
    LDMFD sp!, {lr, r1-r11}
    mov pc, lr


;-----------------------------------------------------------read_string-----------------------------------------------------------

read_string:
	STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

	mov r6, r0				; Store the pointer into r6

read_null:
	BL read_character

	str r0, [r6]			; store the character into r6
	ADD r6, r6, #1			; increment the pointer address so that we don't overwrite the string

	cmp r0, #0xD            ; compare the value just read with the return character
	BNE read_null           ; if it isnt the return character, the string hasnt been fully read yet and we restart the subroutine

	mov r0, r6				; the string has been fully read, so move the string into the pointer we were given

	SUB r0, r0, #1          ; remove the return character from the string
	mov r1, #0x0			; store the null byte into r1
	strb r1, [r0]			; place this into r0 to signify the end of the string

	LDMFD sp!, {lr, r4-r11}
	mov pc, lr


;------------------------------------------------------------uart_init------------------------------------------------------------

uart_init:
    STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

    ; Your code for your uart_init routine is placed here

    ; Provide clock to UART0
    mov r0, #0xE618
    movt r0, #0x400F
    ldr r1, [r0]
    orr r1, r1, #0x1
    str r1, [r0]
    ; Enable clock to PortA
    mov r0, #0xE608
    movt r0, #0x400F
    ldr r1, [r0]
    orr r1, r1, #0x1
    str r1, [r0]
    ; Disable UART0 Control
    mov r0, #0xC030
    movt r0, #0x4000
    ldr r1, [r0]
    orr r1, r1, #0x0
    str r1, [r0]
    ; Set UART0_IBRD_R for 115,200 baud
    mov r0, #0xC024
    movt r0, #0x4000
    ldr r1, [r0]
    orr r1, r1, #0x8
    str r1, [r0]
    ; UART0_FBRD_R for 115,200 baud
    mov r0, #0xC028
    movt r0, #0x4000
    ldr r1, [r0]
    orr r1, r1, #0x2C
    str r1, [r0]
    ; Use System Clock
    mov r0, #0xCFC8
    movt r0, #0x4000
    ldr r1, [r0]
    orr r1, r1, #0x0
    str r1, [r0]
    ; Use 8-bit word length, 1 stop bit, no parity
    mov r0, #0xC02C
    movt r0, #0x4000
    ldr r1, [r0]
    orr r1, r1, #0x60
    str r1, [r0]
    ; Enable UART0 Control
    mov r0, #0xC030
    movt r0, #0x4000
    ldr r1, [r0]
    mov r2, #0x301
    orr r1, r1, r2
    str r1, [r0]
    ; Make PA0 and PA1 as Digital Ports
    mov r0, #0x451C
    movt r0, #0x4000
    ldr r1, [r0]
    orr r1, r1, #0x03
    str r1, [r0]
    ; Change PA0, PA1 to use an alternate function
    mov r0, #0x4420
    movt r0, #0x4000
    ldr r1, [r0]
    orr r1, r1, #0x03
    str r1, [r0]
    ; Configure PA0 and PA1 for UART
    mov r0, #0x452C
    movt r0, #0x4000
    ldr r1, [r0]
    orr r1, r1, #0x11
    str r1, [r0]

    LDMFD sp!, {lr, r4-r11}
    mov pc, lr


;------------------------------------------------------------gpio_init------------------------------------------------------------

gpio_init:
	STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

	; Provide clock to UART0
	mov r0, #0xE618
	movt r0, #0x400F
	ldr r1, [r0]
	orr r1, r1, #0x1
	str r1, [r0]
    ; Enable GPIO Clock for Port F
    mov r0, #0xE608
    movt r0, #0x400F
    ldr r1, [r0]
    orr r1, r1, #0x20
    str r1, [r0]
    ; Change GPIO Direction to Output for pins 1 - 3. Change GPIO Direction to Input for pin 4.
	mov r0, #0x5400
	movt r0, #0x4002
	ldr r1, [r0]
	orr r1, r1, #0xE
	mov r2, #0xDF
	AND r1, r1, r2
	str r1, [r0]
	; Make pins 1 - 4 digital
	mov r0, #0x551C
	movt r0, #0x4002
	ldr r1, [r0]
	orr r1, r1, #0x1E
	str r1, [r0]
	; Activate pull up resistor for pin 4
	mov r0, #0x5510
	movt r0, #0x4002
	ldr r1, [r0]
	orr r1, r1, #0x10
	str r1, [r0]

	LDMFD sp!, {lr, r4-r11}
	MOV pc, lr


;--------------------------------------------------------read_from_push_btn-------------------------------------------------------
read_from_push_btn:
	STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

	; Your code is placed here

	; Load Data Register Value into r1
	mov r0, #0x53FC
	movt r0, #0x4002
	ldr r1, [r0]
	and r1, r1, #0x10	; Isolate the 4th bit
	cmp r1, #0x10
	BEQ zero			; if pin 4 == 1, go to zero
	B one				; else go to one

one:
	mov r0, #0x1
	B end
zero:
	mov r0, #0x0
end:

	LDMFD sp!, {lr, r4-r11}
	MOV pc, lr


;--------------------------------------------------------illuminate_RGB_LED-------------------------------------------------------
illuminate_RGB_LED:
    ; Illuminates the corresponding RBG LED on the Tiva
    ; The color to be displayed is passed into r0, the key to which is as follows:
        ; r0 = 0 is no_color
        ; r0 = 1 is red
        ; r0 = 2 is green
        ; r0 = 3 is yellow
        ; r0 = 4 is blue
        ; r0 = 5 is purple
        ; r0 = 6 is cyan
		; r0 = 7 is white

    STMFD sp!, {lr, r1-r12} ; Registers 4 through 11 need to be preserved

    MOV r1, #0x5000            ; Base address for Port F stored in r1
    MOVT r1, #0x4002
    ADD r2, r1, #0x3FC    ; Address for Port F's data register is stored in r2

    CMP r0, #0                ; No Color
    BEQ no_color              ; Go to no_color

    CMP r0, #1                ; If the color to be printed is red...
    BEQ red                    ; Go to red

    CMP r0, #2                ; If the color to be printed is
    BEQ green                ; Go to green

    CMP r0, #3                ; If the color to be printed is
    BEQ yellow                ; Go to yellow

    CMP r0, #4                ; If the color to be printed is
    BEQ blue                ; Go to blue

    CMP r0, #5                ; If the color to be printed is
    BEQ purple                ; Go to purple

	CMP r0, #6					; If color to be printed is cyan
	BEQ cyan

    CMP r0, #7                ; If the color to be printed is
    BEQ white                ; Go to white



    B illuminate_exit        ; If none of the colors match, exit immediately
red:
    LDR r3, [r2]            ; Load the value of the data register into r3
    AND r3, r3, #0xF1		; Reset LED values
    ORR r3, r3, #0x2        ; OR it to turn red on
    STR r3, [r2]            ; Store the value of r3 into r2
    B illuminate_exit        ; Exit

blue:
    LDR r3, [r2]            ; Load the value of the data register into r3
    AND r3, r3, #0xF1		; Reset LED values
    ORR r3, r3, #0x4        ; OR it to turn blue on
    STR r3, [r2]            ; Store the value of r3 into r2
    B illuminate_exit        ; Exit

green:
    LDR r3, [r2]            ; Load the value of the data register into r3
    AND r3, r3, #0xF1		; Reset LED values
    ORR r3, r3, #0x8        ; OR it to turn green on
    STR r3, [r2]            ; Store the value of r3 into r2
    B illuminate_exit        ; Exit

purple:
    LDR r3, [r2]            ; Load the value of the data register into r3
    AND r3, r3, #0xF1		; Reset LED values
    ORR r3, r3, #0x6        ; OR it to turn purple on
    STR r3, [r2]            ; Store the value of r3 into r2
    B illuminate_exit        ; Exit

yellow:
    LDR r3, [r2]            ; Load the value of the data register into r3
    AND r3, r3, #0xF1		; Reset LED values
    ORR r3, r3, #0xA        ; OR it to turn yellow on
    STR r3, [r2]            ; Store the value of r3 into r2
    B illuminate_exit        ; Exit

cyan:
    LDR r3, [r2]            ; Load the value of the data register into r3
    AND r3, r3, #0xF1		; Reset LED values
    ORR r3, r3, #0xC        ; OR it to turn cyan on
    STR r3, [r2]            ; Store the value of r3 into r2
    B illuminate_exit       ; Exit

white:
    LDR r3, [r2]            ; Load the value of the data register into r3
    AND r3, r3, #0xF1		; Reset LED values
    ORR r3, r3, #0xE        ; OR it to turn white on
    STR r3, [r2]            ; Store the value of r3 into r2
    B illuminate_exit        ; Exit

no_color:
    LDR r3, [r2]            ; Load the value of the data register into r3
    AND r3, r3, #0xF1		; Reset LED values
    STR r3, [r2]            ; Store the value of r3 into r2
    B illuminate_exit        ; Exit

illuminate_exit:
    LDMFD sp!, {lr, r1-r12}
    MOV pc, lr


;------------------------------------------------------------num_digits-----------------------------------------------------------

num_digits:
	; number to count in r0
	; number counted that we return in r2

	STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

	MOV r2, #0							; initialize the counter to 0

divide_num:
	MOV r1, #10							; set a register to 10
	UDIV r0, r0, r1						; divide the number by 10
	ADD r2, r2, #1						; add one to the digits counted

	CMP r0, #0							; check if we have hit 0 yet
	BNE divide_num						; if we have not, divide again

	MOV r0, r2							; move the return value back into r0

	LDMFD sp!, {lr, r4-r11}
	MOV pc, lr


;-------------------------------------------------------------int2str-------------------------------------------------------------

int2str:
	; the integer to be converted is passed into r0
	; pointer to the string is passed into r1
	; the number of digits in the integer are passed into r2

	STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

	ADD r1, r1, r2						; add number of digits to pointer
	mov r8, #0x00						; assign null byte to use it for store wording
	STRB r8, [r1]						; store null at the address pointed to by the pointer

divide_int2str:
	SUB r1, r1, #1						; subtract one from the pointer

	MOV r3, #10							; set a register to 10
	UDIV r4, r0, r3						; divide the number by 10
	MUL r5, r4, r3						; multiply the quotient by 10

	SUB r6, r0, r5						; subtract product from integer
	ADD r7, r6, #0x30					; get ASCII value

	STRB r7, [r1]						; store ASCII value at address currently being pointed to
	MOV r0, r4							; remove least significant digit from integer

	CMP r0, #0							; is the integer zero yet?
	BNE divide_int2str					; branch if it isn't

	LDMFD sp!, {lr, r4-r11}
	MOV pc, lr


;-------------------------------------------------------------str2int-------------------------------------------------------------

str2int:
    STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

    ; Your code for the str2int routine goes here.
    ; r0 will contain the pointer
    ; r0 will exit with the integer

    MOV r1, #0                    		; Initialize r1 = 0. This will hold the integer value

LOAD:
    LDRB r2, [r0]                		; Load byte into r2
    CMP r2, #0x00                		; Compare byte to null byte
    BEQ STOP                    		; If byte is null byte, go to STOP
    MOV r3, #10                    		; load the number 10 so we can multiply it
    MUL r1, r1, r3                		; Multiply integer by 10
    SUB r2, r2, #0x30            		; subtract 0x30 to get the real number instead of ascii number
    ADD r1, r1, r2                		; Add the newest number to the current total
    ADD r0, r0, #0x01            		; Add one to the pointer so we can get the next value
    B LOAD                        		; Go to LOAD and repeat


STOP:
    MOV r0, r1                    		; Move the final integer value to r0

    LDMFD sp!, {lr, r4-r11}
    MOV pc, lr


; Below are helper functions we personally developed for previous lab assignments.

;--------------------------------------------------------print_newline---------------------------------------------------------
print_newline:
	; this function prints a newline, which in reality is a combination of two characters: \n and \r
	STMFD sp!, {lr, r4-r11} ; Registers 4 through 11 need to be preserved

	mov r0, #0xD						 ; print a newline
	BL output_character

	mov r0, #0xa                         ; print a return key
	BL output_character

	LDMFD sp!, {lr, r4-r11}
	MOV pc, lr

;---------------------------------------------------non_interrupt_timer_init---------------------------------------------------
non_interrupt_timer_init:

RCGC_Timer:	.equ	0x604
GPTMCTL:	.equ 	0x00C
GPTMCFG: 	.equ 	0x000
GPTMTAMR: 	.equ 	0x004
GPTMTAILR: 	.equ 	0x028

	; Enable Timer Clock
	mov r1, #0xe000
	movt r1, #0x400f
	mov r0, #1
	strb r0, [r1, #RCGC_Timer]

	; Timer 0 Base Address
	mov r1, #0x0000
	movt r1, #0x4003

	; Disable Timer
	mov r0, #0
	str r0, [r1, #GPTMCTL]

	; Configure as 32-bit
	mov r0, #0
	str r0, [r1, #GPTMCFG]

	; Set to Periodic Mode
	mov r0, #0x12
	str r0, [r1, #GPTMTAMR]

	; Configure as 32-bit
	mov r0, #0
	str r0, [r1, #GPTMCFG]

	; Configure Interval
	mov r0, #0xFFFF
	movt r0, #0xFFFF
	str r0, [r1, #GPTMTAILR]

	; Enable Timer
	mov r0, #1
	str r0, [r1, #GPTMCTL]

	; Return
	mov pc,lr

;-------------------------------------------------------interrupt_init---------------------------------------------------------
interrupt_init:
	STMFD SP!,{r0-r12,lr} 		; Store register lr on stack

	mov r0, #0xC038				; Move the UART0 base address + UARTIM offset
	movt r0, #0x4000
	ldr r1, [r0]				; Load its value
	orr r1, r1, #0x10			; Enable RXIM bit
	str r1, [r0]				; Store the new value

	mov r0, #0xE100				; Move the EN0 base address + EN0 offset
	movt r0, #0xE000
	ldr r1, [r0]				; Load its value
	orr r1, r1, #0x20			; Enable UART0 bit
	str r1, [r0]				; Store the new value

	mov r0, #0x5404
	movt r0, #0x4002
	ldr r1, [r0]
	and r1, r1, #0xEF
	str r1, [r0]

	mov r0, #0x5408
	movt r0, #0x4002
	ldr r1, [r0]
	and r1, r1, #0xEF
	str r1, [r0]

	mov r0, #0x540C
	movt r0, #0x4002
	ldr r1, [r0]
	orr r1, r1, #0x10
	str r1, [r0]

	mov r0, #0x5410
	movt r0, #0x4002
	ldr r1, [r0]
	orr r1, r1, #0x10
	str r1, [r0]

	mov r0, #0xE100
	movt r0, #0xE000
	ldr r1, [r0]
	mov r2, #0x0000
	movt r2, #0x4000
	orr r1, r1, r2
	str r1, [r0]

	LDMFD sp!, {r0-r12,lr}
	MOV pc, lr

;---------------------------------------------------------timer_init-----------------------------------------------------------
timer_init:
    STMFD SP!,{r0-r12,lr}   ; Preserve registers on the stack
    ; Your code is placed here

    ; Connect Clock to Timer
    mov r0, #0xE604
    movt r0, #0x400F
    ldr r1, [r0]
    orr r1, r1, #0x1
    str r1, [r0]

    ; Disable Timer
    mov r0, #0x000C
    movt r0, #0x4003
    ldr r1, [r0]
    mov r2, #0xFFFE
    movt r2, #0xFFFF
    and r1, r1, r2
    str r1, [r0]

    ; Configure as 32-bit
    mov r0, #0x0000
    movt r0, #0x4003
    ldr r1, [r0]
    mov r2, #0xFFF8
    movt r2, #0xFFFF
    and r1, r1, r2
    str r1, [r0]

    ; Set to Periodic Mode
    mov r0, #0x0004
    movt r0, #0x4003
    ldr r1, [r0]
    mov r2, #0xFFFC
    movt r2, #0xFFFF
    and r1, r1, r2
    orr r1, r1, #0x2
    str r1, [r0]

    ; Configure Interval
    mov r0, #0x0028
    movt r0, #0x4003
    ldr r1, [r0]
    mov r2, #0x2400
    movt r2, #0x00F4
    mov r1, r2
    str r1, [r0]

    ; Enable Timer to Interrupt Processor
    mov r0, #0x0018
    movt r0, #0x4003
    ldr r1, [r0]
    orr r1, r1, #0x1
    str r1, [r0]

    ; Configure Processor to allow timer to interrupt
    mov r0, #0xE100
    movt r0, #0xE000
    ldr r1, [r0]
    mov r2, #0x0000
    movt r2, #0x0008
    orr r1, r1, r2
    str r1, [r0]

    ; Enable Timer
    mov r0, #0x000C
    movt r0, #0x4003
    ldr r1, [r0]
    orr r1, r1, #0x1
    str r1, [r0]


    LDMFD sp!, {r0-r12,lr}
    MOV pc, lr

;------------------------------------------------------------------------------------------------------------------------------


	.end
