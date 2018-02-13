; Zhijie Jin
; zhijiej2
; MP2
; Write a program to evaluate postfix expressions using a stack
; User need to enter one charater at at time, if a char is invalid, print invalid onto screen
; Assume input expressions have a space between operators and operands and no trailing spaces
; Input only allow non-negative single digit (0-9), output can be both positive and negative
; Output is represented in hexidecimal (converted from 2's complement binary)
; Output is stored in R5
; In this program, a lot of subroutines are used

; Subroutines:
; EVALUATE: 1. Evaluate the charater entered by users. If valid R5=0, otherwise R5=1
;           2. Calls PLUS, MIN, MUL, DIV, EXP, PUSH, POP etc. subroutines
;	    3. Recognize operants and different operators and calls specific subroutines
; PUSH: Push value in R0 to stack
; POP: Pop value in R0 out
; PLUS: R3 + R4
; MIN: R3 - R4
; DIV: R3/R4
; MUL: R3*R4
; EXP: R3^R4
; PRINT_HEX: Prints the output of the input expression in hexadecimal representaiton
; ASCII_DIGIT: R0 <- R0 - 30
; DIGIT_ASCII: R0 <- R0 + 30

.ORIG x3000			; Program starts ar x3000
 
;your code goes here
; Register used:
; R1: temperary register
; R0: print on screen
; R5: store results from subroutines & stores the final result
; R3: store restults that needs to be printed
GET_EXPRESSION	
	GETC			; Get character from input
	OUT			; Echo the character on screen

CHECK_SEMICOLON
	LD R1, SEMICOLON	; Load ascii value of ";"
	NOT R1, R1		;
	ADD R1, R1, #1		; Negate R1(ASCII-;)
	ADD R1, R0, R1		; Check if the input is ;
	BRz CHECK_STACK		; If the input is ;, go to CHECK_STACK
	
CHECK_SPACE
	LD R1, SPACE		; Load ascii value of " "
	NOT R1, R1		; 
	ADD R1, R1, #1		; Negate R1(ASCII-SPACE)
	ADD R1, R0, R1		; Check if the input is SPACE
	BRz GET_EXPRESSION	; If the input is a space, get another input
	
	JSR EVALUATE		; Evaluate input
	ADD R5, R5, #0		; Load R5
	BRz GET_EXPRESSION	; If R5=0, get the next char
	
INVALID
	LEA R0, INVALID_EXP	; Load the start point of the string
	PUTS			; Print the string
	BRnzp DONE		; DONE


CHECK_STACK
	JSR POP			; POP a value out
	ST R0, SAVE_RESULT	; Store the value at the STACK_TOP
	JSR POP			; Perform another POP
	ADD R5, R5, #-1		; If underflow(R5=1), it was the last value in stack
	BRnp INVALID
	
PRINT_VALUE
	LD R0, SAVE_RESULT	; Load ASCII value needs to be printed to R0
	JSR ASCII_DIGIT
	AND R3, R3, #0		; Clear R3
	ADD R3, R3, R0		; Load converted digital number to R3
	JSR PRINT_HEX		; Print Hex value of the result
	BRnzp DONE

DONE 
	LD R0, SAVE_RESULT	; Load ASCII value needs to be printed to R0
	JSR ASCII_DIGIT
	ADD R5, R0, #0		; Store the final resutl in R5
	HALT

; Pseudo-Ops
SPACE		.FILL x0020
SEMICOLON	.FILL x003B
INVALID_EXP	.STRINGZ "Invalid Expression"
SAVE_RESULT	.BLKW #1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;R3- value to print in hexadecimal
PRINT_HEX
	ST R0, SAVER0_PRT	; Store R0
	ST R1, SAVER1_PRT	; Store R1
	ST R2, SAVER2_PRT	; Store R2
	ST R3, SAVER3_PRT	; Store R3
	ST R4, SAVER4_PRT	; Store R4
	ST R5, SAVER3_PRT	; Store R5
	ST R6, SAVER4_PRT	; Store R6
	ST R7, SAVER7_PRT	; Store R7


	LD R0, LETTER_x		; Load ASCII value of x to R0	
	OUT
	; Initialize R4 as a 4 bit letter counter
 	AND R4, R4, #0		; Clear R4
 	ADD R4, R4, #4		; R4 = 4
L1	BRnz DONE_PRT		; End program if all letters have been printed
	AND R0, R0, #0		; Initialize R0 to hold digits

	; Initialize R2 as a 4 bit digit counter
	AND R2, R2, #0		; Clear R2
	ADD R2, R2, #4		; R2 = 4
	
L2	BRnz ASCII		; Branch to print characters on the screen
	ADD R3, R3, #0		; Load values in R3 to R3
	BRn ONE			; Branch to ONE if R3 < 0

ZERO	; If R3 >= 0, shift right	
	ADD R0, R0, R0		; Load R0
	BRnzp NEXT

	; If R3 < 0, shift right and add 1
ONE	ADD R0, R0, R0		; Load R0
	ADD R0, R0, #1		; Increment R0

NEXT	ADD R3, R3, R3		; Shift R3 left
	ADD R2, R2, #-1		; Decrement R2
	BRnzp L2

ASCII	ADD R0, R0, #0		; Initialize R0
	ADD R6, R0, #-9		; See if R0 is <= 9

	BRnz OTHER		; Branch to OTHER if R0 <= 9
	LD R7, LETTER		; Load ASCII character A to R7

	; If R0 <= 9, print proper numbers
	ADD R0, R0, #-10	; Subtract 10 from R0
	ADD R0, R0, R7		; ADD R0 and R7
	BRnzp OUTPUT

OTHER	; If R0 > 9, print proper letters
	LD R7, NUMBER
	ADD R0, R0, R7

OUTPUT	
	OUT			; Print to screen
	ADD R4, R4, #-1		; Decrement letter counter
	BRnzp L1

DONE_PRT	
	LD R0, SAVER0_PRT	; Restore R0
	LD R1, SAVER1_PRT	; Restore R1
	LD R2, SAVER2_PRT	; Restore R2
	LD R3, SAVER3_PRT	; Restore R3
	LD R4, SAVER4_PRT	; Restore R4
	LD R5, SAVER3_PRT	; Restore R5
	LD R6, SAVER4_PRT	; Restore R6
	LD R7, SAVER7_PRT	; Restore R7
	RET

; Pseudo-Ops
LETTER		.FILL x0041  	; ASCII-A
NUMBER		.FILL x0030 	; ASCII-0
LETTER_x	.FILL x0078 	; ASCII-x
SAVER0_PRT	.BLKW #1
SAVER1_PRT	.BLKW #1
SAVER2_PRT	.BLKW #1
SAVER3_PRT	.BLKW #1
SAVER4_PRT	.BLKW #1
SAVER5_PRT	.BLKW #1
SAVER6_PRT	.BLKW #1
SAVER7_PRT	.BLKW #1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;R0 - character input from keyboard
;R6 - current numerical output
;OUT: R5 (0-success, 1-fail/underflow)
;
EVALUATE
;your code goes here
	ST R0, SAVER0_EVA	; Store R0
	ST R1, SAVER1_EVA	; Store R1
	ST R2, SAVER2_EVA	; Store R2
	ST R3, SAVER3_EVA	; Store R3
	ST R4, SAVER4_EVA	; Store R4
	ST R7, SAVER7_EVA	; Store R7

	AND R5, R5, #0		; Initialize R5

CHECK_OPERANT
	LD R1, CHECK_NUM1	; CHECK_NUM1 is the ASCII representation of 0
	LD R2, CHECK_NUM2	; CHECK_NUM2 is the ASCII representation of 9
	NOT R1, R1		;
	ADD R1, R1, #1		; Negate R1(ASCII-0) 
	NOT R2, R2		;
	ADD R2, R2, #1		; Negate R2(ASCII-9)

	ADD R1, R0, R1		; Check if the input is less than 0
	BRn CHECK_OPERATOR	; If R0<0, Check if it is an operator
	ADD R2, R0, R2		; Check if the input is greater than 9
	BRp CHECK_OPERATOR	; If R0>9, Check if it is an operator
	JSR PUSH		; If 0<=R0<=9, PUSH it to the stack
	BRnzp RESTORE_EVA	; Restore Registers
	
CHECK_OPERATOR
	; Check if the input is a plus sign
	LD R1, CHECK_PLUS	; CHECK_MIN contains ASCII value of a plus sign
	NOT R1, R1		; 
	ADD R1, R1, #1		; Negate R1(ASCII-+)
	ADD R1, R0, R1		; Check if it is a plus
	BRz EVA_PLUS		; If it is a plus, perform plus

	; Check if the input is a minus sign
	LD R1, CHECK_MIN	; CHECK_PLUS contains ASCII value of a minus sign
	NOT R1, R1		;
	ADD R1, R1, #1		; Negate R1(ASCII--)
	ADD R1, R0, R1		; Check if it is a minus
	BRz EVA_MIN		; If it is a minus, perform minus

	; Check if the input is a multiply sign
	LD R1, CHECK_MUL	; CHECK_MUL contains ASCII value of a multiply sign
	NOT R1, R1		;
	ADD R1, R1, #1		; Negate R1(ASCII-*)
	ADD R1, R0, R1		; Check if it is a multiply
	BRz EVA_MUL		; If it is a multiply, perfor multiply

	; Check if the input is a division sign
	LD R1, CHECK_DIV	; CHECK_DIV contains ASCII value of a division sign
	NOT R1, R1		;
	ADD R1, R1, #1		; Negate R1(ASCII-/)
	ADD R1, R0, R1		; Check if it is a division
	BRz EVA_DIV		; If it is a division, perform division

	; Check if the input is an exponential sign
	LD R1, CHECK_EXP	; CHECK_EXP contains ASCII value of exponential sign
	NOT R1, R1		;
	ADD R1, R1, #1		; Negate R1(ASCII-^)
	ADD R1, R0, R1		; Check if it is an exponential
	BRz EVA_EXP		; If it is an exponential, perform exponential

INVALID_EVA
	AND R5, R5, #0		; Clear R5
	ADD R5, R5, #1		; Set R5 to 1 if the expression is invalid
	BRnzp RESTORE_EVA	; Branch to restore registers

EVA_PLUS
	JSR POP			; POP the first operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R4, R4, #0		; If R5 is 0, Clear R4
	JSR ASCII_DIGIT
	ADD R4, R4, R0		; ADD value in R0 to R4
	;
	JSR POP			; POP the second operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R3, R3, #0		; If R5 is 0, Clear R3
	JSR ASCII_DIGIT
	ADD R3, R3, R0		; ADD value in R0 to R3
	;
	JSR PLUS		; Perform PLUS for R3 and R4
	JSR DIGIT_ASCII
	JSR PUSH		; Push the result back to stack
	BRnzp RESTORE_EVA	; Restore registers

EVA_MIN
	JSR POP			; POP the first operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R4, R4, #0		; If R5 is 0, Clear R4
	JSR ASCII_DIGIT
	ADD R4, R4, R0		; ADD value in R0 to R4
	;
	JSR POP			; POP the second operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R3, R3, #0		; If R5 is 0, Clear R3
	JSR ASCII_DIGIT
	ADD R3, R3, R0		; ADD value in R0 to R3
	;
	JSR MIN			; Perform minus
	JSR DIGIT_ASCII
	JSR PUSH		; Push the result back to stack
	BRnzp RESTORE_EVA	; Restore registers

EVA_MUL
	JSR POP			; POP the first operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R4, R4, #0		; If R5 is 0, Clear R4
	JSR ASCII_DIGIT
	ADD R4, R4, R0		; ADD value in R0 to R4
	;
	JSR POP			; POP the second operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R3, R3, #0		; If R5 is 0, Clear R3
	JSR ASCII_DIGIT
	ADD R3, R3, R0		; ADD value in R0 to R3
	;
	JSR MUL			; Perform multiply
	JSR DIGIT_ASCII
	JSR PUSH		; Push the result back to stack
	BRnzp RESTORE_EVA	; Restore Registers 

EVA_DIV
	JSR POP			; POP the first operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R4, R4, #0		; If R5 is 0, Clear R4
	JSR ASCII_DIGIT
	ADD R4, R4, R0		; ADD value in R0 to R4
	;
	JSR POP			; POP the second operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R3, R3, #0		; If R5 is 0, Clear R3
	JSR ASCII_DIGIT
	ADD R3, R3, R0		; ADD value in R0 to R3
	;
	JSR DIV			; Perform Division
	JSR DIGIT_ASCII
	JSR PUSH		; Push the result back to stack			
	BRnzp RESTORE_EVA	; Restore Registers

EVA_EXP
	JSR POP			; POP the first operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R4, R4, #0		; If R5 is 0, Clear R4
	JSR ASCII_DIGIT
	ADD R4, R4, R0		; ADD value in R0 to R4
	;
	JSR POP			; POP the second operant
	ADD R5, R5, #-1		; Check R5
	BRz INVALID_EVA		; If R5 is 1, go to INVALID_EVA
	AND R3, R3, #0		; If R5 is 0, Clear R3
	JSR ASCII_DIGIT
	ADD R3, R3, R0		; ADD value in R0 to R3
	;
	JSR EXP			; Perform exponential
	JSR DIGIT_ASCII
	JSR PUSH		; Push the result back to stack
	BRnzp RESTORE_EVA	; Restore registers

RESTORE_EVA
	LD R0, SAVER0_EVA	; Restore R0
	LD R1, SAVER1_EVA	; Restore R1
	LD R2, SAVER2_EVA	; Restore R2
	LD R3, SAVER3_EVA	; Restore R3
	LD R4, SAVER4_EVA	; Restore R4
	LD R7, SAVER7_EVA	; Restore R7
	RET

; Pseudo-Ops
CHECK_NUM1	.FILL x0030	; ASCII-0
CHECK_NUM2	.FILL x0039	; ASCII-9
CHECK_PLUS	.FILL x002B	; ASCII-+
CHECK_MIN	.FILL x002D	; ASCII--
CHECK_MUL	.FILL x002A	; ASCII-*
CHECK_DIV	.FILL x002F	; ASCII-/
CHECK_EXP	.FILL x005E	; ASCII-^
SAVER0_EVA	.BLKW #1
SAVER1_EVA	.BLKW #1
SAVER2_EVA	.BLKW #1
SAVER3_EVA	.BLKW #1
SAVER4_EVA	.BLKW #1
SAVER7_EVA	.BLKW #1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R0
;out R0
;Turn ASCII numbers to digit numbers
ASCII_DIGIT
	ST R7, SAVER7_A2D
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	LD R7, SAVER7_A2D
	RET

; Pseudo-Ops
SAVER7_A2D	.BLKW #1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R0
;out R0
;Turn digit numbers to ASCII numbers
DIGIT_ASCII
	ST R7, SAVER7_D2A
	ADD R0, R0, #12
	ADD R0, R0, #12
	ADD R0, R0, #12
	ADD R0, R0, #12
	LD R7, SAVER7_D2A
	RET
SAVER7_D2A	.BLKW #1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
PLUS	
;your code goes here
	ST R3, SAVER3_PLUS	; Save value in R3 to SAVER3
	ST R4, SAVER4_PLUS	; Save value in R4 to SAVER4
	
	ADD R0, R3, R4		; ADD R3 and R4. Store the result in R0.

	LD R3, SAVER3_PLUS	; Restore value in R3 from SAVER3
	LD R4, SAVER4_PLUS	; Restore value in R4 from SAVER4
	RET
	
; Pseudo-Ops
SAVER3_PLUS	.BLKW #1
SAVER4_PLUS	.BLKW #1
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
MIN	
;your code goes here
	ST R3, SAVER3_MIN	; Save value in R3 to SAVER3
	ST R4, SAVER4_MIN	; Save value in R4 to SAVER4

	NOT R4, R4		; 
	ADD R4, R4, #1		; Negate R4
	ADD R0, R3, R4		; ADD R3 and R4. Store the result in R0.
	
	LD R3, SAVER3_MIN	; Restore value in R3 from SAVER3
	LD R4, SAVER4_MIN	; Restore value in R4 from SAVER4
	RET
	
; Pseudo-Ops
SAVER3_MIN	.BLKW #1
SAVER4_MIN	.BLKW #1
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
MUL	
;your code goes here
	ST R3, SAVER3_MUL	; Save value in R3 to SAVER3
	ST R4, SAVER4_MUL	; Save value in R4 to SAVER4
	
	ADD R4, R4, #0		; Load R4
	BRz ZERO_MUL		
	AND R0, R0, #0		; Initialize R0
	
LOOP_MUL
	ADD R0, R0, R3		; ADD R3 and R4. Store the result in R0.
	ADD R4, R4, #-1		; Decrement R4 by 1
	BRp LOOP_MUL		; Loop
	
RESTORE_MUL
	LD R3, SAVER3_MUL	; Restore value in R3 from SAVER3
	LD R4, SAVER4_MUL	; Restore value in R4 from SAVER4
	RET

ZERO_MUL
	AND R0, R0, #0
	BRnzp RESTORE_MUL
	
; Pseudo-Ops
SAVER3_MUL	.BLKW #1
SAVER4_MUL	.BLKW #1
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
DIV	
;your code goes here
	ST R3, SAVER3_DIV	; Save value in R3 to SAVER3
	ST R4, SAVER4_DIV	; Save value in R4 to SAVER4
	
	ADD R4, R4, #0		; Load R4
	BRz ZERO_DIV		
	AND R0, R0, #0		; Initialize R0
	NOT R4, R4		; 
	ADD R4, R4, #1		;Negate R4

LOOP_DIV
	ADD R0, R0, #1		; Increment R0 by 1
	ADD R3, R3, R4		; Subtract R4 from R3
	BRzp LOOP_DIV		; LOOP back
	ADD R0, R0, #-1		; Minus 1 from R0 because Loop make result 1 bigger
	
RESTORE_DIV
	LD R3, SAVER3_DIV	; Restore value in R3 from SAVER3
	LD R4, SAVER4_DIV	; Restore value in R4 from SAVER4
	RET

ZERO_DIV
	LD R0, EXCEPTION_DIV
	BRnzp RESTORE_DIV
	
; Pseudo-Ops
SAVER3_DIV	.BLKW #1
SAVER4_DIV	.BLKW #1
EXCEPTION_DIV	.FILL x0021
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
EXP
;your code goes here
	ST R3, SAVER3_EXP	; Save value in R3 to SAVER3
	ST R4, SAVER4_EXP	; Save value in R4 to SAVER4
	ST R5, SAVER5_EXP	; Save value in R5 to SAVER5
	ST R7, SAVER7_EXP	; Save value in R7 to SAVER7
	
	AND R5, R5, #0		; Clear R5
	ADD R5, R5, R4		; Put the expomential to R5
	BRz ONE_EXP		; Branch to ONE_EXP is expomential = 0
	ADD R5, R5, #-1		; Subtract 1 from exponential(eg.4^2=4*4)
				; Just need one MUL
	BRz SELF_EXP		; If exponential is 1, branch to SELF_EXP
	AND R4, R4, #0		; Clear R4
	ADD R4, R4, R3		; Put Value in R3 to R4

LOOP_EXP
	JSR MUL
	AND R4, R4, #0		; Clear R4
	ADD R4, R4, R0		; Put the result from MUL to R4
	ADD R5, R5, #-1		; Decrement R5(How many MUL needed to get the result)
	BRp LOOP_EXP

RESTORE_EXP
	LD R3, SAVER3_EXP	; Restore value in R3 from SAVER3
	LD R4, SAVER4_EXP	; Restore value in R4 from SAVER4
	LD R5, SAVER5_EXP	; Restore value in R5 from SAVER5
	LD R7, SAVER7_EXP	; Restore value in R7 from SAVER7
	RET

ONE_EXP
	AND R0, R0, #0		; Clear R0
	ADD R0, R0, #1		; If Exponential=0, result is 1
	BRnzp RESTORE_EXP

SELF_EXP
	AND R0, R0, #0		; Clear R0
	ADD R0, R0, R3		; If Exponential=1, result is R3
	BRnzp RESTORE_EXP

; Pseudo-Ops
SAVER3_EXP	.BLKW #1
SAVER4_EXP	.BLKW #1
SAVER5_EXP	.BLKW #1
SAVER7_EXP	.BLKW #1
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IN:R0, OUT:R5 (0-success, 1-fail/overflow)
;R3: STACK_END R4: STACK_TOP
;
PUSH	
	ST R3, PUSH_SaveR3	;save R3
	ST R4, PUSH_SaveR4	;save R4
	AND R5, R5, #0		;
	LD R3, STACK_END	;
	LD R4, STACk_TOP	;
	ADD R3, R3, #-1		;
	NOT R3, R3		;
	ADD R3, R3, #1		;
	ADD R3, R3, R4		;
	BRz OVERFLOW		;stack is full
	STR R0, R4, #0		;no overflow, store value in the stack
	ADD R4, R4, #-1		;move top of the stack
	ST R4, STACK_TOP	;store top of stack pointer
	BRnzp DONE_PUSH		;
OVERFLOW
	ADD R5, R5, #1		;
DONE_PUSH
	LD R3, PUSH_SaveR3	;
	LD R4, PUSH_SaveR4	;
	RET


PUSH_SaveR3	.BLKW #1	;
PUSH_SaveR4	.BLKW #1	;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;OUT: R0, OUT R5 (0-success, 1-fail/underflow)
;R3 STACK_START R4 STACK_TOP
;
POP	
	ST R3, POP_SaveR3	;save R3
	ST R4, POP_SaveR4	;save R3
	AND R5, R5, #0		;clear R5
	LD R3, STACK_START	;
	LD R4, STACK_TOP	;
	NOT R3, R3		;
	ADD R3, R3, #1		;
	ADD R3, R3, R4		;
	BRz UNDERFLOW		;
	ADD R4, R4, #1		;
	LDR R0, R4, #0		;
	ST R4, STACK_TOP	;
	BRnzp DONE_POP		;
UNDERFLOW
	ADD R5, R5, #1		;
DONE_POP
	LD R3, POP_SaveR3	;
	LD R4, POP_SaveR4	;
	RET


POP_SaveR3	.BLKW #1	;
POP_SaveR4	.BLKW #1	;
STACK_END	.FILL x3FF0	;
STACK_START	.FILL x4000	;
STACK_TOP	.FILL x4000	;


.END
