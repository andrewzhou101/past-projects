	.text
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


; -----------------------
;          KEY
; -----------------------

; Red Circle - 1
; Green Circle - 2
; Yellow Circle - 3
; Blue Circle - 4
; Magenta Circle - 5
; Cyan Circle - 6
; White Circle - 7

; Red Pipe (Vertical) - ?
; Green Pipe (Vertical) - @
; Yellow Pipe (Vertical) - A
; Blue Pipe (Vertical) - B
; Magenta Pipe (Vertical) - C
; Cyan Pipe (Vertical)- D
; White Pipe (Vertical)- E

; Red Pipe (Horizontal) - F
; Green Pipe (Horizontal) - G
; Yellow Pipe (Horizontal) - H
; Blue Pipe (Horizontal) - I
; Magenta Pipe (Horizontal) - J
; Cyan Pipe (Horizontal)- K
; White Pipe (Horizontal)- L

; Red Corner - M
; Green Corner - N
; Yellow Corner - O
; Blue Corner - P
; Magenta Corner - Q
; Cyan Corner - R
; White Corner - S


	.data
board1_og: 	    .string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X 51    X", 0xA, 0xD
	       		.string "X  74 4 X", 0xA, 0xD
	       		.string "X  2    X", 0xA, 0xD
	       		.string "X  63 2 X", 0xA, 0xD
	       		.string "X    36 X", 0xA, 0xD
	       		.string "X  7    X", 0xA, 0xD
	       		.string "X  51   X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board1_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X 51    X", 0xA, 0xD
	       		.string "X  74 4 X", 0xA, 0xD
	       		.string "X  2    X", 0xA, 0xD
	       		.string "X  63 2 X", 0xA, 0xD
	       		.string "X    36 X", 0xA, 0xD
	       		.string "X  7    X", 0xA, 0xD
	       		.string "X  51   X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board1_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XQ51FFFMX", 0xA, 0xD
	       		.string "XCS74I4?X", 0xA, 0xD
	       		.string "XCE2GGN?X", 0xA, 0xD
	       		.string "XCE63O2?X", 0xA, 0xD
	       		.string "XCERR36?X", 0xA, 0xD
	       		.string "XCS7RKR?X", 0xA, 0xD
	       		.string "XQJ51FFMX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board2_og: 		.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X61 1 2 X", 0xA, 0xD
	       		.string "X  562  X", 0xA, 0xD
	       		.string "X  3   4X", 0xA, 0xD
	       		.string "X  7    X", 0xA, 0xD
	       		.string "X    3 4X", 0xA, 0xD
	       		.string "X    5 7X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board2_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X61 1 2 X", 0xA, 0xD
	       		.string "X  562  X", 0xA, 0xD
	       		.string "X  3   4X", 0xA, 0xD
	       		.string "X  7   BX", 0xA, 0xD
	       		.string "X    3 4X", 0xA, 0xD
	       		.string "X    5 7X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board2_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XRKKKKKRX", 0xA, 0xD
	       		.string "X61F1N2DX", 0xA, 0xD
	       		.string "XQJ562RRX", 0xA, 0xD
	       		.string "XCO3RKR4X", 0xA, 0xD
	       		.string "XCA7LLSBX", 0xA, 0xD
	       		.string "XCOHH3E4X", 0xA, 0xD
	       		.string "XQJJJ5S7X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board3_og: 		.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X    2 6X", 0xA, 0xD
	       		.string "X 6    7X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X  31  1X", 0xA, 0xD
	       		.string "X   4  4X", 0xA, 0xD
	       		.string "X 735   X", 0xA, 0xD
	       		.string "X     25X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board3_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X    2 6X", 0xA, 0xD
	       		.string "X 6    7X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X  31  1X", 0xA, 0xD
	       		.string "X   4  4X", 0xA, 0xD
	       		.string "X 735   X", 0xA, 0xD
	       		.string "X     25X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board3_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XNGGG2R6X", 0xA, 0xD
	       		.string "X@6KKKR7X", 0xA, 0xD
	       		.string "X@SLLLLSX", 0xA, 0xD
	       		.string "X@E31FF1X", 0xA, 0xD
	       		.string "X@EA4II4X", 0xA, 0xD
	       		.string "X@735JJQX", 0xA, 0xD
	       		.string "XNGGGG25X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board4_og: 	    .string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X456  1 X", 0xA, 0xD
	       		.string "X   4   X", 0xA, 0xD
	       		.string "X 7 63  X", 0xA, 0xD
	       		.string "X5      X", 0xA, 0xD
	       		.string "X32 271 X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board4_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X456  1 X", 0xA, 0xD
	       		.string "X   4   X", 0xA, 0xD
	       		.string "X 7 63  X", 0xA, 0xD
	       		.string "X5      X", 0xA, 0xD
	       		.string "X32 271 X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board4_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XPIIPOHOX", 0xA, 0xD
	       		.string "X456BA1AX", 0xA, 0xD
	       		.string "XQQD4A?AX", 0xA, 0xD
	       		.string "XC7R63?AX", 0xA, 0xD
	       		.string "X5SLLS?AX", 0xA, 0xD
	       		.string "X32G271AX", 0xA, 0xD
	       		.string "XOHHHHHOX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board5_og: 		.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X     1 X", 0xA, 0xD
	       		.string "X2172   X", 0xA, 0xD
	       		.string "X65    3X", 0xA, 0xD
	       		.string "X   3   X", 0xA, 0xD
	       		.string "X     4 X", 0xA, 0xD
	       		.string "X654   7X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board5_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X     1 X", 0xA, 0xD
	       		.string "X2172   X", 0xA, 0xD
	       		.string "X65    3X", 0xA, 0xD
	       		.string "X   3   X", 0xA, 0xD
	       		.string "X     4 X", 0xA, 0xD
	       		.string "X654   7X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board5_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XNGGGGGNX", 0xA, 0xD
	       		.string "X@MFFF1@X", 0xA, 0xD
	       		.string "X2172GGNX", 0xA, 0xD
	       		.string "X65EOHH3X", 0xA, 0xD
	       		.string "XDCE3SLSX", 0xA, 0xD
	       		.string "XDCSLS4EX", 0xA, 0xD
	       		.string "X654IIP7X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board6_og: 	    .string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X      1X", 0xA, 0xD
	       		.string "X 5     X", 0xA, 0xD
	       		.string "X 4  5  X", 0xA, 0xD
	       		.string "X 73 47 X", 0xA, 0xD
	       		.string "X 6   1 X", 0xA, 0xD
	       		.string "X 2   32X", 0xA, 0xD
	       		.string "X  6    X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board6_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X      1X", 0xA, 0xD
	       		.string "X 5     X", 0xA, 0xD
	       		.string "X 4  5  X", 0xA, 0xD
	       		.string "X 73 47 X", 0xA, 0xD
	       		.string "X 6   1 X", 0xA, 0xD
	       		.string "X 2   32X", 0xA, 0xD
	       		.string "X  6    X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board6_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XSLLLLS1X", 0xA, 0xD
	       		.string "XE5JJQE?X", 0xA, 0xD
	       		.string "XE4IP5E?X", 0xA, 0xD
	       		.string "XS73P47?X", 0xA, 0xD
	       		.string "XR6OHO1MX", 0xA, 0xD
	       		.string "XD2GNO32X", 0xA, 0xD
	       		.string "XRK6NGGNX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board7_og: 	    .string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X 2   3 X", 0xA, 0xD
	       		.string "X  3  41X", 0xA, 0xD
	       		.string "X      5X", 0xA, 0xD
	       		.string "X     76X", 0xA, 0xD
	       		.string "X5124   X", 0xA, 0xD
	       		.string "X     76X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board7_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X 2   3 X", 0xA, 0xD
	       		.string "X  3  41X", 0xA, 0xD
	       		.string "X      5X", 0xA, 0xD
	       		.string "X     76X", 0xA, 0xD
	       		.string "X5124   X", 0xA, 0xD
	       		.string "X     76X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board7_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XMFFFFFMX", 0xA, 0xD
	       		.string "X?2OHH3?X", 0xA, 0xD
	       		.string "X?@3PI41X", 0xA, 0xD
	       		.string "X?NNBQJ5X", 0xA, 0xD
	       		.string "XMM@BC76X", 0xA, 0xD
	       		.string "X5124CEDX", 0xA, 0xD
	       		.string "XQJJJQ76X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board8_og: 		.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X1      X", 0xA, 0xD
	       		.string "X  2145 X", 0xA, 0xD
	       		.string "X2      X", 0xA, 0xD
	       		.string "X  4    X", 0xA, 0xD
	       		.string "X     67X", 0xA, 0xD
	       		.string "X563  3 X", 0xA, 0xD
	       		.string "X7      X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board8_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X1      X", 0xA, 0xD
	       		.string "X  2145 X", 0xA, 0xD
	       		.string "X2      X", 0xA, 0xD
	       		.string "X  4    X", 0xA, 0xD
	       		.string "X     67X", 0xA, 0xD
	       		.string "X563  3 X", 0xA, 0xD
	       		.string "X7      X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board8_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X1FFMOIOX", 0xA, 0xD
	       		.string "XNG2145BX", 0xA, 0xD
	       		.string "X2QJJJQBX", 0xA, 0xD
	       		.string "XQQ4IIIOX", 0xA, 0xD
	       		.string "XCRKKK67X", 0xA, 0xD
	       		.string "X563HH3EX", 0xA, 0xD
	       		.string "X7LLLLLSX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board9_og: 		.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X5 2  4 X", 0xA, 0xD
	       		.string "X3  5 1 X", 0xA, 0xD
	       		.string "X   3   X", 0xA, 0xD
	       		.string "X   12  X", 0xA, 0xD
	       		.string "X67     X", 0xA, 0xD
	       		.string "X     6 X", 0xA, 0xD
	       		.string "X74     X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board9_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X5 2  4 X", 0xA, 0xD
	       		.string "X3  5 1 X", 0xA, 0xD
	       		.string "X   3   X", 0xA, 0xD
	       		.string "X   12  X", 0xA, 0xD
	       		.string "X67     X", 0xA, 0xD
	       		.string "X     6 X", 0xA, 0xD
	       		.string "X74     X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board9_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X5Q2GN4OX", 0xA, 0xD
	       		.string "X3QJ5@1BX", 0xA, 0xD
	       		.string "XOHH3@?BX", 0xA, 0xD
	       		.string "XRKR12?BX", 0xA, 0xD
	       		.string "X67DMFMBX", 0xA, 0xD
	       		.string "XSSRKK6BX", 0xA, 0xD
	       		.string "X74IIIIOX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board10_og: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X7 2 24 X", 0xA, 0xD
	       		.string "X3 5  6 X", 0xA, 0xD
	       		.string "X    5  X", 0xA, 0xD
	       		.string "X    6 4X", 0xA, 0xD
	       		.string "X713    X", 0xA, 0xD
	       		.string "X     1 X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board10_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X7 2 24 X", 0xA, 0xD
	       		.string "X3 5  6 X", 0xA, 0xD
	       		.string "X    5  X", 0xA, 0xD
	       		.string "X    6 4X", 0xA, 0xD
	       		.string "X713    X", 0xA, 0xD
	       		.string "X     1 X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board10_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X7S2G24OX", 0xA, 0xD
	       		.string "X3E5JQ6BX", 0xA, 0xD
	       		.string "XASLS5DBX", 0xA, 0xD
	       		.string "XOHOE6R4X", 0xA, 0xD
	       		.string "X713SLLSX", 0xA, 0xD
	       		.string "XEMFFF1EX", 0xA, 0xD
	       		.string "XSLLLLLSX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board11_og: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X6   57 X", 0xA, 0xD
	       		.string "X  1  5 X", 0xA, 0xD
	       		.string "X     4 X", 0xA, 0xD
	       		.string "X63 1   X", 0xA, 0xD
	       		.string "X4  3   X", 0xA, 0xD
	       		.string "X 2     X", 0xA, 0xD
	       		.string "X27     X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board11_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X6   57 X", 0xA, 0xD
	       		.string "X  1  5 X", 0xA, 0xD
	       		.string "X     4 X", 0xA, 0xD
	       		.string "X63 1   X", 0xA, 0xD
	       		.string "X4  3   X", 0xA, 0xD
	       		.string "X 2     X", 0xA, 0xD
	       		.string "X27     X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board11_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X6OHO57SX", 0xA, 0xD
	       		.string "XDA1AQ5EX", 0xA, 0xD
	       		.string "XDA?OO4EX", 0xA, 0xD
	       		.string "X63M1ABEX", 0xA, 0xD
	       		.string "X4IO3OBEX", 0xA, 0xD
	       		.string "XN2OIIOEX", 0xA, 0xD
	       		.string "X27LLLLSX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board12_og: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X572    X", 0xA, 0xD
	       		.string "X    6 1X", 0xA, 0xD
	       		.string "X      6X", 0xA, 0xD
	       		.string "X      1X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X 3 7342X", 0xA, 0xD
	       		.string "X5     4X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board12_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X572    X", 0xA, 0xD
	       		.string "X    6 1X", 0xA, 0xD
	       		.string "X      6X", 0xA, 0xD
	       		.string "X      1X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X 3 7342X", 0xA, 0xD
	       		.string "X5     4X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board12_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X572FFFMX", 0xA, 0xD
	       		.string "XCE@?6R1X", 0xA, 0xD
	       		.string "XCE@MMR6X", 0xA, 0xD
	       		.string "XCENNMF1X", 0xA, 0xD
	       		.string "XCSSNGGNX", 0xA, 0xD
	       		.string "XC3S7342X", 0xA, 0xD
	       		.string "X5OHHOO4X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board13_og: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X  7 7  X", 0xA, 0xD
	       		.string "X  6514 X", 0xA, 0xD
	       		.string "X24     X", 0xA, 0xD
	       		.string "X6  53  X", 0xA, 0xD
	       		.string "X3    12X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board13_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X  7 7  X", 0xA, 0xD
	       		.string "X  6514 X", 0xA, 0xD
	       		.string "X24     X", 0xA, 0xD
	       		.string "X6  53  X", 0xA, 0xD
	       		.string "X3    12X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board13_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XNGGGGGNX", 0xA, 0xD
	       		.string "X@OIIIO@X", 0xA, 0xD
	       		.string "X@B7L7B@X", 0xA, 0xD
	       		.string "X@B6514@X", 0xA, 0xD
	       		.string "X24DCMM@X", 0xA, 0xD
	       		.string "X6KR53?@X", 0xA, 0xD
	       		.string "X3HHHO12X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board14_og: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X1 17462X", 0xA, 0xD
	       		.string "X5      X", 0xA, 0xD
	       		.string "X 3     X", 0xA, 0xD
	       		.string "X    4  X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X  76 5 X", 0xA, 0xD
	       		.string "X3     2X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board14_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X1 17462X", 0xA, 0xD
	       		.string "X5      X", 0xA, 0xD
	       		.string "X 3     X", 0xA, 0xD
	       		.string "X    4  X", 0xA, 0xD
	       		.string "X       X", 0xA, 0xD
	       		.string "X  76 5 X", 0xA, 0xD
	       		.string "X3     2X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board14_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X1F17462X", 0xA, 0xD
	       		.string "X5JQEBD@X", 0xA, 0xD
	       		.string "XO3CEBD@X", 0xA, 0xD
	       		.string "XAQQE4D@X", 0xA, 0xD
	       		.string "XACSSRR@X", 0xA, 0xD
	       		.string "XAC76R5@X", 0xA, 0xD
	       		.string "X3QJJJQ2X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board15_og: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X32    2X", 0xA, 0xD
	       		.string "X      1X", 0xA, 0xD
	       		.string "X53    7X", 0xA, 0xD
	       		.string "X 6 7  1X", 0xA, 0xD
	       		.string "X      5X", 0xA, 0xD
	       		.string "X   6  4X", 0xA, 0xD
	       		.string "X     4 X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board15_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X32    2X", 0xA, 0xD
	       		.string "X      1X", 0xA, 0xD
	       		.string "X53    7X", 0xA, 0xD
	       		.string "X 6 7  1X", 0xA, 0xD
	       		.string "X      5X", 0xA, 0xD
	       		.string "X   6  4X", 0xA, 0xD
	       		.string "X     4 X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board15_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X32GGGG2X", 0xA, 0xD
	       		.string "XOOMFFF1X", 0xA, 0xD
	       		.string "X53?SLL7X", 0xA, 0xD
	       		.string "XC6?7MF1X", 0xA, 0xD
	       		.string "XCDMFMQ5X", 0xA, 0xD
	       		.string "XCRK6QQ4X", 0xA, 0xD
	       		.string "XQJJJQ4OX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board16_og: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X 4    3X", 0xA, 0xD
	       		.string "X 23   5X", 0xA, 0xD
	       		.string "X  2  41X", 0xA, 0xD
	       		.string "X  5  6 X", 0xA, 0xD
	       		.string "X7      X", 0xA, 0xD
	       		.string "X 6     X", 0xA, 0xD
	       		.string "X71     X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board16_edit: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "X 4    3X", 0xA, 0xD
	       		.string "X 23   5X", 0xA, 0xD
	       		.string "X  2  41X", 0xA, 0xD
	       		.string "X  5  6 X", 0xA, 0xD
	       		.string "X7      X", 0xA, 0xD
	       		.string "X 6     X", 0xA, 0xD
	       		.string "X71     X", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0

board16_sol: 	.string "Completed: 0/7", 0xA, 0xD
				.string "Time: 0000", 0xA, 0xD
		   		.string "XXXXXXXXX", 0xA, 0xD
	       		.string "XP4OHHH3X", 0xA, 0xD
	       		.string "XB23QJJ5X", 0xA, 0xD
	       		.string "XBN2CP41X", 0xA, 0xD
	       		.string "XPP5QB6?X", 0xA, 0xD
	       		.string "X7PIIPD?X", 0xA, 0xD
	       		.string "XE6KKKR?X", 0xA, 0xD
	       		.string "X71FFFFMX", 0xA, 0xD
	       		.string "XXXXXXXXX", 0xA, 0xD, 0x0
