;
; The code given to you here implements the histogram calculation that 
; we developed in class.  In programming studio, we will add code that
; prints a number in hexadecimal to the monitor.
;
; Your assignment for this program is to combine these two pieces of 
; code to print the histogram to the monitor.
;
; If you finish your program, 
;    ** commit a working version to your repository  **
;    ** (and make a note of the repository version)! **


	.ORIG	x3000		; starting address is x3000


;
; Count the occurrences of each letter (A to Z) in an ASCII string 
; terminated by a NUL character.  Lower case and upper case should 
; be counted together, and a count also kept of all non-alphabetic 
; characters (not counting the terminal NUL).
;
; The string starts at x4000.
;
; The resulting histogram (which will NOT be initialized in advance) 
; should be stored starting at x3F00, with the non-alphabetic count 
; at x3F00, and the count for each letter in x3F01 (A) through x3F1A (Z).
;
; table of register use in this part of the code
;    R0 holds a pointer to the histogram (x3F00)
;    R1 holds a pointer to the current position in the string
;       and as the loop count during histogram initialization
;    R2 holds the current character being counted
;       and is also used to point to the histogram entry
;    R3 holds the additive inverse of ASCII '@' (xFFC0)
;    R4 holds the difference between ASCII '@' and 'Z' (xFFE6)
;    R5 holds the difference between ASCII '@' and '`' (xFFE0)
;    R6 is used as a temporary register
;
; IN the second part of the the program (my code), table of register used
;    R0 is used as register to print on screen
;    R1 is used as a counter to count 27
;    R2 is used as a 4 bit digit counter
;    R3 is used to store the number of occurence of each letter
;    R4 is used as a 4 bit letter/number counter
;    R5 is used as a location pointer for histgram
;    R6 is used to store ascii representation of "?"
;    R7 is used as a temperary register
;
	LD R0,HIST_ADDR      	; point R0 to the start of the histogram
	
	; fill the histogram with zeroes 
	AND R6,R6,#0		; put a zero into R6
	LD R1,NUM_BINS		; initialize loop count to 27
	ADD R2,R0,#0		; copy start of histogram into R2

	; loop to fill histogram starts here
HFLOOP	STR R6,R2,#0		; write a zero into histogram
	ADD R2,R2,#1		; point to next histogram entry
	ADD R1,R1,#-1		; decrement loop count
	BRp HFLOOP		; continue until loop count reaches zero

	; initialize R1, R3, R4, and R5 from memory
	LD R3,NEG_AT		; set R3 to additive inverse of ASCII '@'
	LD R4,AT_MIN_Z		; set R4 to difference between ASCII '@' and 'Z'
	LD R5,AT_MIN_BQ		; set R5 to difference between ASCII '@' and '`'
	LD R1,STR_START		; point R1 to start of string

	; the counting loop starts here
COUNTLOOP
	LDR R2,R1,#0		; read the next character from the string
	BRz PRINT_HIST		; found the end of the string

	ADD R2,R2,R3		; subtract '@' from the character
	BRp AT_LEAST_A		; branch if > '@', i.e., >= 'A'
NON_ALPHA
	LDR R6,R0,#0		; load the non-alpha count
	ADD R6,R6,#1		; add one to it
	STR R6,R0,#0		; store the new non-alpha count
	BRnzp GET_NEXT		; branch to end of conditional structure
AT_LEAST_A
	ADD R6,R2,R4		; compare with 'Z'
	BRp MORE_THAN_Z         ; branch if > 'Z'

; note that we no longer need the current character
; so we can reuse R2 for the pointer to the correct
; histogram entry for incrementing
ALPHA	ADD R2,R2,R0		; point to correct histogram entry
	LDR R6,R2,#0		; load the count
	ADD R6,R6,#1		; add one to it
	STR R6,R2,#0		; store the new count
	BRnzp GET_NEXT		; branch to end of conditional structure

; subtracting as below yields the original character minus '`'
MORE_THAN_Z
	ADD R2,R2,R5		; subtract '`' - '@' from the character
	BRnz NON_ALPHA		; if <= '`', i.e., < 'a', go increment non-alpha
	ADD R6,R2,R4		; compare with 'z'
	BRnz ALPHA		; if <= 'z', go increment alpha count
	BRnzp NON_ALPHA		; otherwise, go increment non-alpha

GET_NEXT
	ADD R1,R1,#1		; point to next character in string
	BRnzp COUNTLOOP		; go to start of counting loop


; My program starts here
; This part of program print the histgram representing the string
; Register used:
; R0 is used as register to print on screen
; R1 is used as a counter to count 27
; R2 is used as a 4 bit digit counter
; R3 is used to store the number of occurence of each letter
; R4 is used as a 4 bit letter/number counter
; R5 is used as a location pointer for histgram
; R6 is used to store ascii representation of "?"
; R7 is used as a temperary register
;
PRINT_HIST
	LD R6, ASCII_QUE	; load ascii representation of "?"
	LD R1, NUM_BINS		; initialize loop count to 27
	LD R5, HIST_ADDR	; load the address of histgram to R5
				; each address contains the number of letters
				; that needs to be printed on in the histgram

PRINT_LETTER
	ADD R6, R6, #1		; increment R0 to print next letter
	AND R0, R0, #0		; clear R0
	ADD R0, R0, R6		; load content in R6 to R0
	OUT			; print letters
	
	LD R0, SPACE		; load an ascii representation of a space to R0
	OUT			; print spaces
	
	LDR R3, R5, #0		; load numbers in R5 to R3
 	AND R4, R4, #0		; clear R4
 	ADD R4, R4, #4		; initialize R4 as a 4 bit letter/number counter
	
L1	
	BRnz NEXT_LINE		; print next row in histgram
	AND R0, R0, #0		; initialize R0 to hold digits
	AND R2, R2, #0		; clear R2
	ADD R2, R2, #4		; initialize R2 as a 4 bit digit counter
	
L2	
	BRnz ASCII		; branch to print characters on the screen
	ADD R3, R3, #0		; load values in R3 to R3
	BRn ONE			; branch to ONE if R3 < 0
		
ZERO	
	ADD R0, R0, R0		; if R3 >= 0, R0 shift right
	BRnzp NEXT
	
ONE	
	ADD R0, R0, R0		; if R3 < 0, shift right and add 1
	ADD R0, R0, #1

NEXT	
	ADD R3, R3, R3		; shift R3 left
	ADD R2, R2, #-1		; decrement R2
	BRnzp L2

ASCII	
	ADD R0, R0, #0		; initialize R0
	ADD R7, R0, #-9		; check if R0 is <= 9
	BRnz OTHER		; branch to OTHER if R0 <= 9
	LD R7, LETTER		; load ASCII character A to R7

	; If R0 <= 9, print proper numbers
	ADD R0, R0, #-10	; subtract 10 from R0
	ADD R0, R0, R7		; compute hex number that represent the letter
	BRnzp OUTPUT
	
	; if R0 > 9, print proper letters
OTHER	
	LD R7, NUMBER		; load ascii number 0 to R0
	ADD R0, R0, R7		; compute hex number that represent the letter
	
OUTPUT	
	OUT			; print single letter/number to screen
	ADD R4, R4, #-1		; decrement letter counter
	BRnzp L1		; branch back to print next letter/number
	
Next_LINE
	ADD R5, R5, #1		; increment pointer
	LD R0, NEW_LN		; load ascii representation of new_line to R0
	OUT			; print new line
	ADD R1, R1, #-1		; decrement counter
	BRp PRINT_LETTER	; branch back to print next row


DONE	HALT			; done


; the data needed by the program
NUM_BINS	.FILL #27	; 27 loop iterations
NEG_AT		.FILL xFFC0	; the additive inverse of ASCII '@'
AT_MIN_Z	.FILL xFFE6	; the difference between ASCII '@' and 'Z'
AT_MIN_BQ	.FILL xFFE0	; the difference between ASCII '@' and '`'
HIST_ADDR	.FILL x3F00     ; histogram starting address
STR_START	.FILL x4000	; string starting address

; new data entered
ASCII_QUE	.FILL x003F	; ascii representation of question mark
SPACE		.FILL x0020	; ascii representation of space
NEW_LN		.FILL x000A	; ascii representation of new line
LETTER	.FILL x0041  		; ASCII representation of letter A
NUMBER	.FILL x0030  		; ASCII representation of number 0


; for testing, you can use the lines below to include the string in this
; program...
; STR_START	.FILL STRING	; string starting address
; STRING		.STRINGZ "This is a test of the counting frequency code.  AbCd...WxYz."



	; the directive below tells the assembler that the program is done
	; (so do not write any code below it!)

	.END
