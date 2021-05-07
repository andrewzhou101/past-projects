	.text
	.global UART0_Handler
	.global Switch_Handler
	.global Timer_Handler
	.global interrupt_init
	.global lab6
	.global gpio_init
	.global uart_init
	.global timer_init
	.global interrupt_init
	.global read_character
	.global illuminate_RGB_LED
	.global output_string
	.global print_newline
	.global output_character
	.global str2int
	.global num_digits
	.global int2str
	.global paused

	.global board1_og
	.global board1_edit
	.global board1_sol
	.global board2_og
	.global board2_edit
	.global board2_sol
	.global board3_og
	.global board3_edit
	.global board3_sol
	.global board4_og
	.global board4_edit
	.global board4_sol
	.global board5_og
	.global board5_edit
	.global board5_sol
	.global board6_og
	.global board6_edit
	.global board6_sol
	.global board7_og
	.global board7_edit
	.global board7_sol
	.global board8_og
	.global board8_edit
	.global board8_sol
	.global board9_og
	.global board9_edit
	.global board9_sol
	.global board10_og
	.global board10_edit
	.global board10_sol
	.global board11_og
	.global board11_edit
	.global board11_sol
	.global board12_og
	.global board12_edit
	.global board12_sol
	.global board13_og
	.global board13_edit
	.global board13_sol
	.global board14_og
	.global board14_edit
	.global board14_sol
	.global board15_og
	.global board15_edit
	.global board15_sol
	.global board16_og
	.global board16_edit
	.global board16_sol

	.data
; Hard Coded Prompts to print for User
prompt_space:		.string "Please press space bar to begin.",0
clear:				.string 27,"[2J",27,"[0;0H",0
paused: 			.string "The game is currently PAUSED.", 0xA, 0xD
					.string "The timer has been stopped and your player is unable to move.", 0xA, 0xD
		   			.string "From here, you can do multiple actions. Please press one of the below buttons.", 0xA, 0xD, 0xB
	       			.string "r - Resumes the game, exactly as you last left it.", 0xA, 0xD, 0xB
	       			.string "t - Restart the game using the same board.", 0xA, 0xD, 0xB
	       			.string "g - Start a new game using using a different board.", 0xA, 0xD, 0xB
	       			.string "q - Quits the game.", 0xA, 0xD, 0x0
quitted:    		.string "You have exited the game.", 0xA, 0xD, 0xB
					.string "To play again, please restart the program in Code Composer Studio.", 0xA, 0xD, 0xB
					.string "Thanks for playing!", 0xA, 0xD, 0x0
congrats:			.string "Congratulations! You've succesfully completed the game.", 0xA, 0xD, 0xB
					.string "If you want to play again, press g.", 0xA, 0xD, 0xB
					.string "If you are done playing, press q to quit.", 0xA, 0xD, 0xB
					.string "Thank you for playing!", 0xA, 0xD, 0x0
the_time:			.string "0000",0
choose_board:		.string 0,0,0,0			; 1st character represents board chosen (DYNAMIC, ALWAYS CHANGING). 2nd character represents what color we are drawing. 0 means none.
											; Third character is a method for UART to print the board.
first_o:			.string 9,9,0			; Stores the x and y coordinates of the current o being drawn
completion:			.string "0",0

; define the colors
red:				.string 27,"[31mO",0		; 1
green:				.string 27,"[32mO",0		; 2
yellow:				.string 27,"[33mO",0		; 3
blue:				.string 27,"[34mO",0		; 4
magenta:			.string 27,"[35mO",0		; 5
cyan:				.string 27,"[36mO",0		; 6
white:				.string 27,"[37mO",0		; 7

red_pipe:			.string 27,"[31m|",0		; ?
green_pipe:			.string 27,"[32m|",0		; @
yellow_pipe:		.string 27,"[33m|",0		; A
blue_pipe:			.string 27,"[34m|",0		; B
magenta_pipe:		.string 27,"[35m|",0		; C
cyan_pipe:			.string 27,"[36m|",0		; D
white_pipe:			.string 27,"[37m|",0		; E

red_dash:			.string 27,"[31m-",0		; F
green_dash:			.string 27,"[32m-",0		; G
yellow_dash:		.string 27,"[33m-",0		; H
blue_dash:			.string 27,"[34m-",0		; I
magenta_dash:		.string 27,"[35m-",0		; J
cyan_dash:			.string 27,"[36m-",0		; K
white_dash:			.string 27,"[37m-",0		; L

red_corner:			.string 27,"[31m+",0		; M
green_corner:		.string 27,"[32m+",0		; N
yellow_corner:		.string 27,"[33m+",0		; O
blue_corner:		.string 27,"[34m+",0		; P
magenta_corner:		.string 27,"[35m+",0		; Q
cyan_corner:		.string 27,"[36m+",0		; R
white_corner:		.string 27,"[37m+",0		; S

; define the cursor strings
hide: 				.string 27,"[?25l",0
show:				.string 27,"[?25h",0
top_left:			.string 27,"[1;1H",0
start:				.string 27,"[4;2H",0
move_up: 			.string 27,"[1A",0
move_down:			.string 27,"[1B",0
move_left:			.string 27,"[1D",0
move_right:			.string 27,"[1C",0
save:				.string 27,"[s",0
restore:			.string 27,"[u",0
info:				.string "0000",0 	; x and y coordinates, in addition to the current board being used and the PREVIOUS pause condition
pause:				.string "c",1,0		; Corresponds to what the Handlers are asking for. c = creating board. n = nothing. p = paused. q = quit game. r = resume game. t = restart game. g = new game.
										; Second character in pause represents current board (0 - 15). USE THIS BOARD NUMBER, IT IS STATIC

timer_start:		.string 27,"[2;7H",0
timer_temp:			.string 27,"[37m0",0
uart_horizontal_temp:.string 27,"[30m-",0	; Change 4th character for color.
uart_vertical_temp:	.string 27,"[30m|",0	; Change 4th character for color
uart_corner_temp:	.string 27,"[30m+",0	; Change 4th character for color
completion_start:	.string 27,"[1;12H",0
completion_temp:	.string 27,"[37m0",0

	.text
lab6:
	STMFD SP!,{r0-r12,lr} ; Store register lr on stack

new_game:
	; Set first character of "pause" to "c" to represent that the board is being created
	ldr r0, ptr_to_pause
	mov r1, #0x63
	strb r1, [r0]

	; Reset x/y values in "info" to '0'
	ldr r0, ptr_to_info
	mov r1, #0x30
	strb r1, [r0]
	strb r1, [r0, #1]

	; Initialize GPIO, UART, Timer and Interrupts
	BL gpio_init
	BL uart_init
	BL interrupt_init
	BL new_timer_init

	ldr r0, ptr_to_white
	BL output_string			; Default color to white so that all printed strings are white.

	ldr r0, ptr_to_clear
	BL output_string			; Clear screen

	ldr r0, ptr_to_hide
	BL output_string			; Hide Cursor

	ldr r0, ptr_to_prompt_space
	BL output_string			; Print prompt to ask User to press Space to start game

start_game_loop:
	; Loop until User presses space
	BL read_character
	cmp r0, #0x20
	BNE start_game_loop

	ldr r0, ptr_to_clear
	BL output_string			; Clear screen

	ldr r1, ptr_to_choose_board
	ldrb r0, [r1]					; Grab current choose_board character

	ldr r7, ptr_to_pause
	strb r0, [r7,#1]				; Changes the second character in r7 to the board number

	; Store the board number as the 3rd character of "info"
	mov r1, #0x30
	add r1, r1, r0
	ldr r2, ptr_to_info
	strb r1, [r2, #2]

	mov r10, #0x0

; These are the "og" boards, or the unedited boards that the game should start with.
; r0 already contains the board number, so this code branches according to what r0 is.
print_board_og:
	ldr r4, ptr_to_board1_og
	cmp r0, #0
	BEQ initial_board_printed

	ldr r4, ptr_to_board2_og
	cmp r0, #1
	BEQ initial_board_printed

	ldr r4, ptr_to_board3_og
	cmp r0, #2
	BEQ initial_board_printed

	ldr r4, ptr_to_board4_og
	cmp r0, #3
	BEQ initial_board_printed

	ldr r4, ptr_to_board5_og
	cmp r0, #4
	BEQ initial_board_printed

	ldr r4, ptr_to_board6_og
	cmp r0, #5
	BEQ initial_board_printed

	ldr r4, ptr_to_board7_og
	cmp r0, #6
	BEQ initial_board_printed

	ldr r4, ptr_to_board8_og
	cmp r0, #7
	BEQ initial_board_printed

	ldr r4, ptr_to_board9_og
	cmp r0, #8
	BEQ initial_board_printed

	ldr r4, ptr_to_board10_og
	cmp r0, #9
	BEQ initial_board_printed

	ldr r4, ptr_to_board11_og
	cmp r0, #10
	BEQ initial_board_printed

	ldr r4, ptr_to_board12_og
	cmp r0, #11
	BEQ initial_board_printed

	ldr r4, ptr_to_board13_og
	cmp r0, #12
	BEQ initial_board_printed

	ldr r4, ptr_to_board14_og
	cmp r0, #13
	BEQ initial_board_printed

	ldr r4, ptr_to_board15_og
	cmp r0, #14
	BEQ initial_board_printed

	ldr r4, ptr_to_board16_og
	cmp r0, #15

; Similar to the print_board_og. This is called if we are resuming a game and need to print the already edited board.
print_board_edit:
	ldr r4, ptr_to_board1_edit
	cmp r0, #0
	BEQ initial_board_printed

	ldr r4, ptr_to_board2_edit
	cmp r0, #1
	BEQ initial_board_printed

	ldr r4, ptr_to_board3_edit
	cmp r0, #2
	BEQ initial_board_printed

	ldr r4, ptr_to_board4_edit
	cmp r0, #3
	BEQ initial_board_printed

	ldr r4, ptr_to_board5_edit
	cmp r0, #4
	BEQ initial_board_printed

	ldr r4, ptr_to_board6_edit
	cmp r0, #5
	BEQ initial_board_printed

	ldr r4, ptr_to_board7_edit
	cmp r0, #6
	BEQ initial_board_printed

	ldr r4, ptr_to_board8_edit
	cmp r0, #7
	BEQ initial_board_printed

	ldr r4, ptr_to_board9_edit
	cmp r0, #8
	BEQ initial_board_printed

	ldr r4, ptr_to_board10_edit
	cmp r0, #9
	BEQ initial_board_printed

	ldr r4, ptr_to_board11_edit
	cmp r0, #10
	BEQ initial_board_printed

	ldr r4, ptr_to_board12_edit
	cmp r0, #11
	BEQ initial_board_printed

	ldr r4, ptr_to_board13_edit
	cmp r0, #12
	BEQ initial_board_printed

	ldr r4, ptr_to_board14_edit
	cmp r0, #13
	BEQ initial_board_printed

	ldr r4, ptr_to_board15_edit
	cmp r0, #14
	BEQ initial_board_printed

	ldr r4, ptr_to_board16_edit
	cmp r0, #15

	; Reach first character in string "board"
	; Code to print board is here.
initial_board_printed:
	ldr r0, ptr_to_show
	BL output_string		; Reveal cursor

	CMP r10, #0x1			; Check r10 to decide if we need to reset the timer. It will be 1 if we are resuming a game.
	BEQ resume_board_print

	ldr r7, ptr_to_the_time
	mov r8, #0x30
	strb r8, [r7,#0]
	strb r8, [r7,#1]
	strb r8, [r7,#2]
	strb r8, [r7,#3]		; Restore timer to '0000'

resume_board_print:
	mov r10, #0x0

	; Print the edited board.
	mov r0, r4
	BL output_string
	add r4, r4, #40

	mov r5, #0				; represents x value
	mov r6, #0				; represents y value

	; Go to beginning of grid and save position
	ldr r0, ptr_to_hide
	BL output_string
	ldr r0, ptr_to_start
	BL output_string
	ldr r0, ptr_to_save
	BL output_string

; Print character depending on number stored
; Prints all the colored O's
print_char:
	ldrb r0, [r4]

	; Print the Os
	cmp r0, #0x31
	BEQ print_red
	cmp r0, #0x32
	BEQ print_green
	cmp r0, #0x33
	BEQ print_yellow
	cmp r0, #0x34
	BEQ print_blue
	cmp r0, #0x35
	BEQ print_magenta
	cmp r0, #0x36
	BEQ print_cyan
	cmp r0, #0x37
	BEQ print_white

	; Print the pipes
	cmp r0, #0x3F
	BEQ print_red_pipe
	cmp r0, #0x40
	BEQ print_green_pipe
	cmp r0, #0x41
	BEQ print_yellow_pipe
	cmp r0, #0x42
	BEQ print_blue_pipe
	cmp r0, #0x43
	BEQ print_magenta_pipe
	cmp r0, #0x44
	BEQ print_cyan_pipe
	cmp r0, #0x45
	BEQ print_white_pipe

	; Print the dashes
	cmp r0, #0x46
	BEQ print_red_dash
	cmp r0, #0x47
	BEQ print_green_dash
	cmp r0, #0x48
	BEQ print_yellow_dash
	cmp r0, #0x49
	BEQ print_blue_dash
	cmp r0, #0x4A
	BEQ print_magenta_dash
	cmp r0, #0x4B
	BEQ print_cyan_dash
	cmp r0, #0x4C
	BEQ print_white_dash

	; Print the corners
	cmp r0, #0x4D
	BEQ print_red_corner
	cmp r0, #0x4E
	BEQ print_green_corner
	cmp r0, #0x4F
	BEQ print_yellow_corner
	cmp r0, #0x50
	BEQ print_blue_corner
	cmp r0, #0x51
	BEQ print_magenta_corner
	cmp r0, #0x52
	BEQ print_cyan_corner
	cmp r0, #0x53
	BEQ print_white_corner

next_char:
	cmp r5, #7
	BNE forwards				; if x != 7, go forward 1
	cmp r6, #7
	BNE downs					; if y != 7, go to down to next row

chars_done:
	ldr r0, ptr_to_start
	BL output_string

	ldr r0, ptr_to_pause
	mov r1, #0x6E
	strb r1, [r0]				; Set pause string to n

	; restore 0 for x and 0 for y
	mov r5, #0
	mov r6, #0

	; load pointer to pause
	ldr r7, ptr_to_info ; r7 = pointer to pause info
	ldrb r8, [r7] 		; r8 = pointer to previous x coordinate
	sub r8, r8, #0x30	; convert r8 to an integer
	ldrb r9, [r7, #1]   ; r9 = pointer to previous y coordinate
	sub r9, r9, #0x30   ; convert r9 to an integer

restore_x:
	CMP r5, r8			 ; compare current x coordinate to previous x coordinate
	BEQ restore_y

	add r5, r5, #1

	ldr r0, ptr_to_right
	BL output_string

	B restore_x

restore_y:
	CMP r6, r9			 ; compare current y coordinate to previous y coordinate
	BEQ print_completion

	add r6, r6, #1

	ldr r0, ptr_to_down
	BL output_string

	B restore_y

print_completion:
	ldr r5, ptr_to_completion
	ldrb r6, [r5]				; Load 1st digit of the completion

	ldr r5, ptr_to_completion_temp
	strb r6, [r5, #5]			; Edit completion_temp to reflect digit

	ldr r0, ptr_to_save			; Save position before completion is printed
	BL output_string
	ldr r0, ptr_to_completion_start	; Point cursor at where the completion is printed
	BL output_string
	ldr r0, ptr_to_completion_temp	; Print completion number
	BL output_string
	ldr r0, ptr_to_restore		; Return cursor to previous location
	BL output_string
	ldr r0, ptr_to_show
	BL output_string			; Reveal Cursor

; This is the loop that runs when the game is being played.
infinite_loop:
	; Check if we need to reprint the board due to a change from pressing space on a O or intersecting lines.
	ldr r0, ptr_to_choose_board
	ldrb r1, [r0, #2]
	CMP r1, #1
	BEQ resume_game

	; Check if the completion has reached 7. This would mean the game is completed. We would then branch to completed_game.
	ldr r0, ptr_to_completion
	ldrb r1, [r0]
	cmp r1, #0x37
	BEQ completed_game

	; Check if "pause" has been set to "q". If it has, quit the game.
	ldr r0, ptr_to_pause
	ldrb r1, [r0]
	cmp r1, #0x71
	BEQ quit_game

	; Check if "pause" has been set to "n". If it has, continue looping. Otherwise, exit the loop.
	cmp r1, #0x6E
	BEQ infinite_loop

	ldr r0, ptr_to_white
	BL output_string			; Default color to white so that all printed strings are white.
	ldr r0, ptr_to_clear
	BL output_string			; Clear screen

	; Print prompt stating the game is paused, and what inputs are accepted to exit the paused state.
	ldr r0, ptr_to_paused
	BL output_string

pause_loop:
	ldr r0, ptr_to_hide
	BL output_string			; Hide cursor

	; Load the first character in "pause" into r1
	ldr r0, ptr_to_pause
	ldrb r1, [r0]

	cmp r1, #0x71
	BEQ quit_game	; If character is q, quit game

	cmp r1, #0x72
	BEQ resume_game	; If character is r, resume game

	cmp r1, #0x74
	BEQ restart_game	; If character is t, restart game

	cmp r1, #0x67
	BEQ start_new_game	; If character is g, get new board.

	B pause_loop		; Loop if none of the above is true, which suggests that we are still paused.

completed_game:
	ldr r0, ptr_to_white
	BL output_string			; Default color to white so that all printed strings are white.
	ldr r0, ptr_to_clear
	BL output_string			; Clear screen
	ldr r0, ptr_to_congrats
	BL output_string			; Print prompt stating that the game has been beaten. Describes functionality to restart game or quit.

	; Sets "pause" to "p" since this will be similar to the pause state, except some inputs are disabled.
	ldr r0, ptr_to_pause
	mov r1, #0x70
	strb r1, [r0]

completed_game_loop:
	ldr r0, ptr_to_hide
	BL output_string			; Hide Cursor

	ldr r0, ptr_to_pause
	ldrb r1, [r0]				; Load first character in "pause" into r1

	cmp r1, #0x71
	BEQ quit_game	; If character is q, quit game

	cmp r1, #0x67
	BEQ start_new_game	; If character is g, get new board.

	B completed_game_loop	; If none of the above branch, keep looping.

resume_game:
	ldr r0, ptr_to_white
	BL output_string			; Default color to white so that all printed strings are white.

	; clear the board
	ldr r0, ptr_to_clear
	BL output_string

	; reset pointer to choose board (this does nothing if ptr_to_choose_board's third character isn't a 1)
	mov r0, #0
	ldr r1, ptr_to_choose_board
	strb r0, [r1, #2]

	; change the status of the board to 'n'
	ldr r0, ptr_to_pause
	mov r1, #0x6E
	strb r1, [r0]

	; load the board number
	ldr r0, ptr_to_info
	ldrb r1, [r0, #2]
	sub r1, #0x30

	; tell the program we must restore the timer
	mov r10, #0x1

	; move the board number into r0
	mov r0, r1

	; print the board
	BL print_board_edit

restart_game:
	; clear the board
	ldr r0, ptr_to_clear
	BL output_string

	; Reset the values of "first_o" to 9.
	mov r0, #9
	ldr r1, ptr_to_first_o
	STRB r0, [r1]
	STRB r0, [r1, #1]

	; Reset the completion status.
	ldr r0, ptr_to_completion
	mov r1,	#0x30
	strb r1, [r0]

	; change the status of the board to 'n'
	ldr r0, ptr_to_pause
	mov r1, #0x6E
	strb r1, [r0]

	ldr r0, ptr_to_info
	mov r1, #0x30
	strb r1, [r0] ; reset x coordinate
	strb r1, [r0, #1] ; reset y coordinate
	ldrb r0, [r0, #2] ; load the board number
	sub r0, #0x30

	BL delete_edit ; reset the edited board
	B print_board_og ; print the original board

start_new_game:
	; Reset the values of "first_o" to 9
	mov r0, #9
	ldr r1, ptr_to_first_o
	STRB r0, [r1]
	STRB r0, [r1, #1]

	; Reset the completion status.
	ldr r0, ptr_to_completion
	mov r1,	#0x30
	strb r1, [r0]

	BL delete_edit ; reset the edited board
	B new_game ; print a new board

quit_game:
	ldr r0, ptr_to_clear
	BL output_string			; Clear screen

	ldr r0, ptr_to_quitted
	BL output_string			; Print prompt stating that the game has been shut down.

	LDMFD sp!, {r0-r12,lr}
	MOV pc, lr

; this is a function to reset the edited board
; it is only accessed when the player either restarts the game or begins a new game
delete_edit:
	STMFD SP!,{r0-r12,lr}

	; Reset color being drawn
	mov r0, #0
	ldr r1, ptr_to_choose_board
	strb r0, [r1, #1]

	mov r0, #0
	BL illuminate_RGB_LED

	; load the board number
	ldr r1, ptr_to_info
	ldrb r0, [r1, #2]
	sub r0, #0x30

	mov r2, #0 ; starts at 0, ends at 128 (the number of characters in a board)

	; Branch depending on which board needs to be deleted.
	cmp r0, #0
	BEQ delete_board1

	cmp r0, #1
	BEQ delete_board2

	cmp r0, #2
	BEQ delete_board3

	cmp r0, #3
	BEQ delete_board4

	cmp r0, #4
	BEQ delete_board5

	cmp r0, #5
	BEQ delete_board6

	cmp r0, #6
	BEQ delete_board7

	cmp r0, #7
	BEQ delete_board8

	cmp r0, #8
	BEQ delete_board9

	cmp r0, #9
	BEQ delete_board10

	cmp r0, #10
	BEQ delete_board11

	cmp r0, #11
	BEQ delete_board12

	cmp r0, #12
	BEQ delete_board13

	cmp r0, #13
	BEQ delete_board14

	cmp r0, #14
	BEQ delete_board15

	cmp r0, #15
	BEQ delete_board16

; Delete the corresponding board.
delete_board1:
	ldr r0, ptr_to_board1_og
	ldr r1, ptr_to_board1_edit
	B delete_continue

delete_board2:
	ldr r0, ptr_to_board2_og
	ldr r1, ptr_to_board2_edit
	B delete_continue

delete_board3:
	ldr r0, ptr_to_board3_og
	ldr r1, ptr_to_board3_edit
	B delete_continue

delete_board4:
	ldr r0, ptr_to_board4_og
	ldr r1, ptr_to_board4_edit
	B delete_continue

delete_board5:
	ldr r0, ptr_to_board5_og
	ldr r1, ptr_to_board5_edit
	B delete_continue

delete_board6:
	ldr r0, ptr_to_board6_og
	ldr r1, ptr_to_board6_edit
	B delete_continue

delete_board7:
	ldr r0, ptr_to_board7_og
	ldr r1, ptr_to_board7_edit
	B delete_continue

delete_board8:
	ldr r0, ptr_to_board8_og
	ldr r1, ptr_to_board8_edit
	B delete_continue

delete_board9:
	ldr r0, ptr_to_board9_og
	ldr r1, ptr_to_board9_edit
	B delete_continue

delete_board10:
	ldr r0, ptr_to_board10_og
	ldr r1, ptr_to_board10_edit
	B delete_continue

delete_board11:
	ldr r0, ptr_to_board11_og
	ldr r1, ptr_to_board11_edit
	B delete_continue

delete_board12:
	ldr r0, ptr_to_board12_og
	ldr r1, ptr_to_board12_edit
	B delete_continue

delete_board13:
	ldr r0, ptr_to_board13_og
	ldr r1, ptr_to_board13_edit
	B delete_continue

delete_board14:
	ldr r0, ptr_to_board14_og
	ldr r1, ptr_to_board14_edit
	B delete_continue

delete_board15:
	ldr r0, ptr_to_board15_og
	ldr r1, ptr_to_board15_edit
	B delete_continue

delete_board16:
	ldr r0, ptr_to_board16_og
	ldr r1, ptr_to_board16_edit

delete_continue:
	ldrb r3, [r0, r2] ; load this character into r2

	strb r3, [r1, r2]  ; load the original character into r1

	; add one to r2 and compare to 128, if this fails redo this loop
	add r2, r2, #1
	cmp r2, #0x80
	BNE delete_continue

	LDMFD sp!, {r0-r12, lr}
	MOV pc, lr


UART0_Handler:
	STMFD SP!,{r0-r12,lr} 	; Store register lr on stack

	mov r0, #0xC044			; Load the UART0 base address + UARTICR offset
	movt r0, #0x4000

	; Show that the exception is being handled.
	ldr r1, [r0]
	orr r1, r1, #0x10
	str r1, [r0]

	ldr r0, ptr_to_pause
	ldrb r1, [r0]					; Load first character of "pause" into r1
	cmp r1, #0x70
	BEQ uart_pause_conditions		; If paused, go to uart_pause_conditions

	cmp r1, #0x6E
	BEQ uart_game					; If game is running normally, go to uart_game

	B uart_exit

uart_pause_conditions:
	mov r1, #0xC000         ; Load bottom 16 bits to Data Register
    movt r1, #0x4000        ; Load top 16 bits to Data Register
    LDRB r0, [r1]

	cmp r0, #0x71
	BEQ uart_store_char		; If character is 'q', branch
	cmp r0, #0x74
	BEQ uart_store_char		; If character is 't', branch
	cmp r0, #0x72
	BEQ uart_store_char		; If character is 'r', branch
	cmp r0, #0x67
	BEQ uart_store_char		; If character is 'g', branch
	B uart_exit

uart_store_char:
	; Store the character in r0 as the first character of "pause"
    ldr r2, ptr_to_pause
    strb r0, [r2]
    B uart_exit

uart_game:
	ldr r1, ptr_to_pause
	ldrb r0, [r1, #1]						; Set r0 to the board number

	; Set r4 to the board string and go to uart_board_found
	; This code simply sets r4 to the pointer of the correct board.
	ldr r4, ptr_to_board1_edit
	cmp r0, #0
	BEQ uart_board_found

	ldr r4, ptr_to_board2_edit
	cmp r0, #1
	BEQ uart_board_found

	ldr r4, ptr_to_board3_edit
	cmp r0, #2
	BEQ uart_board_found

	ldr r4, ptr_to_board4_edit
	cmp r0, #3
	BEQ uart_board_found

	ldr r4, ptr_to_board5_edit
	cmp r0, #4
	BEQ uart_board_found

	ldr r4, ptr_to_board6_edit
	cmp r0, #5
	BEQ uart_board_found

	ldr r4, ptr_to_board7_edit
	cmp r0, #6
	BEQ uart_board_found

	ldr r4, ptr_to_board8_edit
	cmp r0, #7
	BEQ uart_board_found

	ldr r4, ptr_to_board9_edit
	cmp r0, #8
	BEQ uart_board_found

	ldr r4, ptr_to_board10_edit
	cmp r0, #9
	BEQ uart_board_found

	ldr r4, ptr_to_board11_edit
	cmp r0, #10
	BEQ uart_board_found

	ldr r4, ptr_to_board12_edit
	cmp r0, #11
	BEQ uart_board_found

	ldr r4, ptr_to_board13_edit
	cmp r0, #12
	BEQ uart_board_found

	ldr r4, ptr_to_board14_edit
	cmp r0, #13
	BEQ uart_board_found

	ldr r4, ptr_to_board15_edit
	cmp r0, #14
	BEQ uart_board_found

	ldr r4, ptr_to_board16_edit
	cmp r0, #15

uart_board_found:
	mov r12, r4						; Store board string in r12

	ldr r0, ptr_to_choose_board
	ldrb r11, [r0,#1]				; Load current color in r11

	mov r0, r11
	BL illuminate_RGB_LED			; Set LED to current color

	mov r10, #0						; Set r10 = 0

    mov r1, #0xC000         ; Load bottom 16 bits to Data Register
    movt r1, #0x4000        ; Load top 16 bits to Data Register
    LDRB r0, [r1]

	ldr r2, ptr_to_info

	ldrb r3, [r2, #0] ; load x into r1
	sub r3, #0x30	  ; convert into integer

	ldrb r4, [r2, #1] ; load y into r2
	sub r4, #0x30     ; convert into integer

	mov r6, r12			; Grab the board string and put it in r6

	add r6, r6, #40		; Makes sure we point at the beginning of the board where x = 0 and y = 0

	mov r7, r3			; r7 = x
	mov r8, r4			; r8 = y

	mov r9, #0xB		; Store the number of characters in each row of the string.
	mul r9, r8, r9		; Multiple rows by characters in rows
	add r6, r6, r9		; Add r6 to r0 to get to the correct row
	add r6, r6, r7		; Add the x value to get the correct value in the row

	mov r9, #0			; This will be the color of the next O, if there is one.

uart_movement:
	; if up, move the cursor up
    cmp r0, #0x77
    BEQ up

    ; if down, move the cursor down
   	CMP r0, #0x73
   	BEQ down

   	; if left, move the cursor left
   	CMP r0, #0x61
   	BEQ left

   	; if right, move the cursor right
   	CMP r0, #0x64
   	BEQ right

   	; if q, then quit
   	CMP r0, #0x71
   	BEQ uart_quit_game

   	; if space, then decide if the character is an O. Then act accordingly.
   	CMP r0, #0x20
   	BEQ uart_space

   	; if not w, z, a, s, or q exit
   	B uart_exit

overlap:
	LDMFD  sp!, {r0-r8}
	B uart_exit

up:
	; move up and compare to -1
	sub r4, r4, #1
	CMP r4, #-1

	; if it is -1, this movement is illegal; exit immediately
	BEQ uart_exit

	; If the next character is O, go to up_has_O
	sub r6, r6, #0xB
	ldrb r0, [r6]
	sub r0, r0, #0x30
	cmp r0, #0x1
	BEQ up_has_O
	cmp r0, #0x2
	BEQ up_has_O
	cmp r0, #0x3
	BEQ up_has_O
	cmp r0, #0x4
	BEQ up_has_O
	cmp r0, #0x5
	BEQ up_has_O
	cmp r0, #0x6
	BEQ up_has_O
	cmp r0, #0x7
	BEQ up_has_O
	B up_allow_move

up_has_O:
	STMFD sp!, {r0-r8}

	; Load x/y coordinates of "first_o"
	ldr r9, ptr_to_first_o
	LDRB r0, [r9]
	LDRB r1, [r9, #1]

	; If the coordinates match, go to overlap
	CMP r0, r3
	BNE overlap_exit_up
	CMP r1, r4
	BNE overlap_exit_up
	B overlap

overlap_exit_up:
	LDMFD sp!, {r0-r8}

	mov r9, r0

	; If we have a color
	cmp r11, #0
	BEQ up_allow_move

	; Only allow move if color matches
	cmp r11, r9
	BEQ up_clear

	; otherwise, exit.
	B uart_exit

up_clear:		; Clear the color chosen so that we stop drawing.
	ldr r0, ptr_to_choose_board
	mov r1, #0
	strb r1, [r0, #1]

	; Disable color on LED
	mov r0, #0
	BL illuminate_RGB_LED

	ldr r5, ptr_to_completion
	ldrb r6, [r5]				; Load 1st digit of the completion
	add r6, r6, #0x1			; Add one to represent 1 line being completed
	strb r6, [r5]				; Store the new completion number back into the string

	ldr r5, ptr_to_completion_temp
	strb r6, [r5, #5]			; Edit completion_temp to reflect digit

	ldr r0, ptr_to_save			; Save position before completion is printed
	BL output_string
	ldr r0, ptr_to_hide			; Hide the cursor
	BL output_string
	ldr r0, ptr_to_completion_start	; Point cursor at where the completion is printed
	BL output_string
	ldr r0, ptr_to_completion_temp	; Print completion number
	BL output_string
	ldr r0, ptr_to_restore		; Return cursor to previous location
	BL output_string
	ldr r0, ptr_to_show 		; Show the cursor
	BL output_string

	; Reset coordinates of "first_o" to 9
	mov r0, #9
	ldr r1, ptr_to_first_o
	STRB r0, [r1]
	STRB r0, [r1, #1]

up_allow_move:
	; The color is stored in r11 as an integer
	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r4, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r3		; Add the x value to get the correct value in the row

	LDRB r2, [r1]
	mov r10, r2

	cmp r11, #0
	BEQ up_allow_move_2

	; Check to make sure we don't overwrite current color (vertical, horizontal and corner)
	add r5, r11, #62
	CMP r5, r2
	BEQ uart_exit
	add r5, r5, #7
	CMP r5, r2
	BEQ uart_exit
	add r5, r5, #7
	CMP r5, r2
	BEQ uart_exit

up_allow_move_2:
	ldr r2, ptr_to_info

	; if it isn't, store the new y-coordinate and allow the movement
	add r4, r4, #0x30
	strb r4, [r2, #1]

	ldr r0, ptr_to_up
	BL output_string		; Move cursor up

	cmp r11, #0
	BEQ uart_exit			; Run code below this if a color is chosen.

	add r11, r11, #0x30		; Turn number of color into ascii number

	cmp r9, #0				; If next character is an O
	BNE up_corner			; Exit. Otherwise, run code to write lines.

	; Check if we are overwriting other lines
	cmp r10, #0x3F
	BLT uart_up_no_overlap
	cmp r10, #0x53
	BGT uart_up_no_overlap

	mov r5, #0

	; Check if we are overwriting a pipe
	cmp r10, #0x45
	BLE up_check_pipe

	; Check if we are overwriting a dash
	cmp r10, #0x4C
	BLE up_check_dash

	; Check if we are overwriting a corner
	cmp r10, #0x53
	BLE up_check_corner

; Edit registers to prepare a call to second_space
up_check_pipe:
	mov r6, r10
	add r7, r6, #7
	add r8, r7, #7
	B up_check_overwrite

; Edit registers to prepare a call to second_space
up_check_dash:
	mov r7, r10
	sub r6, r7, #7
	add r8, r7, #7
	B up_check_overwrite

; Edit registers to prepare a call to second_space
up_check_corner:
	mov r8, r10
	sub r7, r8, #7
	sub r6, r7, #7
	B up_check_overwrite

up_check_overwrite:
	BL second_space				; Call second_space to clear board of a specific color

	; Lower completion by 1
	ldr r0, ptr_to_completion
	ldrb r1, [r0]
	sub r1, r1, #1
	strb r1, [r0]

	; Edit the 3rd character of "choose_board" to show that the board needs to be reprinted.
	mov r1, #1
	ldr r2, ptr_to_choose_board
	STRB r1, [r2, #2]

uart_up_no_overlap:
	ldr r0, ptr_to_uart_vertical_temp
	strb r11, [r0, #3]
	BL output_string					; Output the line

	ldr r0, ptr_to_left
	BL output_string					; Return pointer to original location

	; HERE WE NEED TO EDIT THE BOARD
	; At this point in time, r11 is the color 1-7

	ldr r0, ptr_to_info

	mov r1, r12 ; r1 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	ldrb r2, [r0, #0] ; load x into r2
	sub r2, #0x30	  ; convert into integer

	ldrb r3, [r0, #1] ; load y into r3
	sub r3, #0x30     ; convert into integer

	mov r4, r11
	add r4, r4, #0xE  ; convert into a vertical pipe

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r3, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r2		; Add the x value to get the correct value in the row

	STRB r4, [r1]

	add r1, r1, #0xB       ; move the pointer one full line down

	add r4, r4, #7 ; convert r4 to a horizontal pipe
	ldrb r2, [r1]
	cmp r2, r4
	BNE uart_exit

	mov r4, r11
	add r4, r4, #28
	STRB r4, [r1]

	ldr r0, ptr_to_down
	BL output_string			; Move cursor down

	ldr r0, ptr_to_uart_corner_temp
	STRB r11, [r0, #3]			; Edit corner color
	BL output_string			; Print corner

	ldr r0, ptr_to_left
	BL output_string			; Move cursor left

	ldr r0, ptr_to_up
	BL output_string			; Move cursor up

	B uart_exit

up_corner:
	ldr r0, ptr_to_info

	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	ldrb r2, [r0, #0] ; load x into r2
	sub r2, #0x30	  ; convert into integer

	ldrb r3, [r0, #1] ; load y into r3
	sub r3, #0x30     ; convert into integer

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r3, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r2		; Add the x value to get the correct value in the row

	add r1, r1, #0xB       ; move the pointer one full line down

	mov r4, r11
	add r4, r4, #0xE  ; convert into a vertical pipe
	ldrb r2, [r1]
	cmp r2, r4
	BEQ uart_exit

	mov r4, r11
	add r4, r4, #28
	STRB r4, [r1]

	ldr r0, ptr_to_down
	BL output_string			; Move cursor down

	ldr r0, ptr_to_uart_corner_temp
	STRB r11, [r0, #3]			; Edit corner color
	BL output_string			; Print corner

	ldr r0, ptr_to_left
	BL output_string			; Move cursor left

	ldr r0, ptr_to_up
	BL output_string			; Move cursor up

	B uart_exit

down:
	; move down and compare to 7
	add r4, r4, #1
	CMP r4, #7

	; if it is 7, this movement is illegal; exit immediately
	BEQ uart_exit

	; If the next character is O
	add r6, r6, #0xB
	ldrb r0, [r6]
	sub r0, r0, #0x30
	cmp r0, #0x1
	BEQ down_has_O
	cmp r0, #0x2
	BEQ down_has_O
	cmp r0, #0x3
	BEQ down_has_O
	cmp r0, #0x4
	BEQ down_has_O
	cmp r0, #0x5
	BEQ down_has_O
	cmp r0, #0x6
	BEQ down_has_O
	cmp r0, #0x7
	BEQ down_has_O
	B down_allow_move

down_has_O:
	STMFD sp!, {r0-r8}

	ldr r9, ptr_to_first_o
	LDRB r0, [r9]
	LDRB r1, [r9, #1]

	CMP r0, r3
	BNE overlap_exit_down
	CMP r1, r4
	BNE overlap_exit_down
	B overlap

overlap_exit_down:
	LDMFD sp!, {r0-r8}

	mov r9, r0

	; If we have a color
	cmp r11, #0
	BEQ down_allow_move

	; Only allow move if color matches
	cmp r11, r9
	BEQ down_clear

	; otherwise, exit.
	B uart_exit

down_clear:		; Clear the color chosen so that we stop drawing.
	ldr r0, ptr_to_choose_board
	mov r1, #0
	strb r1, [r0, #1]

	mov r0, #0
	BL illuminate_RGB_LED

	ldr r5, ptr_to_completion
	ldrb r6, [r5]				; Load 1st digit of the completion
	add r6, r6, #0x1			; Add one to represent 1 line being completed
	strb r6, [r5]				; Store the new completion number back into the string

	ldr r5, ptr_to_completion_temp
	strb r6, [r5, #5]			; Edit completion_temp to reflect digit

	ldr r0, ptr_to_save			; Save position before completion is printed
	BL output_string
	ldr r0, ptr_to_hide			; Hide the cursor
	BL output_string
	ldr r0, ptr_to_completion_start	; Point cursor at where the completion is printed
	BL output_string
	ldr r0, ptr_to_completion_temp	; Print completion number
	BL output_string
	ldr r0, ptr_to_restore		; Return cursor to previous location
	BL output_string
	ldr r0, ptr_to_show 		; Show the cursor
	BL output_string

	mov r0, #9
	ldr r1, ptr_to_first_o
	STRB r0, [r1]
	STRB r0, [r1, #1]

down_allow_move:
	; The color is stored in r11 as an integer
	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r4, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r3		; Add the x value to get the correct value in the row

	LDRB r2, [r1]
	mov r10, r2

	cmp r11, #0
	BEQ down_allow_move_2

	; Check to make sure we don't overwrite current color
	add r5, r11, #62
	CMP r5, r2
	BEQ uart_exit

	add r5, r5, #7
	CMP r5, r2
	BEQ uart_exit

	add r5, r5, #7
	CMP r5, r2
	BEQ uart_exit
down_allow_move_2:
	ldr r2, ptr_to_info

	; if it isn't, store the new y-coordinate and allow the movement
	add r4, r4, #0x30
	strb r4, [r2, #1]

	ldr r0, ptr_to_down
	BL output_string

	cmp r11, #0
	BEQ uart_exit		; Run code below this if a color is chosen.

	add r11, r11, #0x30					; Turn number of color into ascii number

	cmp r9, #0				; If next character is an O
	BNE down_corner			; Exit. Otherwise, run code to write lines.
	
	; Check if we are overwriting other lines
	cmp r10, #0x3F
	BLT uart_down_no_overlap
	cmp r10, #0x53
	BGT uart_down_no_overlap

	mov r5, #0

	cmp r10, #0x45
	BLE down_check_pipe

	cmp r10, #0x4C
	BLE down_check_dash

	cmp r10, #0x53
	BLE down_check_corner

down_check_pipe:
	mov r6, r10
	add r7, r6, #7
	add r8, r7, #7
	B down_check_overwrite

down_check_dash:
	mov r7, r10
	sub r6, r7, #7
	add r8, r7, #7
	B down_check_overwrite

down_check_corner:
	mov r8, r10
	sub r7, r8, #7
	sub r6, r7, #7
	B down_check_overwrite

down_check_overwrite:
	BL second_space

	; Lower completion by 1
	ldr r0, ptr_to_completion
	ldrb r1, [r0]
	sub r1, r1, #1
	strb r1, [r0]

	mov r1, #1
	ldr r2, ptr_to_choose_board
	STRB r1, [r2, #2]

uart_down_no_overlap:
	ldr r0, ptr_to_uart_vertical_temp
	strb r11, [r0, #3]
	BL output_string					; Output the line

	ldr r0, ptr_to_left
	BL output_string					; Return pointer to original location

	; HERE WE NEED TO EDIT THE BOARD
	; At this point in time, r11 is the color 1-7

	ldr r0, ptr_to_info

	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	ldrb r2, [r0, #0] ; load x into r2
	sub r2, #0x30	  ; convert into integer

	ldrb r3, [r0, #1] ; load y into r3
	sub r3, #0x30     ; convert into integer

	mov r4, r11
	add r4, r4, #0xE  ; convert into a vertical pipe

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r3, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r2		; Add the x value to get the correct value in the row

	STRB r4, [r1]

	sub r1, r1, #0xB       ; move the pointer one full line up

	add r4, r4, #7 ; convert r4 to a horizontal pipe
	ldrb r2, [r1]
	cmp r2, r4
	BNE uart_exit

	mov r4, r11
	add r4, r4, #28
	STRB r4, [r1]

	ldr r0, ptr_to_up
	BL output_string

	ldr r0, ptr_to_uart_corner_temp
	STRB r11, [r0, #3]
	BL output_string

	ldr r0, ptr_to_left
	BL output_string

	ldr r0, ptr_to_down
	BL output_string

	B uart_exit

down_corner:
	ldr r0, ptr_to_info

	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	ldrb r2, [r0, #0] ; load x into r2
	sub r2, #0x30	  ; convert into integer

	ldrb r3, [r0, #1] ; load y into r3
	sub r3, #0x30     ; convert into integer

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r3, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r2		; Add the x value to get the correct value in the row

	sub r1, r1, #0xB       ; move the pointer one full line up

	mov r4, r11
	add r4, r4, #0xE  ; convert into a vertical pipe
	ldrb r2, [r1]
	cmp r2, r4
	BEQ uart_exit

	mov r4, r11
	add r4, r4, #28
	STRB r4, [r1]

	ldr r0, ptr_to_up
	BL output_string

	ldr r0, ptr_to_uart_corner_temp
	STRB r11, [r0, #3]
	BL output_string

	ldr r0, ptr_to_left
	BL output_string

	ldr r0, ptr_to_down
	BL output_string

	B uart_exit

left:
	; move left and compare to -1
	sub r3, r3, #1
	CMP r3, #-1

	; if it is -1, this movement is illegal; exit immediately
	BEQ uart_exit

	; If the next character is O
	sub r6, r6, #0x1
	ldrb r0, [r6]
	sub r0, r0, #0x30
	cmp r0, #0x1
	BEQ left_has_O
	cmp r0, #0x2
	BEQ left_has_O
	cmp r0, #0x3
	BEQ left_has_O
	cmp r0, #0x4
	BEQ left_has_O
	cmp r0, #0x5
	BEQ left_has_O
	cmp r0, #0x6
	BEQ left_has_O
	cmp r0, #0x7
	BEQ left_has_O
	B left_allow_move

left_has_O:
	STMFD sp!, {r0-r8}

	ldr r9, ptr_to_first_o
	LDRB r0, [r9]
	LDRB r1, [r9, #1]

	CMP r0, r3
	BNE overlap_exit_left
	CMP r1, r4
	BNE overlap_exit_left
	B overlap

overlap_exit_left:
	LDMFD sp!, {r0-r8}

	mov r9, r0

	; If we have a color
	cmp r11, #0
	BEQ left_allow_move

	; Only allow move if color matches
	cmp r11, r9
	BEQ left_clear

	; otherwise, exit.
	B uart_exit

left_clear:		; Clear the color chosen so that we stop drawing.
	ldr r0, ptr_to_choose_board
	mov r1, #0
	strb r1, [r0, #1]

	mov r0, #0
	BL illuminate_RGB_LED

	ldr r5, ptr_to_completion
	ldrb r6, [r5]				; Load 1st digit of the completion
	add r6, r6, #0x1			; Add one to represent 1 line being completed
	strb r6, [r5]				; Store the new completion number back into the string

	ldr r5, ptr_to_completion_temp
	strb r6, [r5, #5]			; Edit completion_temp to reflect digit

	ldr r0, ptr_to_save			; Save position before completion is printed
	BL output_string
	ldr r0, ptr_to_hide			; Hide the cursor
	BL output_string
	ldr r0, ptr_to_completion_start	; Point cursor at where the completion is printed
	BL output_string
	ldr r0, ptr_to_completion_temp	; Print completion number
	BL output_string
	ldr r0, ptr_to_restore		; Return cursor to previous location
	BL output_string
	ldr r0, ptr_to_show 		; Show the cursor
	BL output_string

	mov r0, #9
	ldr r1, ptr_to_first_o
	STRB r0, [r1]
	STRB r0, [r1, #1]

left_allow_move:
		; The color is stored in r11 as an integer
	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r4, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r3		; Add the x value to get the correct value in the row

	LDRB r2, [r1]
	mov r10, r2

	cmp r11, #0
	BEQ left_allow_move_2

	; Check to make sure we don't overwrite current color
	add r5, r11, #62
	CMP r5, r2
	BEQ uart_exit

	add r5, r5, #7
	CMP r5, r2
	BEQ uart_exit

	add r5, r5, #7
	CMP r5, r2
	BEQ uart_exit

left_allow_move_2:
	ldr r2, ptr_to_info

	; if it isn't, store the new y-coordinate and allow the movement
	add r3, r3, #0x30
	strb r3, [r2, #0]

	ldr r0, ptr_to_left
	BL output_string

	cmp r11, #0
	BEQ uart_exit			; Run code below this if a color is chosen.

	add r11, r11, #0x30					; Turn number of color into ascii number

	cmp r9, #0				; If next character is an O
	BNE left_corner			; Exit. Otherwise, run code to write lines.
	
	; Check if we are overwriting other lines
	cmp r10, #0x3F
	BLT uart_left_no_overlap
	cmp r10, #0x53
	BGT uart_left_no_overlap

	mov r5, #0

	cmp r10, #0x45
	BLE left_check_pipe

	cmp r10, #0x4C
	BLE left_check_dash

	cmp r10, #0x53
	BLE left_check_corner

left_check_pipe:
	mov r6, r10
	add r7, r6, #7
	add r8, r7, #7
	B left_check_overwrite

left_check_dash:
	mov r7, r10
	sub r6, r7, #7
	add r8, r7, #7
	B left_check_overwrite

left_check_corner:
	mov r8, r10
	sub r7, r8, #7
	sub r6, r7, #7
	B left_check_overwrite

left_check_overwrite:
	BL second_space

	; Lower completion by 1
	ldr r0, ptr_to_completion
	ldrb r1, [r0]
	sub r1, r1, #1
	strb r1, [r0]

	mov r1, #1
	ldr r2, ptr_to_choose_board
	STRB r1, [r2, #2]

uart_left_no_overlap:
	ldr r0, ptr_to_uart_horizontal_temp
	strb r11, [r0, #3]
	BL output_string					; Output the line

	ldr r0, ptr_to_left
	BL output_string					; Return pointer to original location

	; HERE WE NEED TO EDIT THE BOARD
	; At this point in time, r11 is the color 1-7

	ldr r0, ptr_to_info

	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	ldrb r2, [r0, #0] ; load x into r2
	sub r2, #0x30	  ; convert into integer

	ldrb r3, [r0, #1] ; load y into r3
	sub r3, #0x30     ; convert into integer

	mov r4, r11
	add r4, r4, #21  ; convert into a horizontal pipe

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r3, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r2		; Add the x value to get the correct value in the row

	STRB r4, [r1]

	add r1, r1, #1       ; move the pointer one character to the right

	sub r4, r4, #7 ; convert r4 to a vertical pipe
	ldrb r2, [r1]
	cmp r2, r4
	BNE uart_exit

	mov r4, r11
	add r4, r4, #28
	STRB r4, [r1]

	ldr r0, ptr_to_right
	BL output_string

	ldr r0, ptr_to_uart_corner_temp
	STRB r11, [r0, #3]
	BL output_string

	ldr r0, ptr_to_left
	BL output_string

	ldr r0, ptr_to_left
	BL output_string

	B uart_exit

left_corner:
	ldr r0, ptr_to_info

	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	ldrb r2, [r0, #0] ; load x into r2
	sub r2, #0x30	  ; convert into integer

	ldrb r3, [r0, #1] ; load y into r3
	sub r3, #0x30     ; convert into integer

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r3, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r2		; Add the x value to get the correct value in the row

	add r1, r1, #1       ; move the pointer one character to the right

	mov r4, r11
	add r4, r4, #21  ; convert into a horizontal pipe
	ldrb r2, [r1]
	cmp r2, r4
	BEQ uart_exit

	mov r4, r11
	add r4, r4, #28
	STRB r4, [r1]

	ldr r0, ptr_to_right
	BL output_string

	ldr r0, ptr_to_uart_corner_temp
	STRB r11, [r0, #3]
	BL output_string

	ldr r0, ptr_to_left
	BL output_string

	ldr r0, ptr_to_left
	BL output_string

	B uart_exit
; Move the pointers here to resolve a literal pool error.
	.text
; pointer to the board
ptr_to_board1_og: 				.word board1_og
ptr_to_board1_edit: 			.word board1_edit
ptr_to_board1_sol: 				.word board1_sol
ptr_to_board2_og: 				.word board2_og
ptr_to_board2_edit: 			.word board2_edit
ptr_to_board2_sol: 				.word board2_sol
ptr_to_board3_og: 				.word board3_og
ptr_to_board3_edit: 			.word board3_edit
ptr_to_board3_sol: 				.word board3_sol
ptr_to_board4_og: 				.word board4_og
ptr_to_board4_edit: 			.word board4_edit
ptr_to_board4_sol: 				.word board4_sol
ptr_to_board5_og: 				.word board5_og
ptr_to_board5_edit: 			.word board5_edit
ptr_to_board5_sol: 				.word board5_sol
ptr_to_board6_og: 				.word board6_og
ptr_to_board6_edit: 			.word board6_edit
ptr_to_board6_sol: 				.word board6_sol
ptr_to_board7_og: 				.word board7_og
ptr_to_board7_edit: 			.word board7_edit
ptr_to_board7_sol: 				.word board7_sol
ptr_to_board8_og: 				.word board8_og
ptr_to_board8_edit: 			.word board8_edit
ptr_to_board8_sol: 				.word board8_sol
ptr_to_board9_og: 				.word board9_og
ptr_to_board9_edit: 			.word board9_edit
ptr_to_board9_sol: 				.word board9_sol
ptr_to_board10_og: 				.word board10_og
ptr_to_board10_edit: 			.word board10_edit
ptr_to_board10_sol: 			.word board10_sol
ptr_to_board11_og: 				.word board11_og
ptr_to_board11_edit: 			.word board11_edit
ptr_to_board11_sol: 			.word board11_sol
ptr_to_board12_og: 				.word board12_og
ptr_to_board12_edit: 			.word board12_edit
ptr_to_board12_sol: 			.word board12_sol
ptr_to_board13_og: 				.word board13_og
ptr_to_board13_edit: 			.word board13_edit
ptr_to_board13_sol: 			.word board13_sol
ptr_to_board14_og: 				.word board14_og
ptr_to_board14_edit: 			.word board14_edit
ptr_to_board14_sol: 			.word board14_sol
ptr_to_board15_og: 				.word board15_og
ptr_to_board15_edit: 			.word board15_edit
ptr_to_board15_sol: 			.word board15_sol
ptr_to_board16_og: 				.word board16_og
ptr_to_board16_edit: 			.word board16_edit
ptr_to_board16_sol: 			.word board16_sol
ptr_to_clear:					.word clear
ptr_to_the_time:				.word the_time
ptr_to_choose_board:			.word choose_board
ptr_to_completion:				.word completion

; pointer to the colors
ptr_to_red:    					.word red
ptr_to_green:   				.word green
ptr_to_yellow:  				.word yellow
ptr_to_blue:    				.word blue
ptr_to_magenta: 				.word magenta
ptr_to_cyan:    				.word cyan
ptr_to_white:   				.word white
ptr_to_red_pipe:    			.word red_pipe
ptr_to_green_pipe:   			.word green_pipe
ptr_to_yellow_pipe:  			.word yellow_pipe
ptr_to_blue_pipe:    			.word blue_pipe
ptr_to_magenta_pipe: 			.word magenta_pipe
ptr_to_cyan_pipe:    			.word cyan_pipe
ptr_to_white_pipe:   			.word white_pipe
ptr_to_red_dash:   		 		.word red_dash
ptr_to_green_dash:  		 	.word green_dash
ptr_to_yellow_dash:  			.word yellow_dash
ptr_to_blue_dash:    			.word blue_dash
ptr_to_magenta_dash: 			.word magenta_dash
ptr_to_cyan_dash:    			.word cyan_dash
ptr_to_white_dash:   			.word white_dash
ptr_to_red_corner:    			.word red_corner
ptr_to_green_corner:   			.word green_corner
ptr_to_yellow_corner:  			.word yellow_corner
ptr_to_blue_corner:    			.word blue_corner
ptr_to_magenta_corner: 			.word magenta_corner
ptr_to_cyan_corner:   			.word cyan_corner
ptr_to_white_corner:   			.word white_corner


; pointer to the cursor strings
ptr_to_first_o:					.word first_o
ptr_to_hide:					.word hide
ptr_to_show:					.word show
ptr_to_top_left:				.word top_left
ptr_to_start:					.word start
ptr_to_up: 						.word move_up
ptr_to_down:					.word move_down
ptr_to_left:					.word move_left
ptr_to_right:					.word move_right
ptr_to_save:					.word save
ptr_to_restore:					.word restore
ptr_to_info:					.word info
ptr_to_pause:					.word pause
ptr_to_timer_start:				.word timer_start
ptr_to_timer_temp:				.word timer_temp
ptr_to_uart_horizontal_temp:	.word uart_horizontal_temp
ptr_to_uart_vertical_temp:		.word uart_vertical_temp
ptr_to_uart_corner_temp:		.word uart_corner_temp
ptr_to_completion_start:		.word completion_start
ptr_to_completion_temp:			.word completion_temp

; pointer to prompts
ptr_to_prompt_space: 			.word prompt_space
ptr_to_paused: 					.word paused
ptr_to_quitted: 				.word quitted
ptr_to_congrats:				.word congrats

right:
	; move right and compare to 7
	add r3, r3, #1
	CMP r3, #7

	; if it is 7, this movement is illegal; exit immediately
	BEQ uart_exit

	; If the next character is O
	add r6, r6, #0x1
	ldrb r0, [r6]
	sub r0, r0, #0x30
	cmp r0, #0x1
	BEQ right_has_O
	cmp r0, #0x2
	BEQ right_has_O
	cmp r0, #0x3
	BEQ right_has_O
	cmp r0, #0x4
	BEQ right_has_O
	cmp r0, #0x5
	BEQ right_has_O
	cmp r0, #0x6
	BEQ right_has_O
	cmp r0, #0x7
	BEQ right_has_O
	B right_allow_move

right_has_O:
	STMFD sp!, {r0-r8}

	ldr r9, ptr_to_first_o
	LDRB r0, [r9]
	LDRB r1, [r9, #1]

	CMP r0, r3
	BNE overlap_exit_right
	CMP r1, r4
	BNE overlap_exit_right
	B overlap

overlap_exit_right:
	LDMFD sp!, {r0-r8}

	mov r9, r0

	; If we have a color
	cmp r11, #0
	BEQ right_allow_move

	; Only allow move if color matches
	cmp r11, r9
	BEQ right_clear

	; otherwise, exit.
	B uart_exit

right_clear:		; Clear the color chosen so that we stop drawing.
	ldr r0, ptr_to_choose_board
	mov r1, #0
	strb r1, [r0, #1]

	mov r0, #0
	BL illuminate_RGB_LED

	ldr r5, ptr_to_completion
	ldrb r6, [r5]				; Load 1st digit of the completion
	add r6, r6, #0x1			; Add one to represent 1 line being completed
	strb r6, [r5]				; Store the new completion number back into the string

	ldr r5, ptr_to_completion_temp
	strb r6, [r5, #5]			; Edit completion_temp to reflect digit

	ldr r0, ptr_to_save			; Save position before completion is printed
	BL output_string
	ldr r0, ptr_to_hide			; Hide the cursor
	BL output_string
	ldr r0, ptr_to_completion_start	; Point cursor at where the completion is printed
	BL output_string
	ldr r0, ptr_to_completion_temp	; Print completion number
	BL output_string
	ldr r0, ptr_to_restore		; Return cursor to previous location
	BL output_string
	ldr r0, ptr_to_show 		; Show the cursor
	BL output_string

	mov r0, #9
	ldr r1, ptr_to_first_o
	STRB r0, [r1]
	STRB r0, [r1, #1]


right_allow_move:
		; The color is stored in r11 as an integer
	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r4, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r3		; Add the x value to get the correct value in the row

	LDRB r2, [r1]
	mov r10, r2

	cmp r11, #0
	BEQ right_allow_move_2

	; Check to make sure we don't overwrite current color

	add r5, r11, #62
	CMP r5, r2
	BEQ uart_exit

	add r5, r5, #7
	CMP r5, r2
	BEQ uart_exit

	add r5, r5, #7
	CMP r5, r2
	BEQ uart_exit

right_allow_move_2:
	ldr r2, ptr_to_info

	; if it isn't, store the new y-coordinate and allow the movement
	add r3, r3, #0x30
	strb r3, [r2, #0]

	ldr r0, ptr_to_right
	BL output_string

	cmp r11, #0
	BEQ uart_exit			; Run code below this if a color is chosen.

	add r11, r11, #0x30		; Turn number of color into ascii number

	cmp r9, #0				; If next character is an O
	BNE right_corner			; Exit. Otherwise, run code to write lines.
	
	; Check if we are overwriting other lines
	cmp r10, #0x3F
	BLT uart_right_no_overlap
	cmp r10, #0x53
	BGT uart_right_no_overlap

	mov r5, #0

	cmp r10, #0x45
	BLE right_check_pipe

	cmp r10, #0x4C
	BLE right_check_dash

	cmp r10, #0x53
	BLE right_check_corner

right_check_pipe:
	mov r6, r10
	add r7, r6, #7
	add r8, r7, #7
	B right_check_overwrite

right_check_dash:
	mov r7, r10
	sub r6, r7, #7
	add r8, r7, #7
	B right_check_overwrite

right_check_corner:
	mov r8, r10
	sub r7, r8, #7
	sub r6, r7, #7
	B right_check_overwrite

right_check_overwrite:
	BL second_space

	; Lower completion by 1
	ldr r0, ptr_to_completion
	ldrb r1, [r0]
	sub r1, r1, #1
	strb r1, [r0]

	mov r1, #1
	ldr r2, ptr_to_choose_board
	STRB r1, [r2, #2]

uart_right_no_overlap:
	ldr r0, ptr_to_uart_horizontal_temp
	strb r11, [r0, #3]
	BL output_string					; Output the line

	ldr r0, ptr_to_left
	BL output_string					; Return pointer to original location

	; HERE WE NEED TO EDIT THE BOARD
	; At this point in time, r11 is the color 1-7

	ldr r0, ptr_to_info

	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	ldrb r2, [r0, #0] ; load x into r2
	sub r2, #0x30	  ; convert into integer

	ldrb r3, [r0, #1] ; load y into r3
	sub r3, #0x30     ; convert into integer

	mov r4, r11
	add r4, r4, #21  ; convert into a horizontal pipe

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r3, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r2		; Add the x value to get the correct value in the row

	STRB r4, [r1]

	sub r1, r1, #1       ; move the pointer one character to the left

	sub r4, r4, #7 ; convert r4 to a vertical pipe
	ldrb r2, [r1]
	cmp r2, r4
	BNE uart_exit

	mov r4, r11
	add r4, r4, #28
	STRB r4, [r1]

	ldr r0, ptr_to_left
	BL output_string

	ldr r0, ptr_to_uart_corner_temp
	STRB r11, [r0, #3]
	BL output_string

	ldr r0, ptr_to_left
	BL output_string

	ldr r0, ptr_to_right
	BL output_string

	B uart_exit

right_corner:
	ldr r0, ptr_to_info

	mov r1, r12 ; r0 is now the board number
	add r1, r1, #40 ; move r1 to x = 0 and y = 0

	ldrb r2, [r0, #0] ; load x into r2
	sub r2, #0x30	  ; convert into integer

	ldrb r3, [r0, #1] ; load y into r3
	sub r3, #0x30     ; convert into integer

	mov r5, #0xB		; Store the number of characters in each row of the string.
	mul r5, r3, r5		; Multiple rows by characters in rows
	add r1, r1, r5		; Add r1 to r5 to get to the correct row
	add r1, r1, r2		; Add the x value to get the correct value in the row

	sub r1, r1, #1       ; move the pointer one character to the left

	mov r4, r11
	add r4, r4, #21  ; convert into a horizontal pipe
	ldrb r2, [r1]
	cmp r2, r4
	BEQ uart_exit

	mov r4, r11
	add r4, r4, #28
	STRB r4, [r1]

	ldr r0, ptr_to_left
	BL output_string

	ldr r0, ptr_to_uart_corner_temp
	STRB r11, [r0, #3]
	BL output_string

	ldr r0, ptr_to_left
	BL output_string

	ldr r0, ptr_to_right
	BL output_string

	B uart_exit


uart_quit_game:
	ldr r0, ptr_to_pause
	mov r1, #0x71
	strb r1, [r0]
	B uart_exit

uart_space:
; Check if we are at an 'O'. If we are, check current color. Otherwise, exit.
; If current color is 0 (aka none), replace it with the color of the O we are at.
; It should not be possible to reach an O if a color is already selected.

	mov r4, r12			; Grab the board string and put it in r4

	add r4, r4, #40		; Makes sure we point at the beginning of the board where x = 0 and y = 0

	; Determine if this is the second space
	mov r5, #0          ; In the event that it is, assign r5 to 0 to represent a counter i
	; r6 is the ASCII for a pipe, r7 is the ASCII for a dash, r8 is the ASCII for a corner
	add r6, r11, #62
	add r7, r11, #69
	add r8, r11, #76

	ldr r0, ptr_to_choose_board
	ldrb r11, [r0,#1]				; Load current color in r11

	cmp r11, #0         ; If the color isn't 0, branch into second_space
	BNE second_space_delete

	ldr r0, ptr_to_info	; Load string info

	ldrb r1, [r0,#0]	; r1 = x
	sub r1, r1, #0x30	; As an integer

	ldrb r2, [r0,#1]	; r2 = y
	sub r2, r2, #0x30	; As an integer

	mov r0, r4			; Store our current location in the string into r0.

	mov r3, #0xB		; Store the number of characters in each row of the string.
	mul r4, r2, r3		; Multiple rows by characters in rows
	add r0, r0, r4		; Add r4 to r0 to get to the correct row
	add r0, r0, r1		; Add the x value to get the correct value in the row

	ldrb r1, [r0]		; Load the character that is currently being pointed at.

   	; Check if character is an O
    cmp r1, #0x31
    BEQ uart_space_O
    cmp r1, #0x32
    BEQ uart_space_O
    cmp r1, #0x33
    BEQ uart_space_O
    cmp r1, #0x34
    BEQ uart_space_O
    cmp r1, #0x35
    BEQ uart_space_O
    cmp r1, #0x36
    BEQ uart_space_O
    cmp r1, #0x37
    BEQ uart_space_O
    B uart_exit            		; Exit if character is not an O

uart_space_O:
	; Code here is run if it is the first O
	sub r1, r1, #0x30			; Get the character as a number instead of ascii number
	ldr r0, ptr_to_choose_board
	strb r1, [r0, #1]			; Store the color of the O as a string. It will be the second character of choose_board

	mov r11, r1
	mov r0, r11
	BL illuminate_RGB_LED


	ldr r0, ptr_to_info	; Load string info
	ldrb r1, [r0,#0]	; r1 = x
	sub r1, r1, #0x30	; As an integer
	ldrb r2, [r0,#1]	; r2 = y
	sub r2, r2, #0x30	; As an integer

	ldr r3, ptr_to_first_o
	STRB r1, [r3]
	STRB r2, [r3, #1]

	; Calculate so that r4 = current position.
	mov r4, r12
	add r4, r4, #40
	mov r5, #0xB
	mul r5, r5, r2
	add r4, r5
	add r4, r1

	add r6, r11, #62	; r5 will be the vertical pipe
	add r7, r6, #7		; r6 will be the horizontal pipe
	add r8, r7, #7		; r7 will be the corner

	mov r5, #0

	; Check above. Store pointer above current position in r1.
	sub r1, r4, #0xB
	ldrb r0, [r1]
	cmp r0, r6
	BEQ overwrite_line
	cmp r0, r7
	BEQ overwrite_line
	cmp r0, r8
	BEQ overwrite_line

	; Check below.
	add r1, r4, #0xB
	ldrb r0, [r1]
	cmp r0, r6
	BEQ overwrite_line
	cmp r0, r7
	BEQ overwrite_line
	cmp r0, r8
	BEQ overwrite_line

	; Check left
	sub r1, r4, #0x1
	ldrb r0, [r1]
	cmp r0, r6
	BEQ overwrite_line
	cmp r0, r7
	BEQ overwrite_line
	cmp r0, r8
	BEQ overwrite_line

	; Check right
	add r1, r4, #0x1
	ldrb r0, [r1]
	cmp r0, r6
	BEQ overwrite_line
	cmp r0, r7
	BEQ overwrite_line
	cmp r0, r8
	BEQ overwrite_line

	B uart_exit

overwrite_line:
    BL second_space

    mov r1, #1
    ldr r2, ptr_to_choose_board
    STRB r1, [r2, #2]

    ; Lower completion by 1
	ldr r0, ptr_to_completion
	ldrb r1, [r0]
	sub r1, r1, #1
	strb r1, [r0]

    B uart_exit

second_space_delete:
    BL second_space

    mov r0, #0
    BL illuminate_RGB_LED ; reset the LED to empty

    mov r0, #0
    mov r1, #1
    ldr r2, ptr_to_choose_board
    STRB r0, [r2, #1]
    STRB r1, [r2, #2]

    mov r0, #9
    ldr r1, ptr_to_first_o
    STRB r0, [r1]
    STRB r0, [r1, #1]

    B uart_exit

second_space:
	STMFD SP!,{lr} ; Store register lr on stack

second_space_loop:
	ldrb r3, [r12, r5]		; load the current character of the edited board into r3

	CMP r3, r6
	BEQ delete_write

	CMP r3, r7
	BEQ delete_write

	CMP r3, r8
	BEQ delete_write

	; add one to r2 and compare to 128, if this fails redo this loop
	add r5, r5, #1
	cmp r5, #0x80
	BNE second_space_loop

	LDMFD SP!,{lr} ; Store register lr on stack
	mov pc, lr

delete_write:
	mov r9, #0x20
	STRB r9, [r12, r5]

	; add one to r2 and compare to 128, if this fails redo this loop
	add r5, r5, #1
	cmp r5, #0x80
	BNE second_space_loop

	LDMFD SP!,{lr} ; Store register lr on stack
	mov pc, lr

uart_exit:
	LDMFD sp!, {r0-r12,lr}
	BX lr


Switch_Handler:
	STMFD SP!,{r0-r12,lr} ; Store register lr on stack

	mov r0, #0x541C
	movt r0, #0x4002
	ldr r1, [r0]
	orr r1, r1, #0x10
	str r1, [r0]

	ldr r0, ptr_to_pause
	mov r1, #0x70
	strb r1, [r0]				; Set pause string to p

	LDMFD sp!, {r0-r12,lr}
	BX lr

Timer_Handler:
	STMFD SP!,{r0-r12,lr} ; Preserve registers on the stack

	mov r1, #0x0024
	movt r1, #0x4003
	ldr r2, [r1]
	orr r2, r1, #0x1
	str r2, [r1]

	ldr r0, ptr_to_choose_board
	ldrb r1, [r0]
	cmp r1, #0xF
	BEQ timer_every_second
	add r1, r1, #0x1
	strb r1, [r0]
	B timer_exit


timer_every_second:
	mov r1, #0
	strb r1, [r0]			; Set choose_board value back to 0 if it hits F (15).

	ldr r0, ptr_to_pause
	ldrb r1, [r0]
	cmp r1, #0x6E
	BNE timer_exit			; If something other than "n" (nothing) is happening, do not update timer.

	ldr r0, ptr_to_the_time

; Digits are numbered 4/3/2/1
timer_ones:
	ldrb r1, [r0,#3]
	cmp r1, #0x39
	BEQ timer_tens				; Check if first digit is 9. If it is, go to timer_tens.
	add r1, r1, #0x1			; Otherwise, add 1 to the first digit in timer and print the timer
	strb r1, [r0,#3]
	B timer_print

timer_tens:
	mov r2, #0x30
	strb r2, [r0,#3]			; Store 0 in the first digit of the timer.

	ldrb r1, [r0,#2]
	cmp r1, #0x39
	BEQ timer_hundreds			; Check if second digit is 9. If it is, go to timer_hundreds
	add r1, r1, #0x1			; Otherwise, add 1 to the second digit in timer and print the timer
	strb r1, [r0,#2]
	B timer_print

timer_hundreds:
	mov r2, #0x30
	strb r2, [r0,#2]			; Store 0 in the second digit of the timer.

	ldrb r1, [r0,#1]
	cmp r1, #0x39
	BEQ timer_thousands			; Check if third digit is 9. If it is, go to timer_thousands
	add r1, r1, #0x1			; Otherwise, add 1 to the third digit in timer and print the timer
	strb r1, [r0,#1]
	B timer_print

timer_thousands:
	mov r2, #0x30
	strb r2, [r0,#1]			; Store 0 in the third digit of the timer.

	ldrb r1, [r0,#0]
	add r1, r1, #0x1			; Add 1 to the fourth digit in timer and print the timer
	strb r1, [r0,#0]
	B timer_print

timer_print:
	ldr r0, ptr_to_save			; Save position before timer is printed
	BL output_string

	ldr r0, ptr_to_hide
	BL output_string

	ldr r0, ptr_to_timer_start	; Point cursor at where the timer is printed
	BL output_string

	ldr r4, ptr_to_the_time

	ldrb r5, [r4,#0]			; Load 4th digit of the time
	ldr r0, ptr_to_timer_temp
	strb r5, [r0, #5]			; Edit timer_temp to reflect digit
	BL output_string			; Print digit

	ldrb r5, [r4,#1]			; Load 3rd digit of the time
	ldr r0, ptr_to_timer_temp
	strb r5, [r0, #5]			; Edit timer_temp to reflect digit
	BL output_string			; Print digit

	ldrb r5, [r4,#2]			; Load 2nd digit of the time
	ldr r0, ptr_to_timer_temp
	strb r5, [r0, #5]			; Edit timer_temp to reflect digit
	BL output_string			; Print digit

	ldrb r5, [r4,#3]			; Load 1st digit of the time
	ldr r0, ptr_to_timer_temp
	strb r5, [r0, #5]			; Edit timer_temp to reflect digit
	BL output_string			; Print digit

	ldr r0, ptr_to_restore		; Return cursor to previous locations
	BL output_string

	ldr r0, ptr_to_show
	BL output_string

timer_exit:
	LDMFD sp!, {r0-r12,lr}
	BX lr


forwards:
	add r4, r4, #1				; Change pointer to grid forward one
	add r5, r5, #1				; Add 1 to x value
	ldr r0, ptr_to_right		; move cursor forward
	BL output_string
	B print_char

downs:
	add r4, r4, #4				; Change pointer to first char of next row
	mov r5, #0					; Set x value to 0
	add r6, r6, #1				; Add 1 to y value
	ldr r0, ptr_to_restore		; Return cursor to beginning of row
	BL output_string
	ldr r0, ptr_to_down			; Move cursor down to next row
	BL output_string
	ldr r0, ptr_to_save			; Save position at beginning of row
	BL output_string
	B print_char


print_red:
	ldr r0, ptr_to_red
	BL output_string			; Print red O
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_green:
	ldr r0, ptr_to_green
	BL output_string			; Print green O
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_yellow:
	ldr r0, ptr_to_yellow
	BL output_string			; Print yellow O
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_blue:
	ldr r0, ptr_to_blue
	BL output_string			; Print blue O
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_magenta:
	ldr r0, ptr_to_magenta
	BL output_string			; Print magenta O
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_cyan:
	ldr r0, ptr_to_cyan
	BL output_string			; Print cyan O
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_white:
	ldr r0, ptr_to_white
	BL output_string			; Print white O
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_red_pipe:
	ldr r0, ptr_to_red_pipe
	BL output_string			; Print red pipe
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_green_pipe:
	ldr r0, ptr_to_green_pipe
	BL output_string			; Print green pipe
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_yellow_pipe:
	ldr r0, ptr_to_yellow_pipe
	BL output_string			; Print yellow pipe
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_blue_pipe:
	ldr r0, ptr_to_blue_pipe
	BL output_string			; Print blue pipe
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_magenta_pipe:
	ldr r0, ptr_to_magenta_pipe
	BL output_string			; Print magenta pipe
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_cyan_pipe:
	ldr r0, ptr_to_cyan_pipe
	BL output_string			; Print cyan pipe
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_white_pipe:
	ldr r0, ptr_to_white_pipe
	BL output_string			; Print white pipe
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_red_dash:
	ldr r0, ptr_to_red_dash
	BL output_string			; Print red dash
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_green_dash:
	ldr r0, ptr_to_green_dash
	BL output_string			; Print green dash
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_yellow_dash:
	ldr r0, ptr_to_yellow_dash
	BL output_string			; Print yellow dash
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_blue_dash:
	ldr r0, ptr_to_blue_dash
	BL output_string			; Print blue dash
	ldr r0, ptr_to_left
	BL output_string
	B next_char

print_magenta_dash:
	ldr r0, ptr_to_magenta_dash
	BL output_string			; Print magenta dash
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_cyan_dash:
	ldr r0, ptr_to_cyan_dash
	BL output_string			; Print cyan dash
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_white_dash:
	ldr r0, ptr_to_white_dash
	BL output_string			; Print white dash
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_red_corner:
	ldr r0, ptr_to_red_corner
	BL output_string			; Print red corner
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_green_corner:
	ldr r0, ptr_to_green_corner
	BL output_string			; Print green corner
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_yellow_corner:
	ldr r0, ptr_to_yellow_corner
	BL output_string			; Print yellow corner
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_blue_corner:
	ldr r0, ptr_to_blue_corner
	BL output_string			; Print blue corner
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_magenta_corner:
	ldr r0, ptr_to_magenta_corner
	BL output_string			; Print magenta corner
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_cyan_corner:
	ldr r0, ptr_to_cyan_corner
	BL output_string			; Print cyan corner
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

print_white_corner:
	ldr r0, ptr_to_white_corner
	BL output_string			; Print white corner
	ldr r0, ptr_to_left
	BL output_string			; Move cursor left
	B next_char

new_timer_init:
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
    ; Interval has been edited to be every 1/16th of a second
    mov r0, #0x0028
    movt r0, #0x4003
    ldr r1, [r0]
    mov r2, #0x4240
    movt r2, #0x000F
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

	.end
