/* Zhijie Jin
 * zhijiej2
 * Introduction:
 * This program is to create a guess-and-matching game.
 * The program generate four digit between 1-8 and the player need to guess these numbers
 * At each guess, print out the number of perfect matches and misplaced matches
 *
 * There are 3 functions in the program
 * set_seed: set the seed for rand() function
 * start_game: generate 4 numbers from 1 - 8
 * make_guess: get the guessed number and compare them to the solutions
 * 
 *
 * prog5.c - source file adapted from UIUC ECE198KL Spring 2013 Program 4
 *           student code -- GOLD VERSION by Steven S. Lumetta
 */


/*
 * The functions that you must write are defined in the header file.
 * Blank function prototypes with explanatory headers are provided
 * in this file to help you get started.
 */



#include <stdio.h>
#include <stdlib.h>

#include "prog5.h"


/*
 * You will need to keep track of the solution code using file scope
 * variables as well as the guess number.
 */

static int guess_number;
static int solution1;
static int solution2;
static int solution3;
static int solution4;


/*
 * set_seed -- This function sets the seed value for pseudorandom
 * number generation based on the number the user types.
 * The input entered by the user is already stored in the string seed_str by the code in main.c.
 * This function should use the function sscanf to find the integer seed value from the 
 * string seed_str, then initialize the random number generator by calling srand with the integer
 * seed value. To be valid, exactly one integer must be entered by the user, anything else is invalid. 
 * INPUTS: seed_str -- a string (array of characters) entered by the user, containing the random seed
 * OUTPUTS: none
 * RETURN VALUE: 0 if the given string is invalid (string contains anything
 *               other than a single integer), or 1 if string is valid (contains one integer)
 * SIDE EFFECTS: initializes pseudo-random number generation using the function srand. Prints "set_seed: invalid seed\n"
 *               if string is invalid. Prints nothing if it is valid.
 */
int
set_seed (const char seed_str[])
{
//    Example of how to use sscanf to read a single integer and check for anything other than the integer
//    "int seed" will contain the number typed by the user (if any) and the string "post" will contain anything after the integer
//    The user should enter only an integer, and nothing else, so we will check that only "seed" is read. 
//    We declare
//    int seed;
//    char post[2];
//    The sscanf statement below reads the integer into seed. 
//    sscanf (seed_str, "%d%1s", &seed, post)
//    If there is no integer, seed will not be set. If something else is read after the integer, it will go into "post".
//    The return value of sscanf indicates the number of items read succesfully.
//    When the user has typed in only an integer, only 1 item should be read sucessfully. 
//    Check that the return value is 1 to ensure the user enters only an integer. 
//    Feel free to uncomment these statements, modify them, or delete these comments as necessary. 

	int seed;
	char post[2];
	// if the integer was set successfully but post not, set set
	if (1 == sscanf(seed_str, "%d%1s", &seed, post)) {
		// set seed
		srand(seed);
		return 1; // return 1 if seed was set
	}
	// Print warning
	else {
		printf("set_seed: invalid seed\n");
		return 0; // return 0 if input was invalid
	}

}


/*
 * start_game -- This function is called by main.c after set_seed but before the user makes guesses.
 *               This function creates the four solution numbers using the approach
 *               described in the wiki specification (using rand())
 *               The four solution numbers should be stored in the static variables defined above. 
 *               The values at the pointers should also be set to the solution numbers.
 *               The guess_number should be initialized to 1 (to indicate the first guess)
 * INPUTS: none
 * OUTPUTS: *one -- the first solution value (between 1 and 8)
 *          *two -- the second solution value (between 1 and 8)
 *          *three -- the third solution value (between 1 and 8)
 *          *four -- the fourth solution value (between 1 and 8)
 * RETURN VALUE: none
 * SIDE EFFECTS: records the solution in the static solution variables for use by make_guess, set guess_number
 */
void
start_game (int* one, int* two, int* three, int* four)
{
    //your code here
    *one = rand() % 8 + 1;		// Calculate the first solution
    *two = rand() % 8 + 1;		// calculate the second solution
    *three = rand() % 8 + 1;	// calculate the third solution
    *four = rand() % 8 + 1;		// calculate the fourth solution
    
    guess_number = 1;					// Set guess_number to 1
    solution1 = *one;					// set the global solution1
    solution2 = *two;					// set the golbal solution2
    solution3 = *three;				// set the golbal solution2
    solution4 = *four;				// set the golbal solution2
    
    //printf("%d, %d, %d, %d \n", solution1, solution2, solution3, solution4);
}

/*
 * make_guess -- This function is called by main.c after the user types in a guess.
 *               The guess is stored in the string guess_str. 
 *               The function must calculate the number of perfect and misplaced matches
 *               for a guess, given the solution recorded earlier by start_game
 *               The guess must be valid (contain only 4 integers, within the range 1-8). If it is valid
 *               the number of correct and incorrect matches should be printed, using the following format
 *               "With guess %d, you got %d perfect matches and %d misplaced matches.\n"
 *               If valid, the guess_number should be incremented.
 *               If invalid, the error message "make_guess: invalid guess\n" should be printed and 0 returned.
 *               For an invalid guess, the guess_number is not incremented.
 * INPUTS: guess_str -- a string consisting of the guess typed by the user
 * OUTPUTS: the following are only valid if the function returns 1 (A valid guess)
 *          *one -- the first guess value (between 1 and 8)
 *          *two -- the second guess value (between 1 and 8)
 *          *three -- the third guess value (between 1 and 8)
 *          *four -- the fourth color value (between 1 and 8)
 * RETURN VALUE: 1 if the guess string is valid (the guess contains exactly four
 *               numbers between 1 and 8), or 0 if it is invalid
 * SIDE EFFECTS: prints (using printf) the number of matches found and increments guess_number(valid guess) 
 *               or an error message (invalid guess)
 *               (NOTE: the output format MUST MATCH EXACTLY, check the wiki writeup)
 */
int
make_guess (const char guess_str[], int* one, int* two, 
	    int* three, int* four)
{
//  One thing you will need to read four integers from the string guess_str, using a process
//  similar to set_seed
//  The statement, given char post[2]; and four integers w,x,y,z,
//  sscanf (guess_str, "%d%d%d%d%1s", &w, &x, &y, &z, post)
//  will read four integers from guess_str into the integers and read anything else present into post
//  The return value of sscanf indicates the number of items sucessfully read from the string.
//  You should check that exactly four integers were sucessfully read.
//  You should then check if the 4 integers are between 1-8. If so, it is a valid guess
//  Otherwise, it is invalid.  
//  Feel free to use this sscanf statement, delete these comments, and modify the return statement as needed

	// Delcare int variables needed
	// perfect is used to store the number of perfect matches
	// misplaced is used to store the number of misplaced matches
 	int guess1, guess2, guess3, guess4, perfect=0, misplaced=0;
	char post[2]; // store everthing besides four guessed numbers
	// assign the return value from sscanf to sscan
	int sscan = sscanf(guess_str, "%d%d%d%d%1s", &guess1, &guess2, &guess3, &guess4, post);
	// Check if sscan is 4 and if all the numbers from the user input is >=1 and <= 8.
	if (sscan == 4 &&
	    guess1 >=1 && guess1 <=8 && 
			guess2 >=1 && guess2 <=8 &&
			guess3 >=1 && guess3 <=8 &&
			guess4 >=1 && guess4 <=8) 
	{
		// create two arrays, perfectArray stores all the solutions, guessArray stores all the guesses
		int perfectArray[4] = {solution1, solution2, solution3, solution4};
 		int guessArray[4] = {guess1, guess2, guess3, guess4};
 		
 		/* Four if statements are used to calculate the number of perfect matches
 			 If there is a matching, set both number in the arrays to 0
 			 This doesn't affect the global variables and guesses in the pointer
 		*/
 		// Check the first number
		if (guess1 == solution1) {
			perfectArray[0] = 0;
			guessArray[0] = 0; 
			perfect++; 
		}
		// Check the second number
		if (guess2 == solution2) {
			perfectArray[1] = 0;
			guessArray[1] = 0; 
			perfect++; 
	  }
	  // Check the third number
		if (guess3 == solution3) { 
			perfectArray[2] = 0;
			guessArray[2] = 0; 
			perfect++; 
		}
		// Check the fourth number
		if (guess4 == solution4) { 
			perfectArray[3] = 0;
			guessArray[3] = 0; 
			perfect++; 
		}
		
		/* Loop through two arrays to find out the number of misplaced matchings
			 Since some number in the arrays has already been set to 0,
			 we don't have to warry about overcounting
		*/
		int i;
		for (i = 0; i < 4; i++) {
			int j;
			for (j = 0; j < 4; j++) {
				// if the number at the index is not 0 and there are matching, increase misplaced
				if (perfectArray[i]!=0 && perfectArray[i]==guessArray[j]) {
					perfectArray[i] = 0;
					guessArray[j] = 0;
					misplaced = misplaced + 1;
				}
				else continue;

			}
		}
		
		// Printing the # of guess, # of perfect matches and # of misplaced matches
		printf("With guess %d, you got %d perfect matches and %d misplaced matches.\n", guess_number, perfect, misplaced);
		// Increment guess_number
		guess_number = guess_number + 1;
		
		// Set the guessed numbers to the content of the pointers
		*one = guess1;
		*two = guess2;
		*three = guess3;
		*four = guess4;
		return 1;
	}
	else 
	{
		// print invalid input format
		printf("make_guess: invalid guess\n");
    return 0;
  }
}


